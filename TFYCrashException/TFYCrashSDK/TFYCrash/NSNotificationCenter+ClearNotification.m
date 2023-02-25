//
//  NSNotificationCenter+ClearNotification.m
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//


#import "NSNotificationCenter+ClearNotification.h"
#import "NSObject+Hook.h"
#import "NSObject+DeallocBlock.h"
#import "TFYCrashExceptionMacros.h"
#import <objc/runtime.h>

TFYCrashSYNTH_DUMMY_CLASS(NSNotificationCenter_ClearNotification)

@implementation NSNotificationCenter (ClearNotification)

+ (void)tfy_swizzleNSNotificationCenter{
    [self tfy_crashswizzleInstanceMethod:@selector(addObserver:selector:name:object:) withSwizzledBlock:^id(TFYCrashSwizzleObject *swizzleInfo) {
        return ^(__unsafe_unretained id self,id observer,SEL aSelector,NSString* aName,id anObject){
            [self processAddObserver:observer selector:aSelector name:aName object:anObject swizzleInfo:swizzleInfo];
        };
    }];
}

- (void)processAddObserver:(id)observer selector:(SEL)aSelector name:(NSNotificationName)aName object:(id)anObject swizzleInfo:(TFYCrashSwizzleObject*)swizzleInfo{
    
    if (!observer) {
        return;
    }
    
    if ([observer isKindOfClass:NSObject.class]) {
        __unsafe_unretained typeof(observer) unsafeObject = observer;
        [observer tfy_deallocBlock:^{
            [[NSNotificationCenter defaultCenter] removeObserver:unsafeObject];
        }];
    }
    
    void(*originIMP)(__unsafe_unretained id,SEL,id,SEL,NSString*,id);
    originIMP = (__typeof(originIMP))[swizzleInfo getOriginalImplementation];
    if (originIMP != NULL) {
        originIMP(self,swizzleInfo.selector,observer,aSelector,aName,anObject);
    }
}

@end
