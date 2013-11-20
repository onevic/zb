//
//  STBaseViewController.m
//  36Kr
//
//  Created by scott on 13-11-16.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STBaseViewController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation STBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /*自定义导航栏*/
    _isNavBarShowing = NO;
    self.navigationController.navigationBarHidden = YES;
    _navBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    [self.view addSubview:_navBar];
    _navBar.image = [UIImage imageNamed:@"nav_bg.png"];
    _navBar.userInteractionEnabled = YES;
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /*适配iOS 7.0*/
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7 && _isAdjusted == NO)
    {
        _isAdjusted = YES;
        if (nil == self.navigationController || self.navigationController.navigationBarHidden || self.navigationController.navigationBar.hidden)
        {
            /*所有子视图下移20*/
            for (UIView *subView in self.view.subviews) {
                CGRect originFrame = subView.frame;
                CGRect newFrame = CGRectMake(originFrame.origin.x, originFrame.origin.y+20, originFrame.size.width, originFrame.size.height);
                subView.frame = newFrame;
            }
            
        }else
            self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self showNavigationBar:YES animate:NO];
}

#pragma - mark 事件响应

- (void)addMenuButton
{
    /*菜单按钮*/
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    navButton.frame = CGRectMake(20, 15, 18.5, 13);
    [navButton setImage:[UIImage imageNamed:@"nav_menu.png"] forState:UIControlStateNormal];
    [navButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    [_navBar addSubview:navButton];
}

- (void)showMenu
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.ddmenu showLeftController:YES];
}

- (void)showNavigationBar:(BOOL)show animate:(BOOL)animate
{
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    float y = (systemVersion >= 7)?20:0;
    float dur = (animate)?1:0;
    if (show == _isNavBarShowing)
        return;

    if (show)
    {
        /*显示*/
        _isNavBarShowing = YES;
        [UIView animateWithDuration:dur animations:^{
            _navBar.frame = CGRectMake(0, y, kScreenWidth, 44);
            /*下移44*/
            for (UIView *subView in self.view.subviews) {
                if (subView == _navBar)
                    continue;
                CGRect originFrame = subView.frame;
                CGRect newFrame = CGRectMake(originFrame.origin.x, originFrame.origin.y+44, originFrame.size.width, originFrame.size.height);
                subView.frame = newFrame;
            }
        }];
    }else {
        _isNavBarShowing = NO;
        [UIView animateWithDuration:dur animations:^{
            _navBar.frame = CGRectMake(0, -44, kScreenWidth, 44);
            /*上移44*/
            for (UIView *subView in self.view.subviews) {
                if (subView == _navBar)
                    continue;
                CGRect originFrame = subView.frame;
                CGRect newFrame = CGRectMake(originFrame.origin.x, originFrame.origin.y-44, originFrame.size.width, originFrame.size.height);
                subView.frame = newFrame;
            }
        }];
    }
}

@end
