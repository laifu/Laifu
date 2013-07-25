//
//  LFSingleTripAddCell.m
//  Laifu
//
//  Created by 闫青松 on 13-7-24.
//  Copyright (c) 2013年 于龙. All rights reserved.
//

#import "LFSingleTripAddCell.h"

#define kMargin 15.0f

#define kHeadSize (100.0f / 2.0f)

@interface LFSingleTripAddCell ()

@property (nonatomic, retain) UIImageView *addImageView;

@end

@implementation LFSingleTripAddCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor hexStringToColor:@"#343434" alpha:0.05];
        self.backgroundView = backgroundView;
        [backgroundView release];
        
        [self.contentView addSubview:self.addImageView];
    }
    return self;
}

- (void)drawContentView:(CGRect)rect {
    [super drawContentView:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1, 1, 1, 1.f);
    CGContextFillRect(context, CGRectMake(8, 10, rect.size.width - 8, rect.size.height - 10.0f));
    CGContextStrokePath(context);
    
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    [[UIColor hexStringToColor:@"#434343" alpha:1.0f] set];
    CGSize size = [self.title sizeWithFont:font];
    [self.title drawInRect:CGRectMake(50.0f + kMargin, 10 + (rect.size.height - 10.0f - size.height) / 2.0f, rect.size.width - 50.0f - 25.0f - kMargin * 2, size.height) withFont:font lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];
    
    __block CGFloat red,green,blue;
    [UIColor hexStringToColor:@"#438fd9" colorRGB:^(CGFloat r, CGFloat g,CGFloat b){
        red   = r;
        green = g;
        blue  = b;
    }];
    
    CGRect blueFrame = CGRectMake(rect.size.width - 8 - 45.0f, 10 + (rect.size.height - 10 - 25.0f)/2.0f, 45.0f, 25.0f);
    
    CGContextSetRGBFillColor(context, red, green, blue, 1.f);
    CGContextFillRect(context, blueFrame);
    CGContextStrokePath(context);
    
    UIFont *newFont = [UIFont systemFontOfSize:13.0f];
    [[UIColor whiteColor] set];
    CGSize newsize = [self.subTitle sizeWithFont:newFont];
    CGRect newframe = CGRectMake(blueFrame.origin.x, blueFrame.origin.y + (blueFrame.size.height - newsize.height) / 2.0f, blueFrame.size.width, newsize.height);
    [self.subTitle drawInRect:newframe withFont:newFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
}

- (UIImageView *)addImageView {
    if (_addImageView == nil) {
        _addImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cjxcd_btn.png"]];
        _addImageView.frame = CGRectMake(8, 10, kHeadSize, kHeadSize);
        _addImageView.backgroundColor = [UIColor redColor];
    }
    return _addImageView;
}

@end
