
Pod::Spec.new do |spec|

  spec.name         = "TFYCrashSDK"

  spec.version      = "1.0.4"

  spec.summary      = "完美处理项目闪退问题，后期会持续更新。最低iOS支持iOS12系统以上"

 
  spec.description  = <<-DESC
  完美处理项目闪退问题，后期会持续更新。最低iOS支持iOS12系统以上
                   DESC

  spec.homepage     = "https://github.com/13662049573/TFYCrashException"
  
  spec.license      = "MIT"
  
  spec.author       = { "田风有" => "420144542@qq.com" }
  
  spec.ios.deployment_target = "12.0"
  spec.osx.deployment_target = "11"
  spec.watchos.deployment_target = "5.0"
  spec.tvos.deployment_target = "11.0"

  spec.source       = { :git => "https://github.com/13662049573/TFYCrashException.git", :tag => spec.version }

  
  spec.public_header_files = "TFYCrashException/TFYCrashSDK/TFYCrashSDK.h"

  spec.subspec 'TFYCrashSDK' do |sss|

    sss.subspec 'TFYARC' do |ss|
      ss.requires_arc = true
      ss.source_files  = "TFYCrashException/TFYCrashSDK/TFYARC/*.{h,m}"
      ss.dependency 'TFYCrashSDK/TFYSwizzle'
      ss.dependency 'TFYCrashSDK/TFYMain'
      ss.dependency 'TFYCrashSDK/TFYDeallocBlock'
    end
  
    sss.subspec 'TFYSwizzle' do |ss|
      ss.requires_arc = true
      ss.source_files  = "TFYCrashException/TFYCrashSDK/TFYSwizzle/*.{h,m}"
    end
  
    sss.subspec 'TFYMain' do |ss|
      ss.requires_arc = true
      ss.source_files  = "TFYCrashException/TFYCrashSDK/TFYMain/*.{h,m}"
    end
  
    sss.subspec 'TFYMRC' do |ss|
      ss.requires_arc = false
      ss.source_files  = "TFYCrashException/TFYCrashSDK/TFYMRC/*.{h,m}"
      ss.dependency 'TFYCrashSDK/TFYSwizzle'
      ss.dependency 'TFYCrashSDK/TFYMain'
    end
  
    sss.subspec 'TFYDeallocBlock' do |ss|
      ss.requires_arc = true
      ss.source_files  = "TFYCrashException/TFYCrashSDK/TFYDeallocBlock/*.{h,m}"
    end

  end

end
