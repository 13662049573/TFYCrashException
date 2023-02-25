//
//  NSMutableSet+MutableSetHook.h
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableSet (MutableSetHook)

+ (void)tfy_swizzleNSMutableSet;

@end

NS_ASSUME_NONNULL_END
