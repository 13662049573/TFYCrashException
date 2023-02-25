
Pod::Spec.new do |spec|

  spec.name         = "TFYCrashSDK"

  spec.version      = "1.1.2"

  spec.summary      = "完美处理项目闪退问题，后期会持续更新。最低iOS支持iOS12系统以上."

 
  spec.description  = <<-DESC
                       完美处理项目闪退问题，后期会持续更新。最低iOS支持iOS12系统以上.
                   DESC

  spec.homepage     = "https://github.com/13662049573/TFYCrashException"
  
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  
  spec.author       = { "田风有" => "420144542@qq.com" }
  
  spec.ios.deployment_target = "12.0"
  spec.osx.deployment_target = "11.0"
  spec.watchos.deployment_target = "5.0"
  spec.tvos.deployment_target = "11.0"

  spec.source       = { :git => "https://github.com/13662049573/TFYCrashException.git", :tag => "#{spec.version}" }

  spec.subspec 'TFYCrashSDK' do |sss|
    sss.source_files = "TFYCrashException/TFYCrashSDK/TFYCrashSDK.h"
    
    sss.subspec 'TFYHook' do |ss|
      ss.source_files  = "TFYCrashException/TFYCrashSDK/TFYHook/**/*.{h,m}"
    end

    sss.subspec 'TFYMain' do |ss|
      ss.source_files  = "TFYCrashException/TFYCrashSDK/TFYMain/**/*.{h,m}"
    end

    sss.subspec 'TFYARC' do |ss|
      ss.source_files  = "TFYCrashException/TFYCrashSDK/TFYARC/**/*.{h,m}"
      ss.dependency 'TFYCrashSDK/TFYMain'
      ss.dependency 'TFYCrashSDK/TFYHook'
    end
  
    sss.subspec 'TFYMRC' do |ss|
      ss.source_files  = "TFYCrashException/TFYCrashSDK/TFYMRC/**/*.{h,m}"
      ss.dependency 'TFYCrashSDK/TFYMain'
      ss.dependency 'TFYCrashSDK/TFYHook'
    end

  end

  spec.requires_arc = true

  spec.xcconfig = {"ENABLE_STRICT_OBJC_MSGSEND" => "NO", 'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) COCOAPODS=1 NDEBUG=1 _DEBUG_TAG_'}

end
