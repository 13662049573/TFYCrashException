# TFYCrashException

[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-ObjC-brightgreen.svg?style=flat)](https://developer.apple.com/documentation/objectivec)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)

TFYCrashException 是一个用于防止 iOS 应用崩溃的轻量级框架。它通过 Method Swizzling 技术，优雅地处理常见的崩溃场景，让您的应用更加稳定可靠。

## 特性

- [x] 防止容器类崩溃 (NSArray/NSMutableArray/NSDictionary/NSMutableDictionary/NSSet/NSMutableSet)
- [x] 防止字符串操作崩溃 (NSString/NSMutableString/NSAttributedString/NSMutableAttributedString)
- [x] 防止 KVO 相关崩溃
- [x] 防止 NSTimer 循环引用
- [x] 防止 NSNotification 相关崩溃
- [x] 防止未识别的选择器调用崩溃 (Unrecognized Selector)
- [x] 支持自定义异常处理
- [x] 支持日志记录和文件存储
- [x] 支持开发环境和生产环境的差异化处理
- [x] 零侵入性的API设计

## 安装

### CocoaPods

```ruby
pod 'TFYCrashException'
```

### 手动安装

将 TFYCrashSDK 文件夹拖入项目中即可。

## 使用方法

### 基本配置

```objc
#import <TFYCrashSDK.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 配置需要防护的异常类型
    [TFYCrashException configExceptionCategory:TFYCrashExceptionGuardAll];
    
    // 开启异常防护
    [TFYCrashException startGuardException];
    
    // 注册异常处理回调
    [TFYCrashException registerExceptionHandle:self];
    
    return YES;
}
```

### 异常处理回调

```objc
// 实现 TFYCrashExceptionHandle 协议
- (void)crashhandleCrashException:(NSString*)exceptionMessage exceptionCategory:(TFYCrashExceptionGuardCategory)exceptionCategory extraInfo:(nullable NSDictionary*)info {
    // 处理异常信息
    NSLog(@"Crash Exception: %@", exceptionMessage);
    NSLog(@"Category: %ld", (long)exceptionCategory);
    NSLog(@"Extra Info: %@", info);
}
```

### 日志配置

```objc
// 设置日志写入
[TFYLogTool tfy_setWriteToFileOn:YES bindUserId:@"userId"];

// 强制写入日志(不分环境)
[TFYLogTool tfy_setForceWirteToFile:YES];
```

## 防护类型说明

- `TFYCrashExceptionGuardUnrecognizedSelector`: 防止未识别的选择器调用崩溃
- `TFYCrashExceptionGuardDictionaryContainer`: 防止字典操作崩溃
- `TFYCrashExceptionGuardArrayContainer`: 防止数组操作崩溃
- `TFYCrashExceptionGuardKVOCrash`: 防止 KVO 崩溃
- `TFYCrashExceptionGuardNSTimer`: 防止 NSTimer 相关崩溃
- `TFYCrashExceptionGuardNSNotificationCenter`: 防止通知相关崩溃
- `TFYCrashExceptionGuardNSStringContainer`: 防止字符串操作崩溃

## 高级功能

### 自定义异常处理

```objc
// 设置异常终止开关
[TFYCrashException setExceptionWhenTerminate:YES];

// 获取当前日志内容
NSArray<TFYLogContentModel *> *logs = [TFYLogTool tfy_getCurrentLogContents];
```

### 日志管理

- 支持自动清理过期日志
- 支持设置最大日志存储大小
- 支持强制保留最近日志
- 支持按用户区分日志文件

## 注意事项

1. 建议在 DEBUG 环境下开启异常终止，方便及时发现问题
2. 生产环境建议关闭异常终止，保证应用正常运行
3. 合理配置日志存储策略，避免占用过多存储空间
4. 需要添加 `-ObjC` 链接标志

## 系统要求

- iOS 15.0+
- Xcode 15.0+
- macOS 12.0+
- watchOS 10.0+
- tvOS 15.0+


## 许可证

TFYCrashException 基于 MIT 许可证开源。详细内容请查看 [LICENSE](LICENSE) 文件。

## 作者

田风有 13662912233@163.com

## 致谢

感谢所有为这个项目做出贡献的开发者。
