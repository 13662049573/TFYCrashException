//
//  TFYCrashExceptionProxy.m
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//

#import "TFYCrashExceptionProxy.h"
#import <mach-o/dyld.h>
#import <objc/runtime.h>

__attribute__((overloadable)) void handleCrashException(NSString* exceptionMessage){
    [[TFYCrashExceptionProxy shareExceptionProxy] handleCrashException:exceptionMessage extraInfo:@{}];
}

__attribute__((overloadable)) void handleCrashException(NSString* exceptionMessage,NSDictionary* extraInfo){
    [[TFYCrashExceptionProxy shareExceptionProxy] handleCrashException:exceptionMessage extraInfo:extraInfo];
}

__attribute__((overloadable)) void handleCrashException(TFYCrashExceptionGuardCategory exceptionCategory, NSString* exceptionMessage,NSDictionary* extraInfo){
    [[TFYCrashExceptionProxy shareExceptionProxy] handleCrashException:exceptionMessage exceptionCategory:exceptionCategory extraInfo:extraInfo];
}

__attribute__((overloadable)) void handleCrashException(TFYCrashExceptionGuardCategory exceptionCategory, NSString* exceptionMessage){
    [[TFYCrashExceptionProxy shareExceptionProxy] handleCrashException:exceptionMessage exceptionCategory:exceptionCategory extraInfo:nil];
}

/**
 Get application base address,the application different base address after started
 
 @return base address
 */
uintptr_t get_load_address(void) {
    const struct mach_header *exe_header = NULL;
    for (uint32_t i = 0; i < _dyld_image_count(); i++) {
        const struct mach_header *header = _dyld_get_image_header(i);
        if (header->filetype == MH_EXECUTE) {
            exe_header = header;
            break;
        }
    }
    return (uintptr_t)exe_header;
}

/**
 Address Offset

 @return slide address
 */
uintptr_t get_slide_address(void) {
    uintptr_t vmaddr_slide = 0;
    for (uint32_t i = 0; i < _dyld_image_count(); i++) {
        const struct mach_header *header = _dyld_get_image_header(i);
        if (header->filetype == MH_EXECUTE) {
            vmaddr_slide = _dyld_get_image_vmaddr_slide(i);
            break;
        }
    }
    
    return (uintptr_t)vmaddr_slide;
}

@interface TFYCrashExceptionProxy (){
    NSMutableSet* _currentClassesSet;
    NSMutableSet* _blackClassesSet;
    NSInteger _currentClassSize;
    dispatch_semaphore_t _classArrayLock;//Protect _blackClassesSet and _currentClassesSet atomic
    dispatch_semaphore_t _swizzleLock;//Protect swizzle atomic
}

@end

@implementation TFYCrashExceptionProxy

+(instancetype)shareExceptionProxy{
    static dispatch_once_t onceToken;
    static id exceptionProxy;
    dispatch_once(&onceToken, ^{
        exceptionProxy = [[self alloc] init];
    });
    return exceptionProxy;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _blackClassesSet = [NSMutableSet new];
        _currentClassesSet = [NSMutableSet new];
        _currentClassSize = 0;
        _classArrayLock = dispatch_semaphore_create(1);
        _swizzleLock = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)handleCrashException:(NSString *)exceptionMessage exceptionCategory:(TFYCrashExceptionGuardCategory)exceptionCategory extraInfo:(NSDictionary *)info{
    if (!exceptionMessage) {
        return;
    }
    
    NSArray* callStack = [NSThread callStackSymbols];
    NSString* callStackString = [NSString stringWithFormat:@"%@",callStack];
    
    uintptr_t loadAddress =  get_load_address();
    uintptr_t slideAddress =  get_slide_address();
    
    NSString* exceptionResult = [NSString stringWithFormat:@"%ld\n%ld\n%@\n%@",loadAddress,slideAddress,exceptionMessage,callStackString];
    
    
    if ([self.delegate respondsToSelector:@selector(handleCrashException:extraInfo:)]){
        [self.delegate handleCrashException:exceptionResult extraInfo:info];
    }
    
    if ([self.delegate respondsToSelector:@selector(handleCrashException:exceptionCategory:extraInfo:)]) {
        [self.delegate handleCrashException:exceptionResult exceptionCategory:exceptionCategory extraInfo:info];
    }
    
#ifdef DEBUG
    NSLog(@"================================TFYCrashException Start==================================");
    NSLog(@"TFYCrashException Type:%ld",(long)exceptionCategory);
    NSLog(@"TFYCrashException Description:%@",exceptionMessage);
    NSLog(@"TFYCrashException Extra info:%@",info);
    NSLog(@"TFYCrashException CallStack:%@",callStack);
    NSLog(@"================================TFYCrashException End====================================");
    if (self.exceptionWhenTerminate) {
        NSAssert(NO, @"");
    }
#endif
}

