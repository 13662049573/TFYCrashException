
Pod::Spec.new do |spec|

  spec.name         = "TFYCrashSDK"

  spec.version      = "1.0.2"

  spec.summary      = "完美处理项目闪退问题，后期会持续更新。"

 
  spec.description  = <<-DESC
  完美处理项目闪退问题，后期会持续更新。
                   DESC

  spec.homepage     = "https://github.com/13662049573/TFYCrashException"
  
  spec.license      = "MIT"
  
  spec.author             = { "田风有" => "420144542@qq.com" }
  
  spec.ios.deployment_target = "12.0"
  spec.osx.deployment_target = "11"
  spec.watchos.deployment_target = "5.0"
  spec.tvos.deployment_target = "11.0"

  spec.source       = { :git => "https://github.com/13662049573/TFYCrashException.git", :tag => spec.version }

  
  spec.default_subspec = 'TFYCrashSDK'

  spec.subspec 'TFYCrashSDK' do |ss|
    ss.dependency 'TFYCrashException/TFYSwizzle'
    ss.dependency 'TFYCrashException/TFYARC'
    ss.dependency 'TFYCrashException/TFYMRC'
    ss.dependency 'TFYCrashException/TFYMain'
    ss.dependency 'TFYCrashException/TFYDeallocBlock'
  end

  spec.subspec 'TFYARC' do |ss|
    ss.requires_arc = true
    ss.source_files  = "TFYCrashException/TFYCrashSDK/TFYARC/*.{h,m}"
    ss.dependency 'TFYCrashException/TFYSwizzle'
    ss.dependency 'TFYCrashException/TFYMain'
    ss.dependency 'TFYCrashException/TFYDeallocBlock'
  end

  spec.subspec 'TFYSwizzle' do |ss|
    ss.requires_arc = true
    ss.source_files  = "TFYCrashException/TFYCrashSDK/TFYSwizzle/*.{h,m}"
  end

  spec.subspec 'TFYMain' do |ss|
    ss.requires_arc = true
    ss.public_header_files = "TFYCrashException/TFYCrashSDK/TFYMain/TFYCrashException.h"
    ss.source_files  = "TFYCrashException/TFYCrashSDK/TFYMain/*.{h,m}"
  end

  spec.subspec 'TFYMRC' do |ss|
    ss.requires_arc = false
    ss.source_files  = "TFYCrashException/TFYCrashSDK/TFYMRC/*.{h,m}"
    ss.dependency 'TFYCrashException/TFYSwizzle'
    ss.dependency 'TFYCrashException/TFYMain'
  end

  spec.subspec 'TFYDeallocBlock' do |ss|
    ss.requires_arc = true
    ss.source_files  = "TFYCrashException/TFYCrashSDK/TFYDeallocBlock/*.{h,m}"
  end


end
