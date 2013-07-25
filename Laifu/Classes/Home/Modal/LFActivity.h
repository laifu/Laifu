//
//  LFActivity.h
//  Laifu
//
//  Created by 闫青松 on 13-7-22.
//  Copyright (c) 2013年 于龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFActivity : NSObject

@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) UIImage  *image;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) NSInteger memberCount;
@property (nonatomic, assign) NSInteger travelCount;
@property (nonatomic, assign) NSInteger newTravelCount;
@property (nonatomic, retain) NSString *randomColor;

@end