- (void)handleCrashException:(NSString *)exceptionMessage extraInfo:(nullable NSDictionary *)info{
    [self handleCrashException:exceptionMessage exceptionCategory:TFYCrashExceptionGuardNone extraInfo:info];
}

- (void)setIsProtectException:(BOOL)isProtectException{
    dispatch_semaphore_wait(_swizzleLock, DISPATCH_TIME_FOREVER);
    if (_isProtectException != isProtectException) {
        _isProtectException = isProtectException;
        
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wundeclared-selector"
        
        if(self.exceptionGuardCategory & TFYCrashExceptionGuardArrayContainer){
            [NSArray performSelector:@selector(tfy_swizzleNSArray)];
            [NSMutableArray performSelector:@selector(tfy_swizzleNSMutableArray)];
            [NSSet performSelector:@selector(tfy_swizzleNSSet)];
            [NSMutableSet performSelector:@selector(tfy_swizzleNSMutableSet)];
        }
        if(self.exceptionGuardCategory & TFYCrashExceptionGuardDictionaryContainer){
            [NSDictionary performSelector:@selector(tfy_swizzleNSDictionary)];
            [NSMutableDictionary performSelector:@selector(tfy_swizzleNSMutableDictionary)];
        }
        if(self.exceptionGuardCategory & TFYCrashExceptionGuardUnrecognizedSelector){
            [NSObject performSelector:@selector(tfy_swizzleUnrecognizedSelector)];
        }
        
        if (self.exceptionGuardCategory & TFYCrashExceptionGuardKVOCrash) {
            [NSObject performSelector:@selector(tfy_swizzleKVOCrash)];
        }
        
        if (self.exceptionGuardCategory & TFYCrashExceptionGuardNSTimer) {
            [NSTimer performSelector:@selector(tfy_swizzleNSTimer)];
        }
        
        if (self.exceptionGuardCategory & TFYCrashExceptionGuardNSNotificationCenter) {
            [NSNotificationCenter performSelector:@selector(tfy_swizzleNSNotificationCenter)];
        }
        
        if (self.exceptionGuardCategory & TFYCrashExceptionGuardNSStringContainer) {
            [NSString performSelector:@selector(tfy_swizzleNSString)];
            [NSMutableString performSelector:@selector(tfy_swizzleNSMutableString)];
            [NSAttributedString performSelector:@selector(tfy_swizzleNSAttributedString)];
            [NSMutableAttributedString performSelector:@selector(tfy_swizzleNSMutableAttributedString)];
        }
        #pragma clang diagnostic pop
    }
    dispatch_semaphore_signal(_swizzleLock);
}

- (void)setExceptionGuardCategory:(TFYCrashExceptionGuardCategory)exceptionGuardCategory{
    if (_exceptionGuardCategory != exceptionGuardCategory) {
        _exceptionGuardCategory = exceptionGuardCategory;
    }
}


@end
