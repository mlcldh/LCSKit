Pod::Spec.new do |s|
  
  s.name         = "LCDemo"
  s.version      = "0.0.1"
  s.summary      = "LCSKit的Demo。"
  
  s.homepage     = "https://github.com/mlcldh/LCSKit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  
  s.author             = { "mlcldh" => "1228225993@qq.com" }
  
  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  
  s.source       = { :git => "https://github.com/mlcldh/LCSKit.git", :tag => s.version.to_s }
#  s.source_files = "LCSKit"
  s.module_name   = 'LCDemo'
  s.source_files = 'LCDemo/**/*'
  s.frameworks = 'UIKit'
  s.dependency 'LCSKit'
  s.swift_version = '5.3'
  
  s.requires_arc = true
  s.static_framework = true
  
  s.xcconfig = { "SWIFT_INCLUDE_PATHS" => "$(PODS_ROOT)/HCKit-Swift/Module"}
  
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  
end
