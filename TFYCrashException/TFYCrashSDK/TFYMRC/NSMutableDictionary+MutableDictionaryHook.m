//
//  NSMutableDictionary+MutableDictionaryHook.m
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//

#import "NSMutableDictionary+MutableDictionaryHook.h"
#import "NSObject+Hook.h"
#import "TFYCrashExceptionProxy.h"
#import "TFYCrashExceptionMacros.h"

TFYCrashSYNTH_DUMMY_CLASS(NSMutableDictionary_MutableDictionaryHook)

@implementation NSMutableDictionary (MutableDictionaryHook)

+ (void)tfy_swizzleNSMutableDictionary{
    tfy_crashswizzleInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKey:), @selector(hookSetObject:forKey:));
    tfy_crashswizzleInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(removeObjectForKey:), @selector(hookRemoveObjectForKey:));
    tfy_crashswizzleInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKeyedSubscript:), @selector(hookSetObject:forKeyedSubscript:));
}

- (void) hookSetObject:(id)object forKey:(id)key {
    if (object && key) {
        [self hookSetObject:object forKey:key];
    } else {
        handleCrashException(TFYCrashExceptionGuardDictionaryContainer,[NSString stringWithFormat:@"NSMutableDictionary setObject invalid object:%@ and key:%@",object,key],self);
    }
}

- (void) hookRemoveObjectForKey:(id)key {
    if (key) {
        [self hookRemoveObjectForKey:key];
    } else {
        handleCrashException(TFYCrashExceptionGuardDictionaryContainer,@"NSMutableDictionary removeObjectForKey nil key",self);
    }
}

- (void) hookSetObject:(id)object forKeyedSubscript:(id<NSCopying>)key {
    if (key) {
        [self hookSetObject:object forKeyedSubscript:key];
    } else {
        handleCrashException(TFYCrashExceptionGuardDictionaryContainer,[NSString stringWithFormat:@"NSMutableDictionary setObject object:%@ and forKeyedSubscript:%@",object,key],self);
    }
}

@end
