//
//  LFCoreText.h
//  Laifu
//
//  Created by 闫青松 on 13-7-23.
//  Copyright (c) 2013年 于龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import "LFConstant.h"
#import "UIColor+Addtional.h"

@interface LFCoreText : NSObject

+ (CGFloat)measureFrameHeightForText:(NSString *)text
                                font:(UIFont *)newfont
							fontSize:(CGFloat)fontSize
                           textColor:(UIColor *)textColor
				  constrainedToWidth:(CGFloat)width
						  paddingTop:(CGFloat)paddingTop;

+ (CTFramesetterRef)createFramesetterForText:(NSString *)text
                         AttributedStringRef:(CFMutableAttributedStringRef)attributedString
                                        font:(UIFont *)newfont
                                    fontSize:(CGFloat)fontSize
                                   textColor:(UIColor *)textColor
                          constrainedToWidth:(CGFloat)width
                                  paddingTop:(CGFloat)paddingTop;

@end
