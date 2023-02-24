//
//  NSObject+DeallocBlock.h
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//

#import <Foundation/Foundation.h>

@interface NSObject (DeallocBlock)

- (void)tfy_deallocBlock:(void(^)(void))block;

@end
