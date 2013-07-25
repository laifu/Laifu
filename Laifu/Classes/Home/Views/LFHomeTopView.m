
//
//  LFHomeTopView.m
//  Laifu
//
//  Created by qingsong on 13-7-23.
//  Copyright (c) 2013年 于龙. All rights reserved.
//

#import "LFHomeTopView.h"

#define kTopViewTitleColor  [UIColor hexStringToColor:@"#ffffff" alpha:1.0f]
#define kTopViewTitleFont   [UIFont systemFontOfSize:14.0f]

#define kTopViewSmallTitleColor  [UIColor hexStringToColor:@"#ffffff" alpha:.5f]
#define kTopViewSmallTitleFont   [UIFont systemFontOfSize:11.0f]

#define kDistanceFromTitleToArrow 4.0f
#define kDistanceFromArrowToSmallTitle 6.0f

static NSString *title = @"我的日历";
static NSString *smallTitle = @"展开";

@interface LFHomeTopView ()

@property (nonatomic, retain) UIImage *bgImage;
@property (nonatomic, retain) UIImage *openImage;
@property (nonatomic, retain) UIImage *closeImage;
@property (nonatomic, assign) BOOL    isOpening;
@property (nonatomic, retain) UIButton *button;

@end

@implementation LFHomeTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        
        self.bgImage    = [UIImage imageNamed:@"wdrl_dt.png"];
        self.openImage  = [UIImage imageNamed:@"wdrl_zk_btn.png"];
        self.closeImage = [UIImage imageNamed:@"wdrl_sq_btn.png"];
        
        self.isOpening  = NO;
        
//        [self addSubview:self.button];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [self.bgImage drawInRect:rect];
    
    [kTopViewTitleColor set];
    CGSize size = [title sizeWithFont:kTopViewTitleFont];
    [title drawAtPoint:CGPointMake(rect.size.width / 2.0f - size.width, (rect.size.height - size.height) / 2.0f) withFont:kTopViewTitleFont];
    if (self.isOpening) {
        [self.openImage drawAtPoint:CGPointMake(rect.size.width / 2.0f + 4, (rect.size.height - self.openImage.size.height) / 2.0f)];
    } else {
        [self.closeImage drawAtPoint:CGPointMake(rect.size.width / 2.0f + 4, (rect.size.height - self.closeImage.size.height) / 2.0f)];
    }
    
    [kTopViewSmallTitleColor set];
    CGSize smallSize = [smallTitle sizeWithFont:kTopViewSmallTitleFont];
    [smallTitle drawAtPoint:CGPointMake(rect.size.width / 2.0f + kDistanceFromTitleToArrow + self.closeImage.size.width + kDistanceFromArrowToSmallTitle, (rect.size.height - smallSize.height) / 2.0f)
                   withFont:kTopViewSmallTitleFont];
    
    __block CGFloat red,green,blue;
    [UIColor hexStringToColor:@"#ffffff" colorRGB:^(CGFloat r, CGFloat g,CGFloat b){
        red   = r;
        green = g;
        blue  = b;
    }];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetRGBStrokeColor(context, red, green, blue, 1.5);
    CGContextMoveToPoint(context, rect.size.width / 2.0f + kDistanceFromTitleToArrow + self.closeImage.size.width + kDistanceFromArrowToSmallTitle, rect.size.height - (rect.size.height - smallSize.height) / 2.0f);
    CGContextAddLineToPoint(context, rect.size.width / 2.0f + kDistanceFromTitleToArrow + self.closeImage.size.width + kDistanceFromArrowToSmallTitle + smallSize.width, rect.size.height - (rect.size.height - smallSize.height) / 2.0f);
    CGContextStrokePath(context);
}

- (UIButton *)button {
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self action:@selector(clickedOpenButton:) forControlEvents:UIControlEventTouchUpInside];
        [_button setImage:self.closeImage forState:UIControlStateNormal];
        [_button setTitle:NSLocalizedString(@" 展开", @"") forState:UIControlStateNormal];
        [_button.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [_button.titleLabel setTextColor:[UIColor colorWithRed:83.0f / 255.0f green:83.0f / 255.0f blue:83.0f / 255.0f alpha:1.0f]];
        [_button setFrame:CGRectMake(self.frame.size.width / 2.0f, 0, 50, self.frame.size.height)];
//        [_button setBackgroundColor:[UIColor redColor]];
    }
    return _button;
}

- (void)clickedOpenButton:(UIButton *)sender {
    
}

@end
