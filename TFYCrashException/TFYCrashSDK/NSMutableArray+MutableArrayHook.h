//
//  NSMutableArray+MutableArrayHook.h
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MutableArrayHook)

+ (void)tfy_swizzleNSMutableArray;

@end
