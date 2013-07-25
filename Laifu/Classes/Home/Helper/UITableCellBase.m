//
//  UITableCellBase.m
//  SimaNan-Vodone
//
//  Created by chaikejian on 13-5-28.
//  Copyright (c) 2013年 Gong Xueqiang. All rights reserved.
//

#import "UITableCellBase.h"

@implementation UITableCellBase

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _inner = [[UITableCellInnerView alloc] initWithFrame:CGRectZero];
        _inner.cell = self;
        _inner.opaque = YES;
        _inner.backgroundColor = [UIColor clearColor];
        _inner.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
		_inner.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:_inner];
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    if (self.selectionStyle == UITableViewCellSelectionStyleNone) {
        return;
    }
    [super setHighlighted:highlighted animated:animated];
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated needsDisplay:(BOOL)needsDisplay{
    if (self.selectionStyle == UITableViewCellSelectionStyleNone) {
        return;
    }
    [super setHighlighted:highlighted animated:animated];
    if (needsDisplay) {
        [self setNeedsDisplay];
    }
}

-(void)dealloc{
    [_inner release];
    [super dealloc];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_inner setFrame:self.contentView.bounds];
    [_inner setNeedsDisplay];
}

- (void)setNeedsDisplay{
    [super setNeedsDisplay];
    [_inner setNeedsDisplay];
}

- (void)drawContentView:(CGRect)rect{    
}

@end

@implementation UITableCellInnerView
@synthesize cell;

- (void)drawRect:(CGRect)rect{
    [self.cell drawContentView:rect];
}

@end
