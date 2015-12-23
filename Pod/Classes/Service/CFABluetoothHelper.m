//
//  CFABluetoothHelper.m
//  CFAToolKit
//
//  Created by Jack on 15/11/24.
//  Copyright © 2015年 code4ape-individual. All rights reserved.
//

#import "CFABluetoothHelper.h"
#import <CoreBluetooth/CoreBluetooth.h>


//ISSC
#define ISSC_SERVICE_UUID   0xFFF0
#define ISSC_CHAR_RX_UUID   0xFFF1
#define ISSC_CHAR_TX_UUID   0xFFF2


@interface CFABluetoothHelper () <CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic,strong) NSTimer *timer;

@end


@implementation CFABluetoothHelper

+(instancetype)shareInstance
{
    static CFABluetoothHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[CFABluetoothHelper alloc] init];
        [helper p_setup];
    });
    return helper;
}

-(void)p_setup
{
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    self.discoveryPeripherals = [NSMutableArray array];
}

#pragma mark - Public Method
// 扫描外设
-(BOOL)scanPeripheralsWithTimeout:(float)timeout
{
    if (self.manager.state != CBCentralManagerStatePoweredOn)
    {
        NSLog(@"不能扫描外设！当前主机状态：%@",[self p_centralManagerStateToString:self.manager.state]);
        return NO;
    }
    
    if (self.timer)
    {
        NSLog(@"不能重复扫描，正在扫描中...");
        return NO;
    }
    
    // 清空发现数组
    [self.discoveryPeripherals removeAllObjects];
    
    // 断开已连接设备
    [self p_cancelConnectedPeripheral];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(p_timesup) userInfo:nil repeats:NO];
    
    // 扫描
    NSLog(@"开始扫描...");
    
    [self.manager scanForPeripheralsWithServices:nil options:0];
    
    return YES;
}

// 连接外设
-(void)connectPeripheral:(CBPeripheral *)peripheral
{
    if ([peripheral.name isEqualToString:@"Chipsea-BLE"])
    {
        self.peripheral = peripheral;
        self.peripheral.delegate = self;
        [self.manager connectPeripheral:peripheral options:nil];
    }
}

// 写数据
-(void)writeValue:(NSData *)value
{
    // 已连接
    if (self.peripheral.state == CBPeripheralStateConnected)
    {
        for (CBService *service in self.peripheral.services)
        {
            // FFF0服务
            if ([self CBUUIDToInt:service.UUID] == ISSC_SERVICE_UUID)
            {
                for (CBCharacteristic *characteristic in service.characteristics)
                {
                    // FFF2特征
                    if ([self CBUUIDToInt:characteristic.UUID] == ISSC_CHAR_TX_UUID)
                    {
                        NSLog(@"写入数据:%@",value);
                        [self.peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
                    }
                }
            }
        }
    }
}


#pragma mark - private method
-(void)p_cancelConnectedPeripheral
{
    if (self.peripheral)
    {
        [self.manager cancelPeripheralConnection:self.peripheral];
    }
}

-(void)p_timesup
{
    [self.timer invalidate];
    self.timer = nil;
    [self.manager stopScan];
    
    NSLog(@"扫描结束");
    
    for (CBPeripheral *peripheral in self.discoveryPeripherals)
    {
        NSLog(@"已发现设备：%@",peripheral.name);
    }
    
    // 发送通知，扫描结束
    [[NSNotificationCenter defaultCenter] postNotificationName:BLUETOOTH_EVENT_KEY
                                                        object:nil
                                                      userInfo:@{@"type":@"scanFinished"}];
}


#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"状态改变: %ld (%@)\r\n",(long)central.state,[self p_centralManagerStateToString:central.state]);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"已发现:%@",peripheral.name);
    
    if ([peripheral.name isEqualToString:@"Chipsea-BLE"])
    {
        [self.discoveryPeripherals addObject:peripheral];
        
        // 发送通知，断开连接
        [[NSNotificationCenter defaultCenter] postNotificationName:BLUETOOTH_EVENT_KEY
                                                            object:nil
                                                          userInfo:@{@"type":@"discovered"}];
    }
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"已连接:%@",peripheral.name);
    
    // 记录外设
    self.peripheral = peripheral;
    
    // 搜索服务
    [self.peripheral discoverServices:nil];
    
    // 发送通知，断开连接
    [[NSNotificationCenter defaultCenter] postNotificationName:BLUETOOTH_EVENT_KEY
                                                        object:nil
                                                      userInfo:@{@"type":@"connected"}];
}

// 断开连接
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    // 清空连接外设
    if (self.peripheral == peripheral)
    {
        self.peripheral = nil;
        
        // 发送通知，断开连接
        [[NSNotificationCenter defaultCenter] postNotificationName:BLUETOOTH_EVENT_KEY
                                                            object:nil
                                                          userInfo:@{@"type":@"disconnected"}];
    }
}

// 连接失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    
}


- (NSString *)p_centralManagerStateToString:(NSInteger)state {
    switch(state) {
        case CBCentralManagerStateUnknown:
            return @"State unknown";
        case CBCentralManagerStateResetting:
            return @"State resetting";
        case CBCentralManagerStateUnsupported:
            return @"State BLE unsupported";
        case CBCentralManagerStateUnauthorized:
            return @"State unauthorized";
        case CBCentralManagerStatePoweredOff:
            return @"State BLE powered off";
        case CBCentralManagerStatePoweredOn:
            return @"State powered up and ready";
        default:
            return @"State unknown";
    }
    return @"Unknown state";
}

#pragma mark - peripheral Delegate
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (!error)
    {
        // 遍历发现所有service的characteristics
        for (CBService *service in peripheral.services)
        {
            NSLog(@"发现服务:%@",service.UUID);
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
    else
    {
        NSLog(@"发现Service错误:%@",error);
    }
}


-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (!error)
    {
        NSLog(@"发现特征:%@",service.characteristics);
        
        for (CBCharacteristic *characteristic in service.characteristics)
        {
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
    else
    {
        NSLog(@"发现特征错误:%@",error);
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (!error)
    {
        UInt16 UUIDinInt = [self CBUUIDToInt:characteristic.UUID];
        NSLog(@"服务更新:%x 数据:%@",UUIDinInt,characteristic.value);
        switch (UUIDinInt) {
            case 0xfff1:{
                UInt32 hexData = [self hexDataFromData:characteristic.value];
                [[NSNotificationCenter defaultCenter] postNotificationName:BLUETOOTH_EVENT_READ
                                                                    object:nil
                                                                  userInfo:@{
                                                                             @"type":@"battery",
                                                                             @"data":@(hexData)
                                                                             }];
            }
                break;
                
            default:
                break;
        }
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (!error)
    {
        NSLog(@"已写入：%@",characteristic.UUID);
    }
}


-(UInt32)hexDataFromData:(NSData *)data
{
    UInt32 hexData = 0;
    UInt32 result = 0;
    [data getBytes:&hexData length:sizeof(hexData)];
    
    result |= (hexData & 0x000000ff) << 24;
    result |= (hexData & 0x0000ff00) << 8;
    result |= (hexData & 0x00ff0000) >> 8;
    result |= (hexData & 0xff000000) >> 24;
    
    return result;
}

// UUID转16位int
-(UInt16)CBUUIDToInt:(CBUUID *) UUID {
    char b1[2];
    [UUID.data getBytes:b1 length:sizeof(b1)];
    return ((b1[0] << 8) | b1[1]);
}

@end
