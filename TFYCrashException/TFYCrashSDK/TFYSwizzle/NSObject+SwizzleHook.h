//
//  NSObject+SwizzleHook.h
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//


#import <Foundation/Foundation.h>

typedef void (*TFYCrashSwizzleOriginalIMP)(void /* id, SEL, ... */ );

@interface TFYCrashSwizzleObject : NSObject

- (TFYCrashSwizzleOriginalIMP)getOriginalImplementation;

@property (nonatomic,readonly,assign) SEL selector;

@end

typedef id (^TFYCrashSwizzledIMPBlock)(TFYCrashSwizzleObject* swizzleInfo);

void swizzleClassMethod(Class cls, SEL originSelector, SEL swizzleSelector);

void swizzleInstanceMethod(Class cls, SEL originSelector, SEL swizzleSelector);

void tfy_swizzleDeallocIfNeeded(Class class);


@interface NSObject (SwizzleHook)

+ (void)tfy_swizzleClassMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector;

- (void)tfy_swizzleInstanceMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector;

- (void)tfy_swizzleInstanceMethod:(SEL)originSelector withSwizzledBlock:(TFYCrashSwizzledIMPBlock)swizzledBlock;

@end
