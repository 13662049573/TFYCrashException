//
//  NSMutableSet+MutableSetHook.m
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//


#import "NSMutableSet+MutableSetHook.h"
#import "NSObject+SwizzleHook.h"
#import <objc/runtime.h>
#import "TFYCrashExceptionProxy.h"
#import "TFYCrashExceptionMacros.h"

TFYCrashSYNTH_DUMMY_CLASS(NSMutableSet_MutableSetHook)

@implementation NSMutableSet (MutableSetHook)

+ (void)tfy_swizzleNSMutableSet{
    NSMutableSet* instanceObject = [NSMutableSet new];
    Class cls =  object_getClass(instanceObject);
    
    swizzleInstanceMethod(cls,@selector(addObject:), @selector(hookAddObject:));
    swizzleInstanceMethod(cls,@selector(removeObject:), @selector(hookRemoveObject:));
}

- (void) hookAddObject:(id)object {
    if (object) {
        [self hookAddObject:object];
    } else {
        handleCrashException(TFYCrashExceptionGuardArrayContainer,@"NSSet addObject nil object");
    }
}

- (void) hookRemoveObject:(id)object {
    if (object) {
        [self hookRemoveObject:object];
    } else {
        handleCrashException(TFYCrashExceptionGuardArrayContainer,@"NSSet removeObject nil object");
    }
}

@end
