//
//  LFTitleView.m
//  Laifu
//
//  Created by qingsong on 13-7-23.
//  Copyright (c) 2013年 于龙. All rights reserved.
//

#import "LFTitleView.h"

@implementation LFTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [kHomeTitleColor set];
    CGSize size = [self.title sizeWithFont:kHomeTitleFont];
    [self.title drawInRect:CGRectMake((rect.size.width - size.width) / 2.0f, (rect.size.height - size.height) / 2.0f, size.width, size.height) withFont:kHomeTitleFont lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
    
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        [_title release];
        _title = [title retain];
        [self setNeedsDisplay];
    }
}

@end
