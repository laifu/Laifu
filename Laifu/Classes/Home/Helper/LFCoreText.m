//
//  LFCoreText.m
//  Laifu
//
//  Created by 闫青松 on 13-7-23.
//  Copyright (c) 2013年 于龙. All rights reserved.
//

#import "LFCoreText.h"

@implementation LFCoreText

+ (CGFloat)measureFrameHeightForText:(NSString *)text
                                font:(UIFont *)newfont
							fontSize:(CGFloat)fontSize
                           textColor:(UIColor *)textColor
				  constrainedToWidth:(CGFloat)width
						  paddingTop:(CGFloat)paddingTop {
	if (![text length])
		return 0.0;
    
    CFMutableAttributedStringRef attributedString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    
	CTFramesetterRef framesetter = [LFCoreText createFramesetterForText:text
                                                      AttributedStringRef:attributedString
                                                                     font:newfont
                                                                 fontSize:fontSize
                                                                textColor:textColor
                                                       constrainedToWidth:width
                                                               paddingTop:paddingTop];
	
	CFRange fitRange = CFRangeMake(0,0);
	CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, CFStringGetLength((CFStringRef)attributedString)), NULL, CGSizeMake(width,CGFLOAT_MAX), &fitRange);
	
	CFRelease(attributedString);
	CFRelease(framesetter);
	
	int returnVal = size.height + (paddingTop * 2) + 1;
	
	return (CGFloat)returnVal;
}

+ (CTFramesetterRef)createFramesetterForText:(NSString *)text
                         AttributedStringRef:(CFMutableAttributedStringRef)attributedString
                                        font:(UIFont *)newfont
                                    fontSize:(CGFloat)fontSize
                                   textColor:(UIColor *)textColor
                          constrainedToWidth:(CGFloat)width
                                  paddingTop:(CGFloat)paddingTop {
	
	CFAttributedStringBeginEditing(attributedString);
	CFAttributedStringReplaceString(attributedString, CFRangeMake(0, 0), (CFStringRef)text);
	
    //设置字体
	CTFontRef font = CTFontCreateWithName(( CFStringRef)newfont.fontName, fontSize, NULL);
	CFAttributedStringSetAttribute(attributedString, CFRangeMake(0, CFAttributedStringGetLength(attributedString)), kCTFontAttributeName, font);
    CFRelease(font);
    
    //设置字体颜色
//    UIColor *textColor = textColor;
    CFAttributedStringSetAttribute(attributedString, CFRangeMake(0, CFAttributedStringGetLength(attributedString)), kCTForegroundColorAttributeName, textColor.CGColor);
    
    //设置字间距
    CGFloat number = 4.0f;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    CFAttributedStringSetAttribute(attributedString, CFRangeMake(0, CFAttributedStringGetLength(attributedString)), kCTKernAttributeName, ( CFTypeRef)(( id)num));
    CFRelease(num);
    
    //创建文本对齐方式
    CTTextAlignment alignment = kCTJustifiedTextAlignment;
    
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
    alignmentStyle.valueSize = sizeof(alignment);
    alignmentStyle.value = &alignment;
    
    //设置文本行间距
    CGFloat lineSpace = 8.0f;
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    lineSpaceStyle.valueSize = sizeof(lineSpace);
    lineSpaceStyle.value = &lineSpace;
    
    //设置文本段间距
    CGFloat paragraphSpacing = 0.0f;
    CTParagraphStyleSetting paragraphSpaceStyle;
    paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphSpaceStyle.valueSize = sizeof(paragraphSpacing);
    paragraphSpaceStyle.value = &paragraphSpacing;
    
    //设置首行缩进
    CGFloat firstLineHeadIndent = (newfont.pointSize + 0.0f) * 0;
    CTParagraphStyleSetting firstLineHeadIndentStyle;
    firstLineHeadIndentStyle.spec = kCTParagraphStyleSpecifierFirstLineHeadIndent;
    firstLineHeadIndentStyle.valueSize = sizeof(firstLineHeadIndent);
    firstLineHeadIndentStyle.value = &firstLineHeadIndent;
    
    //创建设置数组
    CTParagraphStyleSetting settings[] = {alignmentStyle,lineSpaceStyle,paragraphSpaceStyle,firstLineHeadIndentStyle};
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, sizeof(settings) / sizeof(settings[0]));
    
    //给文本添加设置
    CFAttributedStringSetAttribute(attributedString, CFRangeMake(0, CFAttributedStringGetLength(attributedString)), kCTParagraphStyleAttributeName, ( CFTypeRef)(( id)style));
    CFRelease(style);
	
	CFAttributedStringEndEditing(attributedString);
	
	CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attributedString);
    
    return framesetter;
}

@end
