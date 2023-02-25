//
//  NSMutableArray+MutableArrayHook.m
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//
#import "NSMutableArray+MutableArrayHook.h"
#import "NSObject+Hook.h"
#import "TFYCrashExceptionProxy.h"
#import "TFYCrashExceptionMacros.h"

TFYCrashSYNTH_DUMMY_CLASS(NSMutableArray_MutableArrayHook)

@implementation NSMutableArray (MutableArrayHook)

+ (void)tfy_swizzleNSMutableArray{
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(hookObjectAtIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(subarrayWithRange:) swizzleSelector:@selector(hookSubarrayWithRange:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(hookObjectAtIndexedSubscript:)];
    
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(addObject:) swizzleSelector:@selector(hookAddObject:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(insertObject:atIndex:) swizzleSelector:@selector(hookInsertObject:atIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(removeObjectAtIndex:) swizzleSelector:@selector(hookRemoveObjectAtIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(replaceObjectAtIndex:withObject:) swizzleSelector:@selector(hookReplaceObjectAtIndex:withObject:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(setObject:atIndexedSubscript:) swizzleSelector:@selector(hookSetObject:atIndexedSubscript:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(removeObjectsInRange:) swizzleSelector:@selector(hookRemoveObjectsInRange:)];
    

    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFArray") originSelector:@selector(objectAtIndex:) swizzleSelector:@selector(hookObjectAtIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFArray") originSelector:@selector(subarrayWithRange:) swizzleSelector:@selector(hookSubarrayWithRange:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFArray") originSelector:@selector(objectAtIndexedSubscript:) swizzleSelector:@selector(hookObjectAtIndexedSubscript:)];
    
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFArray") originSelector:@selector(addObject:) swizzleSelector:@selector(hookAddObject:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFArray") originSelector:@selector(insertObject:atIndex:) swizzleSelector:@selector(hookInsertObject:atIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFArray") originSelector:@selector(removeObjectAtIndex:) swizzleSelector:@selector(hookRemoveObjectAtIndex:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFArray") originSelector:@selector(replaceObjectAtIndex:withObject:) swizzleSelector:@selector(hookReplaceObjectAtIndex:withObject:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFArray") originSelector:@selector(setObject:atIndexedSubscript:) swizzleSelector:@selector(hookSetObject:atIndexedSubscript:)];
    [self tfy_crashswizzleInstanceMethod:NSClassFromString(@"__NSCFArray") originSelector:@selector(removeObjectsInRange:) swizzleSelector:@selector(hookRemoveObjectsInRange:)];
    
}

- (void) hookAddObject:(id)anObject {
    if (anObject) {
        [self hookAddObject:anObject];
    }else{
        handleCrashException(TFYCrashExceptionGuardArrayContainer,@"NSMutableArray addObject nil object");
    }
}
- (id) hookObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self hookObjectAtIndex:index];
    }
    handleCrashException(TFYCrashExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray objectAtIndex invalid index:%tu total:%tu",index,self.count]);
    return nil;
}
- (id) hookObjectAtIndexedSubscript:(NSInteger)index {
    if (index < self.count) {
        return [self hookObjectAtIndexedSubscript:index];
    }
    handleCrashException(TFYCrashExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray objectAtIndexedSubscript invalid index:%tu total:%tu",index,self.count]);
    return nil;
}
- (void) hookInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject && index <= self.count) {
        [self hookInsertObject:anObject atIndex:index];
    }else{
        handleCrashException(TFYCrashExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray insertObject invalid index:%tu total:%tu insert object:%@",index,self.count,anObject]);
    }
}

- (void) hookRemoveObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self hookRemoveObjectAtIndex:index];
    }else{
        handleCrashException(TFYCrashExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray removeObjectAtIndex invalid index:%tu total:%tu",index,self.count]);
    }
}


- (void) hookReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index < self.count && anObject) {
        [self hookReplaceObjectAtIndex:index withObject:anObject];
    }else{
        handleCrashException(TFYCrashExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray replaceObjectAtIndex invalid index:%tu total:%tu replace object:%@",index,self.count,anObject]);
    }
}

- (void) hookSetObject:(id)object atIndexedSubscript:(NSUInteger)index {
    if (index <= self.count && object) {
        [self hookSetObject:object atIndexedSubscript:index];
    }else{
        handleCrashException(TFYCrashExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray setObject invalid object:%@ atIndexedSubscript:%tu total:%tu",object,index,self.count]);
    }
}

- (void) hookRemoveObjectsInRange:(NSRange)range {
    if (range.location + range.length <= self.count) {
        [self hookRemoveObjectsInRange:range];
    }else{
        handleCrashException(TFYCrashExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray removeObjectsInRange invalid range location:%tu length:%tu",range.location,range.length]);
    }
}

- (NSArray *)hookSubarrayWithRange:(NSRange)range
{
    if (range.location + range.length <= self.count){
        return [self hookSubarrayWithRange:range];
    }else if (range.location < self.count){
        return [self hookSubarrayWithRange:NSMakeRange(range.location, self.count-range.location)];
    }
    handleCrashException(TFYCrashExceptionGuardArrayContainer,[NSString stringWithFormat:@"NSMutableArray subarrayWithRange invalid range location:%tu length:%tu",range.location,range.length]);
    return nil;
}

@end
