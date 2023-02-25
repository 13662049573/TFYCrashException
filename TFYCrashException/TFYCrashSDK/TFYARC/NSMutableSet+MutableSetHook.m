//
//  NSMutableSet+MutableSetHook.m
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//


#import "NSMutableSet+MutableSetHook.h"
#import "NSObject+Hook.h"
#import <objc/runtime.h>
#import "TFYCrashExceptionProxy.h"
#import "TFYCrashExceptionMacros.h"

TFYCrashSYNTH_DUMMY_CLASS(NSMutableSet_MutableSetHook)

@implementation NSMutableSet (MutableSetHook)

+ (void)tfy_swizzleNSMutableSet{
    NSMutableSet* instanceObject = [NSMutableSet new];
    Class cls =  object_getClass(instanceObject);
    
    [self tfy_crashswizzleInstanceMethod:cls originSelector:@selector(addObject:) swizzleSelector:@selector(hookAddObject:)];
    [self tfy_crashswizzleInstanceMethod:cls originSelector:@selector(removeObject:) swizzleSelector:@selector(hookRemoveObject:)];
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
