//
//  NSAttributedString+AttributedStringHook.h
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (AttributedStringHook)

+ (void)tfy_swizzleNSAttributedString;

@end
