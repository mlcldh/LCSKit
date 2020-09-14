Pod::Spec.new do |s|

  s.name         = "LCSKit"
  s.version      = "0.0.1"
  s.summary      = "MLCKit的Swift版本，封装一些常用的iOS方法。"

  s.homepage     = "https://github.com/mlcldh/LCSKit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "mlcldh" => "1228225993@qq.com" }

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'

  s.source       = { :git => "https://github.com/mlcldh/LCSKit.git", :tag => s.version.to_s }
#  s.source_files = "LCSKit"
  s.source_files = 'LCSKit/LCSKit.h'

  s.requires_arc = true
  s.static_framework = true
  
#  s.subspec 'Cache' do |ss|
#    ss.source_files = 'LCSKit/Cache/*.{swift}'
#    ss.dependency 'YYCache'
#    ss.frameworks = 'Foundation'
#  end
  
  s.subspec 'Category' do |ss|
    ss.source_files = 'LCSKit/Category/*.{swift}'
    ss.frameworks = 'UIKit'
  end
  
  s.subspec 'LocalFolder' do |ss|
    ss.source_files = 'LCSKit/LocalFolder/*.{swift}'
    ss.frameworks = 'UIKit'
  end
  
  s.subspec 'Macro' do |ss|
    ss.source_files = 'LCSKit/Macro/*.{swift}'
    ss.frameworks = 'UIKit'
  end
  
  s.subspec 'Proxy' do |ss|
    ss.source_files = 'LCSKit/Proxy/*.{swift}'
    ss.frameworks = 'Foundation'
  end
  
  s.subspec 'UI' do |ss|
    ss.source_files = 'LCSKit/UI/*.{swift}'
    ss.frameworks = 'UIKit'
    ss.dependency 'SnapKit'
  end
  
  s.subspec 'Utility' do |ss|
    ss.source_files = 'LCSKit/Utility/*.{swift}'
    ss.frameworks = 'UIKit', 'AdSupport', 'CoreTelephony'
  end
  
  s.subspec 'PhotoPermission' do |ss|
    ss.source_files = 'LCSKit/PhotoPermission/*.{swift}'
    ss.frameworks = 'AVFoundation', 'Photos'
    ss.dependency 'LCSKit/Utility'
  end
  
  s.swift_version = '5.2.2'
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

end
