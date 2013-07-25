//
//  UITableCellBase.h
//  SimaNan-Vodone
//
//  Created by chaikejian on 13-5-28.
//  Copyright (c) 2013年 Gong Xueqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UITableCellInnerView;
@interface UITableCellBase : UITableViewCell{
    UITableCellInnerView        *_inner;
}

@property (nonatomic, retain) NSIndexPath *baseCellIndexPath;

- (void)drawContentView:(CGRect)rect;
- (void)setHighlighted:(BOOL)highlighted
              animated:(BOOL)animated
          needsDisplay:(BOOL)needsDisplay;
@end


@interface UITableCellInnerView : UIView{
    UITableCellBase             *cell;
    UITableViewCellStateMask    _stateMask;
}
@property(nonatomic,assign)UITableCellBase  *cell;
@end