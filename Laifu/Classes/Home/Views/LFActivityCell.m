//
//  LFActivityCell.m
//  Laifu
//
//  Created by 闫青松 on 13-7-22.
//  Copyright (c) 2013年 于龙. All rights reserved.
//

#import "LFActivityCell.h"

#define kImageSize (240.0f / 2.0f)
#define kImageX    0.0f
#define kImageY    (28.0f / 2.0f)

@interface LFActivityCell ()

@property (nonatomic, retain) UIImageView *activityImageView;
@property (nonatomic, retain) LFActivityContentView *activityContentView;

@end

@implementation LFActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //        UIView *backgroundView = [[UIView alloc] init];
        //        backgroundView.backgroundColor = [UIColor whiteColor];
        //
        //        UIView *selectBackgroundView = [[UIView alloc] init];
        //        selectBackgroundView.backgroundColor = [UIColor grayColor];
        //
        //        self.backgroundView = backgroundView;
        //        self.selectedBackgroundView = selectBackgroundView;
        //        [backgroundView release];
        //        [selectBackgroundView release];
        
        [self.contentView addSubview:self.activityImageView];
        [self.contentView addSubview:self.activityContentView];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setActivity:(LFActivity *)activity {
    if (_activity != activity) {
        [_activity release];
        _activity = [activity retain];
        _activityContentView.activity = _activity;
        
        [_activityImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_activity.imageURL]] placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
            _activityImageView.image = image;
            _activity.image = image;
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
            
        }];
        
    }
}

- (UIImageView *)activityImageView {
    if (_activityImageView == nil) {
        _activityImageView = [[UIImageView alloc] init];
        _activityImageView.backgroundColor = [UIColor redColor];
    }
    return _activityImageView;
}

- (LFActivityContentView *)activityContentView {
    if (_activityContentView == nil) {
        _activityContentView = [[LFActivityContentView alloc] init];
    }
    return _activityContentView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _activityImageView.frame = CGRectMake(kImageX, kImageY, kImageSize, kImageSize);
    _activityContentView.frame = CGRectMake(kImageX + kImageSize, kImageY, self.frame.size.width - kImageX - kImageSize, kImageSize);
}

@end
