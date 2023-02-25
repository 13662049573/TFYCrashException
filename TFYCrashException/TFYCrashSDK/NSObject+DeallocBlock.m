//
//  NSObject+DeallocBlock.m
//  JJException
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//
#import "NSObject+DeallocBlock.h"
#import <objc/runtime.h>

static const char DeallocNSObjectKey;

/**
 Observer the target middle object
 */
@interface TFYCrashDeallocStub : NSObject

@property (nonatomic,readwrite,copy) void(^deallocBlock)(void);

@end

@implementation TFYCrashDeallocStub

- (void)dealloc {
    if (self.deallocBlock) {
        self.deallocBlock();
    }
    self.deallocBlock = nil;
}

@end

@implementation NSObject (DeallocBlock)

- (void)tfy_deallocBlock:(void(^)(void))block{
    @synchronized(self){
        NSMutableArray* blockArray = objc_getAssociatedObject(self, &DeallocNSObjectKey);
        if (!blockArray) {
            blockArray = [NSMutableArray array];
            objc_setAssociatedObject(self, &DeallocNSObjectKey, blockArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
        TFYCrashDeallocStub *stub = [TFYCrashDeallocStub new];
        stub.deallocBlock = block;
        
        [blockArray addObject:stub];
    }
}

@end
