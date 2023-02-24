//
//  NSMutableAttributedString+MutableAttributedStringHook.h
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//


#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (MutableAttributedStringHook)

+ (void)tfy_swizzleNSMutableAttributedString;

@end
