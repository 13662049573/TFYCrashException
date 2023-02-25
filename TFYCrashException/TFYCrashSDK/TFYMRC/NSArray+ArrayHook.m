//
//  NSArray+ArrayHook.m
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//

#import "NSArray+ArrayHook.h"
#import "NSObject+Hook.h"
#import "TFYCrashExceptionProxy.h"
#import "TFYCrashExceptionMacros.h"

TFYCrashSYNTH_DUMMY_CLASS(NSArray_ArrayHook)

@implementation NSArray (ArrayHook)

+ (void)tfy_swizzleNSArray{
    [NSArray tfy_crashswizzleClassMethod:@selector(arrayWithObject:) withSwizzleMethod:@selector(hookArrayWithObject:)];
    [NSArray tfy_crashswizzleClassMethod:@selector(arrayWithObjects:count:) withSwizzleMethod:@selector(hookArrayWithObjects:count:)];
    
    /* __NSArray0 */
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArray0") originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(hookObjectAtIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArray0") originSelector:@selector(subarrayWithRange:) swizzleSelector:@selector(hookSubarrayWithRange:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArray0") originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(hookObjectAtIndexedSubscript:)];
        
    /* __NSArrayI */
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayI") originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(hookObjectAtIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayI") originSelector:@selector(subarrayWithRange:) swizzleSelector:@selector(hookSubarrayWithRange:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayI") originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(hookObjectAtIndexedSubscript:)];
    
    /* __NSArrayI_Transfer */
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayI_Transfer") originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(hookObjectAtIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayI_Transfer") originSelector:@selector(subarrayWithRange:) swizzleSelector:@selector(hookSubarrayWithRange:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayI_Transfer") originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(hookObjectAtIndexedSubscript:)];
    
    /* above iOS10  __NSSingleObjectArrayI */
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSSingleObjectArrayI") originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(hookObjectAtIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSSingleObjectArrayI") originSelector:@selector(subarrayWithRange:) swizzleSelector:@selector(hookSubarrayWithRange:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSSingleObjectArrayI") originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(hookObjectAtIndexedSubscript:)];
    
    /* __NSFrozenArrayM */
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSFrozenArrayM") originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(hookObjectAtIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSFrozenArrayM") originSelector:@selector(subarrayWithRange:) swizzleSelector:@selector(hookSubarrayWithRange:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSFrozenArrayM") originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(hookObjectAtIndexedSubscript:)];
    

    /* __NSArrayReversed */
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayReversed") originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(hookObjectAtIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayReversed") originSelector:@selector(subarrayWithRange:) swizzleSelector:@selector(hookSubarrayWithRange:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayReversed") originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(hookObjectAtIndexedSubscript:)];

}

+ (instancetype) hookArrayWithObject:(id)anObject
{
    if (anObject) {
        return [self hookArrayWithObject:anObject];
    }
    handleCrashException(TFYCrashExceptionGuardArrayContainer,@"NSArray arrayWithObject object is nil");
    return nil;
}

- (id) hookObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self hookObjectAtIndex:index];
    }
    handleCrashException(TFYCrashExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSArray objectAtIndex invalid index:%tu total:%tu",index,self.count]);
    return nil;
}
- (id) hookObjectAtIndexedSubscript:(NSInteger)index {
    if (index < self.count) {
        return [self hookObjectAtIndexedSubscript:index];
    }
    handleCrashException(TFYCrashExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSArray objectAtIndexedSubscript invalid index:%tu total:%tu",index,self.count]);
    return nil;
}
- (NSArray *)hookSubarrayWithRange:(NSRange)range
{
    if (range.location + range.length <= self.count){
        return [self hookSubarrayWithRange:range];
    }else if (range.location < self.count){
        return [self hookSubarrayWithRange:NSMakeRange(range.location, self.count-range.location)];
    }
    handleCrashException(TFYCrashExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSArray subarrayWithRange invalid range location:%tu length:%tu",range.location,range.length]);
    return nil;
}
+ (instancetype)hookArrayWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    NSInteger index = 0;
    id objs[cnt];
    for (NSInteger i = 0; i < cnt ; ++i) {
        if (objects[i]) {
            objs[index++] = objects[i];
        }else{
            handleCrashException(TFYCrashExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSArray arrayWithObjects invalid index object:%tu total:%tu",i,cnt]);
        }
    }
    return [self hookArrayWithObjects:objs count:index];
}

@end
