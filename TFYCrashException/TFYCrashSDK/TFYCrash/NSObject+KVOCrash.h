//
//  NSObject+KVOCrash.h
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVOCrash)

+ (void)tfy_swizzleKVOCrash;

@end
