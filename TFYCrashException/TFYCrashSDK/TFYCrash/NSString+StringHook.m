//
//  NSString+StringHook.m
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//

#import "NSString+StringHook.h"
#import "NSObject+Hook.h"
#import "TFYCrashExceptionProxy.h"
#import "TFYCrashExceptionMacros.h"

TFYCrashSYNTH_DUMMY_CLASS(NSString_StringHook)

@implementation NSString (StringHook)

+ (void)tfy_swizzleNSString{
    [NSString tfy_crashswizzleClassMethod:@selector(stringWithUTF8String:) withSwizzleMethod:@selector(hookStringWithUTF8String:)];
    [NSString tfy_crashswizzleClassMethod:@selector(stringWithCString:encoding:) withSwizzleMethod:@selector(hookStringWithCString:encoding:)];
    
    //NSPlaceholderString
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"NSPlaceholderString") originSelector:@selector(initWithCString:encoding:) swizzleSelector:@selector(hookInitWithCString:encoding:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"NSPlaceholderString") originSelector:@selector(initWithString:) swizzleSelector:@selector(hookInitWithString:)];
    
    //_NSCFConstantString
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFConstantString") originSelector:@selector(substringFromIndex:) swizzleSelector:@selector(hookSubstringFromIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFConstantString") originSelector:@selector(substringToIndex:) swizzleSelector:@selector(hookSubstringToIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFConstantString") originSelector:@selector(substringWithRange:) swizzleSelector:@selector(hookSubstringWithRange:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFConstantString") originSelector:@selector(rangeOfString:options:range:locale:) swizzleSelector:@selector(hookRangeOfString:options:range:locale:)];
    
    
    //NSTaggedPointerString
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"NSTaggedPointerString") originSelector:@selector(substringFromIndex:) swizzleSelector:@selector(hookSubstringFromIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"NSTaggedPointerString") originSelector:@selector(substringToIndex:) swizzleSelector:@selector(hookSubstringToIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"NSTaggedPointerString") originSelector:@selector(substringWithRange:) swizzleSelector:@selector(hookSubstringWithRange:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"NSTaggedPointerString") originSelector:@selector(rangeOfString:options:range:locale:) swizzleSelector:@selector(hookRangeOfString:options:range:locale:)];
}

+ (NSString*) hookStringWithUTF8String:(const char *)nullTerminatedCString{
    if (NULL != nullTerminatedCString) {
        return [self hookStringWithUTF8String:nullTerminatedCString];
    }
    handleCrashException(TFYCrashExceptionGuardNSStringContainer,@"NSString stringWithUTF8String NULL char pointer");
    return nil;
}

+ (nullable instancetype) hookStringWithCString:(const char *)cString encoding:(NSStringEncoding)enc
{
    if (NULL != cString){
        return [self hookStringWithCString:cString encoding:enc];
    }
    handleCrashException(TFYCrashExceptionGuardNSStringContainer,@"NSString stringWithCString:encoding: NULL char pointer");
    return nil;
}

- (nullable instancetype) hookInitWithString:(id)cString{
    if (nil != cString){
        return [self hookInitWithString:cString];
    }
    handleCrashException(TFYCrashExceptionGuardNSStringContainer,@"NSString initWithString nil parameter");
    return nil;
}

- (nullable instancetype) hookInitWithCString:(const char *)nullTerminatedCString encoding:(NSStringEncoding)encoding{
    if (NULL != nullTerminatedCString){
        return [self hookInitWithCString:nullTerminatedCString encoding:encoding];
    }
    handleCrashException(TFYCrashExceptionGuardNSStringContainer,@"NSString initWithCString:encoding NULL char pointer");
    return nil;
}

- (NSString *)hookSubstringFromIndex:(NSUInteger)from{
    if (from <= self.length) {
        return [self hookSubstringFromIndex:from];
    }
    handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSString substringFromIndex value:%@ from:%tu",self,from]);
    return nil;
}

- (NSString *)hookSubstringToIndex:(NSUInteger)to{
    if (to <= self.length) {
        return [self hookSubstringToIndex:to];
    }
    handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSString substringToIndex value:%@ from:%tu",self,to]);
    return self;
}

- (NSString *)hookSubstringWithRange:(NSRange)range{
    if (range.location + range.length <= self.length) {
        return [self hookSubstringWithRange:range];
    }
    handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSString substringWithRange value:%@ range:%@",self,NSStringFromRange(range)]);
    return nil;
}
- (NSRange)hookRangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)range locale:(nullable NSLocale *)locale{
    if (searchString){
        if (range.location + range.length <= self.length) {
            return [self hookRangeOfString:searchString options:mask range:range locale:locale];
        }
        handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSString rangeOfString:options:range:locale: value:%@ range:%@",self,NSStringFromRange(range)]);
        return NSMakeRange(NSNotFound, 0);
    }else{
        handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSString rangeOfString:options:range:locale: searchString nil value:%@ range:%@",self,NSStringFromRange(range)]);
        return NSMakeRange(NSNotFound, 0);
    }
}

@end
