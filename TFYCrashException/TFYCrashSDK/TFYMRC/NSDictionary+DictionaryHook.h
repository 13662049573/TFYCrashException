//
//  NSDictionary+DictionaryHook.h
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DictionaryHook)

+ (void)tfy_swizzleNSDictionary;

@end
