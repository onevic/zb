//
//  AppDelegate.h
//  购运动
//
//  Created by one_vic on 13-11-18.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDMenuController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    DDMenuController *_ddmenu;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DDMenuController *ddmenu;

@end
