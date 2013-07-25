//
//  LFSingleTripCell.m
//  Laifu
//
//  Created by qingsong on 13-7-24.
//  Copyright (c) 2013年 于龙. All rights reserved.
//

#import "LFSingleTripCell.h"
#import "AFNetworking.h"

#define kMargin 15.0f

#define kHeadSize (100.0f/2.0f)

@interface LFSingleTripCell ()

@property (nonatomic, retain) UIImageView *headImageView;

@end

@implementation LFSingleTripCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor hexStringToColor:@"#343434" alpha:0.05];
        self.backgroundView = backgroundView;
        [backgroundView release];
        
        [self.contentView addSubview:self.headImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSingleTrip:(LFASingleTrip *)singleTrip {
    if (_singleTrip != singleTrip) {
        [_singleTrip release];
        _singleTrip = [singleTrip retain];
        
        [_headImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_singleTrip.headURL]] placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            _headImageView.image = image;
            _singleTrip.headImage = image;
        
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
            
        }];
        [self setNeedsDisplay];
    
    }
}

- (UIImageView *)headImageView {
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, kHeadSize, kHeadSize)];
    }
    return _headImageView;
}

- (void)drawContentView:(CGRect)rect {
    [super drawContentView:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1, 1, 1, 1.f);
    CGContextFillRect(context, CGRectMake(8, 10, rect.size.width - 8, rect.size.height - 10.0f));
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetRGBStrokeColor(context, 71.0f/255.0f, 71.0f/255.0f, 71.0f/255.0f, 1);
    CGContextMoveToPoint(context, rect.size.width - 25.0f, 28.0f);
    CGContextAddLineToPoint(context, rect.size.width - 25.0f + 7, 28 + 7);
    CGContextAddLineToPoint(context, rect.size.width - 25.0f, 28 + 14);
    CGContextStrokePath(context);
    
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    [[UIColor hexStringToColor:@"#434343" alpha:1.0f] set];
    CGSize size = [self.singleTrip.title sizeWithFont:font];
    [self.singleTrip.title drawInRect:CGRectMake(50.0f + kMargin, 10 + (rect.size.height - 10.0f - size.height) / 2.0f, rect.size.width - 50.0f - 25.0f - kMargin * 2, size.height) withFont:font lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];
}

@end
