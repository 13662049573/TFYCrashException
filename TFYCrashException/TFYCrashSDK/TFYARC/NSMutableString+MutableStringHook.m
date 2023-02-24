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
    tfy_crashswizzleInstanceMethod(NSClassFromString(@"__NSCFString"), @selector(appendString:), @selector(hookAppendString:));
    tfy_crashswizzleInstanceMethod(NSClassFromString(@"__NSCFString"), @selector(insertString:atIndex:), @selector(hookInsertString:atIndex:));
    tfy_crashswizzleInstanceMethod(NSClassFromString(@"__NSCFString"), @selector(deleteCharactersInRange:), @selector(hookDeleteCharactersInRange:));
    tfy_crashswizzleInstanceMethod(NSClassFromString(@"__NSCFString"), @selector(substringFromIndex:), @selector(hookSubstringFromIndex:));
    tfy_crashswizzleInstanceMethod(NSClassFromString(@"__NSCFString"), @selector(substringToIndex:), @selector(hookSubstringToIndex:));
    tfy_crashswizzleInstanceMethod(NSClassFromString(@"__NSCFString"), @selector(substringWithRange:), @selector(hookSubstringWithRange:));
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
