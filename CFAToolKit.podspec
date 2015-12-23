#
# Be sure to run `pod lib lint CFAToolKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CFAToolKit"
  s.version          = "0.1.0"
  s.summary          = "Personal kit."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC

    个人工具集，目前包括Baisc、service、CustomUI三部分。
                       DESC

  s.homepage         = "https://github.com/code4ape-individual/CFAToolKit"
  # s.screenshots    = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "code4ape" => "junjie_deng@qq.com" }

  s.source           = { :git => "https://github.com/code4ape-individual/CFAToolKit.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'CFAToolKit' => ['Pod/Assets/*.png']
  }

  s.subspec 'Basic' do |sp|
    sp.source_files = 'Pod/Classes/Basic/**/*'
  end

  s.subspec 'Service' do |sp|
    sp.source_files = 'Pod/Classes/Service/**/*'
  end

  s.subspec 'CustomUI' do |sp|
    sp.source_files = 'Pod/Classes/CustomUI/**/*'
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
