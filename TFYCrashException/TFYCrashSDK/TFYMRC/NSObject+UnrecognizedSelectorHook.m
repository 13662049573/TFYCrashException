//
//  NSObject+UnrecognizedSelectorHook.m
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//

#import "NSObject+UnrecognizedSelectorHook.h"
#import "NSObject+Hook.h"
#import <objc/runtime.h>
#import "TFYCrashExceptionProxy.h"
#import "TFYCrashExceptionMacros.h"

TFYCrashSYNTH_DUMMY_CLASS(NSObject_UnrecognizedSelectorHook)

@implementation NSObject (UnrecognizedSelectorHook)

+ (void)tfy_swizzleUnrecognizedSelector{
    
    //Class Method
    tfy_crashswizzleClassMethod([self class], @selector(methodSignatureForSelector:), @selector(classMethodSignatureForSelectorSwizzled:));
    tfy_crashswizzleClassMethod([self class], @selector(forwardInvocation:), @selector(forwardClassInvocationSwizzled:));
    
    //Instance Method
    tfy_crashswizzleInstanceMethod([self class], @selector(methodSignatureForSelector:), @selector(methodSignatureForSelectorSwizzled:));
    tfy_crashswizzleInstanceMethod([self class], @selector(forwardInvocation:), @selector(forwardInvocationSwizzled:));
}

+ (NSMethodSignature*)classMethodSignatureForSelectorSwizzled:(SEL)aSelector {
    NSMethodSignature* methodSignature = [self classMethodSignatureForSelectorSwizzled:aSelector];
    if (methodSignature) {
        return methodSignature;
    }
    
    return [self.class checkObjectSignatureAndCurrentClass:self.class];
}

- (NSMethodSignature*)methodSignatureForSelectorSwizzled:(SEL)aSelector {
    NSMethodSignature* methodSignature = [self methodSignatureForSelectorSwizzled:aSelector];
    if (methodSignature) {
        return methodSignature;
    }
    
    return [self.class checkObjectSignatureAndCurrentClass:self.class];
}

/**
 * Check the class method signature to the [NSObject class]
 * If not equals,return nil
 * If equals,return the v@:@ method

 @param currentClass Class
 @return NSMethodSignature
 */
+ (NSMethodSignature *)checkObjectSignatureAndCurrentClass:(Class)currentClass{
    IMP originIMP = class_getMethodImplementation([NSObject class], @selector(methodSignatureForSelector:));
    IMP currentClassIMP = class_getMethodImplementation(currentClass, @selector(methodSignatureForSelector:));
    
    // If current class override methodSignatureForSelector return nil
    if (originIMP != currentClassIMP){
        return nil;
    }
    
    // Customer method signature
    // void xxx(id,sel,id)
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}

/**
 Forward instance object

 @param invocation NSInvocation
 */
- (void)forwardInvocationSwizzled:(NSInvocation*)invocation{
    NSString* message = [NSString stringWithFormat:@"Unrecognized instance class:%@ and selector:%@",NSStringFromClass(self.class),NSStringFromSelector(invocation.selector)];
    handleCrashException(TFYCrashExceptionGuardUnrecognizedSelector,message);
}

/**
 Forward class object

 @param invocation NSInvocation
 */
+ (void)forwardClassInvocationSwizzled:(NSInvocation*)invocation{
    NSString* message = [NSString stringWithFormat:@"Unrecognized static class:%@ and selector:%@",NSStringFromClass(self.class),NSStringFromSelector(invocation.selector)];
    handleCrashException(TFYCrashExceptionGuardUnrecognizedSelector,message);
}


@end
