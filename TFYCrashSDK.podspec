
Pod::Spec.new do |spec|

  spec.name         = "TFYCrashSDK"

  spec.version      = "1.2.4"

  spec.summary      = "完美处理项目闪退问题，后期会持续更新。最低iOS支持iOS12系统以上."

 
  spec.description  = <<-DESC
                       完美处理项目闪退问题，后期会持续更新。最低iOS支持iOS12系统以上.
                   DESC

  spec.homepage     = "https://github.com/13662049573/TFYCrashException"
  
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  
  spec.author       = { "田风有" => "420144542@qq.com" }
  
  spec.ios.deployment_target = "12.0"
  spec.osx.deployment_target = "11.0"
  spec.watchos.deployment_target = "2.0"
  spec.tvos.deployment_target = "9.0"

  spec.source       = { :git => "https://github.com/13662049573/TFYCrashException.git", :tag => "#{spec.version}" }

  spec.source_files = "TFYCrashException/TFYCrashSDK/TFYCrashSDK.h"
  
  spec.default_subspec = 'TFYCrashSDK'
  spec.subspec 'TFYCrashSDK' do |sss|
    sss.dependency 'TFYCrashSDK/TFYARC'
    sss.dependency 'TFYCrashSDK/TFYItools'
    sss.dependency 'TFYCrashSDK/TFYMain'
    sss.dependency 'TFYCrashSDK/TFYMRC'
  end

  spec.subspec 'TFYARC' do |sss|
    sss.requires_arc = true
    sss.source_files  = "TFYCrashException/TFYCrashSDK/TFYARC/*.{h,m}"
    sss.dependency 'TFYCrashSDK/TFYMain'
    sss.dependency 'TFYCrashSDK/TFYItools'
  end

  spec.subspec 'TFYItools' do |sss|
    sss.requires_arc = true
    sss.source_files  = "TFYCrashException/TFYCrashSDK/TFYItools/*.{h,m}"
  end

  spec.subspec 'TFYMain' do |sss|
    sss.requires_arc = true
    sss.source_files  = "TFYCrashException/TFYCrashSDK/TFYMain/*.{h,m}"
  end

  spec.subspec 'TFYMRC' do |sss|
    sss.requires_arc = false
    sss.source_files  = "TFYCrashException/TFYCrashSDK/TFYMRC/*.{h,m}"
    sss.dependency 'TFYCrashSDK/TFYItools'
    sss.dependency 'TFYCrashSDK/TFYMain'
  end

end
