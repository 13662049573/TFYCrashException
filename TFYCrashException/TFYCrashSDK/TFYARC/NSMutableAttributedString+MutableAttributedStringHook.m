//
//  NSMutableAttributedString+MutableAttributedStringHook.m
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//


#import "NSMutableAttributedString+MutableAttributedStringHook.h"
#import "NSObject+Hook.h"
#import <objc/runtime.h>
#import "TFYCrashExceptionProxy.h"
#import "TFYCrashExceptionMacros.h"

TFYCrashSYNTH_DUMMY_CLASS(NSMutableAttributedString_MutableAttributedStringHook)

@implementation NSMutableAttributedString (MutableAttributedStringHook)

+ (void)tfy_swizzleNSMutableAttributedString{
    NSMutableAttributedString* instanceObject = [NSMutableAttributedString new];
    Class cls =  object_getClass(instanceObject);
    
    [self tfy_crashswizzleInstanceMethod:cls originSelector:@selector(initWithString:) swizzleSelector:@selector(hookInitWithString:)];
    [self tfy_crashswizzleInstanceMethod:cls originSelector:@selector(initWithString:attributes:) swizzleSelector:@selector(hookInitWithString:attributes:)];
    [self tfy_crashswizzleInstanceMethod:cls originSelector:@selector(addAttribute:value:range:) swizzleSelector:@selector(hookAddAttribute:value:range:)];
    [self tfy_crashswizzleInstanceMethod:cls originSelector:@selector(addAttributes:range:) swizzleSelector:@selector(hookAddAttributes:range:)];
    [self tfy_crashswizzleInstanceMethod:cls originSelector:@selector(setAttributes:range:) swizzleSelector:@selector(hookSetAttributes:range:)];
    [self tfy_crashswizzleInstanceMethod:cls originSelector:@selector(removeAttribute:range:) swizzleSelector:@selector(hookRemoveAttribute:range:)];
    [self tfy_crashswizzleInstanceMethod:cls originSelector:@selector(deleteCharactersInRange:) swizzleSelector:@selector(hookDeleteCharactersInRange:)];
    [self tfy_crashswizzleInstanceMethod:cls originSelector:@selector(replaceCharactersInRange:withString:) swizzleSelector:@selector(hookReplaceCharactersInRange:withString:)];
    [self tfy_crashswizzleInstanceMethod:cls originSelector:@selector(replaceCharactersInRange:withAttributedString:) swizzleSelector:@selector(hookReplaceCharactersInRange:withAttributedString:)];
}

- (id)hookInitWithString:(NSString*)str{
    if (str){
        return [self hookInitWithString:str];
    }
    handleCrashException(TFYCrashExceptionGuardNSStringContainer,@"NSMutableAttributedString initWithString parameter nil");
    return nil;
}

- (id)hookInitWithString:(NSString*)str attributes:(nullable NSDictionary*)attributes{
    if (str){
        return [self hookInitWithString:str attributes:attributes];
    }
    handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableAttributedString initWithString:attributes: str:%@ attributes:%@",str,attributes]);
    return nil;
}

- (void)hookAddAttribute:(id)name value:(id)value range:(NSRange)range{
    if (!range.length) {
        [self hookAddAttribute:name value:value range:range];
    }else if (value){
        if (range.location + range.length <= self.length) {
            [self hookAddAttribute:name value:value range:range];
        }else{
            handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableAttributedString addAttribute:value:range: name:%@ value:%@ range:%@",name,value,NSStringFromRange(range)]);
        }
    }else {
        handleCrashException(TFYCrashExceptionGuardNSStringContainer,@"NSMutableAttributedString addAttribute:value:range: value nil");
    }
}
- (void)hookAddAttributes:(NSDictionary<NSString *,id> *)attrs range:(NSRange)range{
    if (!range.length) {
        [self hookAddAttributes:attrs range:range];
    }else if (attrs){
        if (range.location + range.length <= self.length) {
            [self hookAddAttributes:attrs range:range];
        }else{
            handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableAttributedString addAttributes:range: attrs:%@ range:%@",attrs,NSStringFromRange(range)]);
        }
    }else{
        handleCrashException(TFYCrashExceptionGuardNSStringContainer,@"NSMutableAttributedString addAttributes:range: value nil");
    }
}

- (void)hookSetAttributes:(NSDictionary<NSString *,id> *)attrs range:(NSRange)range {
    if (!range.length) {
        [self hookSetAttributes:attrs range:range];
    } else {
        if (range.location + range.length <= self.length) {
            [self hookSetAttributes:attrs range:range];
        }else{
            handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableAttributedString setAttributes:range: attrs:%@ range:%@",attrs,NSStringFromRange(range)]);
        }
    }
}

- (void)hookRemoveAttribute:(id)name range:(NSRange)range {
    if (!range.length) {
        [self hookRemoveAttribute:name range:range];
    }else if (name){
        if (range.location + range.length <= self.length) {
            [self hookRemoveAttribute:name range:range];
        }else {
            handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableAttributedString removeAttribute:range: name:%@ range:%@",name,NSStringFromRange(range)]);
        }
    }else{
        handleCrashException(TFYCrashExceptionGuardNSStringContainer,@"NSMutableAttributedString removeAttribute:range: attrs nil");
    }
}

- (void)hookDeleteCharactersInRange:(NSRange)range {
    if (range.location + range.length <= self.length) {
        [self hookDeleteCharactersInRange:range];
    }else {
        handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableAttributedString deleteCharactersInRange: range:%@",NSStringFromRange(range)]);
    }
}
- (void)hookReplaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    if (str){
        if (range.location + range.length <= self.length) {
            [self hookReplaceCharactersInRange:range withString:str];
        }else{
            handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableAttributedString replaceCharactersInRange:withString string:%@ range:%@",str,NSStringFromRange(range)]);
        }
    }else{
        handleCrashException(TFYCrashExceptionGuardNSStringContainer,@"NSMutableAttributedString replaceCharactersInRange:withString: string nil");
    }
}
- (void)hookReplaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)str {
    if (str){
        if (range.location + range.length <= self.length) {
            [self hookReplaceCharactersInRange:range withAttributedString:str];
        }else{
          handleCrashException(TFYCrashExceptionGuardNSStringContainer,[NSString stringWithFormat:@"NSMutableAttributedString replaceCharactersInRange:withString string:%@ range:%@",str,NSStringFromRange(range)]);
        }
    }else{
        handleCrashException(TFYCrashExceptionGuardNSStringContainer,@"NSMutableAttributedString replaceCharactersInRange:withString: attributedString nil");
    }
}

@end
