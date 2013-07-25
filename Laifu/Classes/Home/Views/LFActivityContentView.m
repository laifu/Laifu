//
//  LFActivityContentView.m
//  Laifu
//
//  Created by 闫青松 on 13-7-22.
//  Copyright (c) 2013年 于龙. All rights reserved.
//

#import "LFActivityContentView.h"

@implementation LFActivityContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    __block CGFloat red,green,blue;
    
    NSLog(@"%@",self.activity.title);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    /* 绘制内容 */
    
    // 1 翻转坐标系
    CGContextSetTextMatrix(context,CGAffineTransformIdentity);//重置
    CGContextTranslateCTM(context,0,self.bounds.size.height); //y轴高度
    CGContextScaleCTM(context,1.0,-1.0);//y轴翻转
    
    CFMutableAttributedStringRef attributedString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CTFramesetterRef frameSetter = [LFCoreText createFramesetterForText:self.activity.title
                                                    AttributedStringRef:attributedString
                                                                   font:kHomeActivityTitleFont
                                                               fontSize:kHomeActivityTitleFont.pointSize
                                                              textColor:kHomeActivityTitleColor
                                                     constrainedToWidth:rect.size.width - 5 * 2
                                                             paddingTop:5.0f];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path,NULL,CGRectMake(5, -3, rect.size.width - 5 * 2, rect.size.height - 6));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter,CFRangeMake(0,0),path,NULL);
    
    // 2 画出文本
    CTFrameDraw(frame, context);
    
    // 3 释放
    CFRelease(frameSetter);
    CFRelease(frame);
    CFRelease(path);
    CFRelease(attributedString);
    
    UIFont *font1 = [UIFont fontWithName:@"Didot" size:12.0f];
    UIFont *font2 = [UIFont systemFontOfSize:11.0f];
    
    UIColor *color1 = [UIColor hexStringToColor:@"#2b5e89" alpha:1.0f];
    UIColor *color2 = [UIColor blackColor];
    
    NSString *member = [NSString stringWithFormat:@"%d 个成员",self.activity.memberCount];
    NSRange memberRange = [member rangeOfString:@"个成员"];
    
    NSString *travel = [NSString stringWithFormat:@"%d 个行程",self.activity.travelCount];
    NSRange travelRange = [travel rangeOfString:@"个行程"];
    
    // 0
    CFMutableAttributedStringRef memberText = CFAttributedStringCreateMutable(NULL, [member length]);
    CFAttributedStringReplaceString(memberText, CFRangeMake(0, 0), (CFStringRef)member);
    
    // 1 设置字体
    CTFontRef memberFont1 = CTFontCreateWithName((CFStringRef)font1.familyName, font1.pointSize, NULL);
    CFAttributedStringSetAttribute(memberText, CFRangeMake(0, CFAttributedStringGetLength(memberText) - memberRange.length), kCTFontAttributeName, memberFont1);
    CFRelease(memberFont1);
    
    CTFontRef memberFont2 = CTFontCreateWithName((CFStringRef)font2.familyName, font2.pointSize, NULL);
    CFAttributedStringSetAttribute(memberText, CFRangeMake(memberRange.location, memberRange.length), kCTFontAttributeName, memberFont2);
    CFRelease(memberFont2);

    // 2 设置字体颜色    
    
    CFAttributedStringSetAttribute(memberText, CFRangeMake(0, CFAttributedStringGetLength(memberText)), kCTForegroundColorAttributeName, color1.CGColor);
    CFAttributedStringSetAttribute(memberText, CFRangeMake(memberRange.location, memberRange.length), kCTForegroundColorAttributeName, color2.CGColor);

    // 3 绘制
    CTLineRef  dayMonthLine = CTLineCreateWithAttributedString(memberText);
    CGContextSetTextPosition(context, 5 , self.bounds.size.height - 70);
    CTLineDraw(dayMonthLine, context);
    CFRelease(dayMonthLine);
    CFRelease(memberText);
    
    
    // 0
    CFMutableAttributedStringRef travelText = CFAttributedStringCreateMutable(NULL, [travel length]);
    CFAttributedStringReplaceString(travelText, CFRangeMake(0, 0), (CFStringRef)travel);
    
    // 1 设置字体
    CTFontRef travelFont1 = CTFontCreateWithName((CFStringRef)font1.familyName, font1.pointSize, NULL);
    CFAttributedStringSetAttribute(travelText, CFRangeMake(0, CFAttributedStringGetLength(travelText) - travelRange.length), kCTFontAttributeName, travelFont1);
    CFRelease(travelFont1);
    
    CTFontRef travelFont2 = CTFontCreateWithName((CFStringRef)font2.familyName, font2.pointSize, NULL);
    CFAttributedStringSetAttribute(travelText, CFRangeMake(travelRange.location, travelRange.length), kCTFontAttributeName, travelFont2);
    CFRelease(travelFont2);
    
    // 2 设置字体颜色
    
    CFAttributedStringSetAttribute(travelText, CFRangeMake(0, CFAttributedStringGetLength(travelText)), kCTForegroundColorAttributeName, color1.CGColor);
    CFAttributedStringSetAttribute(travelText, CFRangeMake(travelRange.location, travelRange.length), kCTForegroundColorAttributeName, color2.CGColor);
    
    // 3 绘制
    CTLineRef  travelLine = CTLineCreateWithAttributedString(travelText);
    CGContextSetTextPosition(context, rect.size.width / 2.0f, self.bounds.size.height - 70);
    CTLineDraw(travelLine, context);
    CFRelease(travelLine);
    CFRelease(travelText);
    
//    [[UIFont familyNames] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
//        NSLog(@"%@",obj);
//    }];
    
    
    
    [UIColor hexStringToColor:self.activity.randomColor colorRGB:^(CGFloat r, CGFloat g,CGFloat b){
        red   = r;
        green = g;
        blue  = b;
    }];
    
    CGContextSetRGBFillColor(context, red, green, blue, 1.0f);
    CGContextFillRect(context, CGRectMake(0, rect.size.height - 3.0f, rect.size.width, 3.0f));
    CGContextStrokePath(context);
}

- (void)setActivity:(LFActivity *)activity {
    if (_activity != activity) {
        [_activity release];
        _activity = [activity retain];
        [self setNeedsDisplay];
    }
}

@end
