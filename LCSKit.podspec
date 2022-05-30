Pod::Spec.new do |s|

  s.name         = "LCSKit"
  s.version      = "0.0.1"
  s.summary      = "MLCKit的Swift版本，封装一些常用的iOS方法。"

  s.homepage     = "https://github.com/mlcldh/LCSKit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "mlcldh" => "1228225993@qq.com" }

  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'

  s.source       = { :git => "https://github.com/mlcldh/LCSKit.git", :tag => s.version.to_s }
#  s.source_files = "LCSKit"
  s.module_name   = 'LCSKit'
#  s.source_files = 'LCSKit/LCSKit.swift'
  s.swift_version = '5.3'
  
  s.requires_arc = true
  s.static_framework = true
  
  s.xcconfig = { "SWIFT_INCLUDE_PATHS" => "$(PODS_ROOT)/HCKit-Swift/Module"}
  
  s.subspec 'Cache' do |ss|
    ss.source_files = 'LCSKit/Cache/*.{swift}'
    ss.dependency 'YYCache'
    ss.frameworks = 'Foundation'
  end
  
  s.subspec 'Constant' do |ss|
    ss.source_files = 'LCSKit/Constant/*.{swift}'
    ss.frameworks = 'UIKit'
  end
  
  s.subspec 'Extension' do |ss|
    ss.source_files = 'LCSKit/Extension/*.{swift}'
    ss.frameworks = 'UIKit'
  end
  
  s.subspec 'LocalFolder' do |ss|
    ss.source_files = 'LCSKit/LocalFolder/*.{swift}'
    ss.dependency 'SnapKit'
    ss.frameworks = 'UIKit'
  end
  
#  s.subspec 'Proxy' do |ss|
#    ss.source_files = 'LCSKit/Proxy/*.{swift}'
#    ss.frameworks = 'Foundation'
#  end
  
  s.subspec 'Photos' do |ss|
    ss.source_files = 'LCSKit/Photos/*.{swift}'
    ss.frameworks = 'AVFoundation', 'Photos'
    ss.dependency 'LCSKit/Utility'
  end
  
  s.subspec 'TableView' do |ss|
    ss.source_files = 'LCSKit/TableView/*.{swift}'
    ss.frameworks = 'UIKit'
    ss.dependency 'SnapKit'
    ss.dependency 'MJRefresh'
    ss.dependency 'LCSKit/Extension'
    ss.dependency 'LCSKit/UI'
  end
  
  s.subspec 'UI' do |ss|
    ss.source_files = 'LCSKit/UI/*.{swift}'
    ss.frameworks = 'UIKit'
    ss.dependency 'SnapKit'
    ss.dependency 'LCSKit/Extension'
  end
  
  s.subspec 'Utility' do |ss|
    ss.source_files = 'LCSKit/Utility/*.{swift}'
    ss.frameworks = 'UIKit', 'AdSupport', 'CoreTelephony'
  end
    
  s.swift_version = '5.2.2'
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

end
