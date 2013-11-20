//
//  STBaseViewController.h
//  36Kr
//
//  Created by scott on 13-11-16.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STBaseViewController : UIViewController
{
    BOOL _isAdjusted;
    UIImageView *_navBar;
    BOOL _isNavBarShowing;
}
@property (nonatomic, strong) UIImageView *navBar;
- (void)showNavigationBar:(BOOL)show animate:(BOOL)animate;
- (void)addMenuButton;
- (void)addBackButton;
- (void)backButtonClicked;
@end
