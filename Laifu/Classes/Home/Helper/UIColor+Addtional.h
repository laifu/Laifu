//
//  UIColor+Addtional.h
//  Laifu
//
//  Created by 闫青松 on 13-7-22.
//  Copyright (c) 2013年 于龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIColorBlock)(CGFloat r,CGFloat g, CGFloat b);

@interface UIColor (Addtional)

+ (UIColor *)hexStringToColor:(NSString *)stringToConvert alpha:(CGFloat)alpha;
+ (void)hexStringToColor:(NSString *)stringToConvert colorRGB:(UIColorBlock)colorRGB;

@end
