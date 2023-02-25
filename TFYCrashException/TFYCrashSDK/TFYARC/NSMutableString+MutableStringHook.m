//
//  NSMutableString+MutableStringHook.m
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//


#import "NSMutableString+MutableStringHook.h"
#import "NSObject+Hook.h"
#import "TFYCrashExceptionProxy.h"
#import "TFYCrashExceptionMacros.h"

TFYCrashSYNTH_DUMMY_CLASS(NSMutableString_MutableStringHook)

@implementation NSMutableString (MutableStringHook)

+ (void)tfy_swizzleNSMutableString{
    //__NSCFString
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFString") originSelector: @selector(appendString:) swizzleSelector:@selector(hookAppendString:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFString") originSelector: @selector(insertString:atIndex:) swizzleSelector:@selector(hookInsertString:atIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFString") originSelector: @selector(deleteCharactersInRange:) swizzleSelector:@selector(hookDeleteCharactersInRange:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFString") originSelector: @selector(substringFromIndex:) swizzleSelector:@selector(hookSubstringFromIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFString") originSelector: @selector(substringToIndex:) swizzleSelector:@selector(hookSubstringToIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFString") originSelector: @selector(substringWithRange:) swizzleSelector:@selector(hookSubstringWithRange:)];
}

- (void) hookAppendString:(NSString *)aString{
    if (aString){
        [self hookAppendString:aString];
    }else{
        handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableString appendString value:%@ parameter nil",self]);
    }
}

- (void) hookInsertString:(NSString *)aString atIndex:(NSUInteger)loc{
    if (aString && loc <= self.length) {
        [self hookInsertString:aString atIndex:loc];
    }else{
        handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableString insertString:atIndex: value:%@ paremeter string:%@ atIndex:%tu",self,aString,loc]);
    }
}

- (void) hookDeleteCharactersInRange:(NSRange)range{
    if (range.location + range.length <= self.length){
        [self hookDeleteCharactersInRange:range];
    }else{
        handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableString deleteCharactersInRange value:%@ range:%@",self,NSStringFromRange(range)]);
    }
}

- (NSString *)hookSubstringFromIndex:(NSUInteger)from{
    if (from <= self.length) {
        return [self hookSubstringFromIndex:from];
    }
    handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableString substringFromIndex value:%@ from:%tu",self,from]);
    return nil;
}

- (NSString *)hookSubstringToIndex:(NSUInteger)to{
    if (to <= self.length) {
        return [self hookSubstringToIndex:to];
    }
    handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableString substringToIndex value:%@ to:%tu",self,to]);
    return self;
}

- (NSString *)hookSubstringWithRange:(NSRange)range{
    if (range.location + range.length <= self.length) {
        return [self hookSubstringWithRange:range];
    }
    handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableString substringWithRange value:%@ range:%@",self,NSStringFromRange(range)]);
    return nil;
}

@end
