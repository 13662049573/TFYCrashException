//
//  NSMutableDictionary+MutableDictionaryHook.h
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (MutableDictionaryHook)

+ (void)tfy_swizzleNSMutableDictionary;

@end
