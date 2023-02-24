//
//  NSSet+SetHook.h
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSSet (SetHook)

+ (void)tfy_swizzleNSSet;

@end

NS_ASSUME_NONNULL_END
