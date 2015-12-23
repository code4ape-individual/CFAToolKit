//
//  CFABluetoothHelper.h
//  CFAToolKit
//
//  Created by Jack on 15/11/24.
//  Copyright © 2015年 code4ape-individual. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BLUETOOTH_EVENT_KEY    @"BlueToothEventKey"
#define BLUETOOTH_EVENT_READ   @"BlueToothEventRead"

@class CBCentralManager;
@class CBPeripheral;

@interface CFABluetoothHelper : NSObject

@property (nonatomic,strong) CBCentralManager *manager;
@property (nonatomic,strong) NSMutableArray *discoveryPeripherals;    // 发现的外设
@property (nonatomic,strong) CBPeripheral *peripheral;  // 已连接的外设

+(instancetype)shareInstance;

/// 扫描外设
-(BOOL)scanPeripheralsWithTimeout:(float)timeout;

/// 连接外设
-(void)connectPeripheral:(CBPeripheral *)peripheral;

/// 写数据
-(void)writeValue:(NSData *)value;

@end
