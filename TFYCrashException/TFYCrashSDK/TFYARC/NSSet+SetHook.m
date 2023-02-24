//
//  NSSet+SetHook.m
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//

#import "NSSet+SetHook.h"
#import "NSObject+SwizzleHook.h"
#import "TFYCrashExceptionProxy.h"
#import "TFYCrashExceptionMacros.h"

TFYCrashSYNTH_DUMMY_CLASS(NSSet_SetHook)

@implementation NSSet (SetHook)

+ (void)tfy_swizzleNSSet{
    [NSSet tfy_swizzleClassMethod:@selector(setWithObject:) withSwizzleMethod:@selector(hookSetWithObject:)];
}

+ (instancetype)hookSetWithObject:(id)object{
    if (object){
        return [self hookSetWithObject:object];
    }
    handleCrashException(TFYCrashExceptionGuardArrayContainer,@"NSSet setWithObject nil object");
    return nil;
}

@end
