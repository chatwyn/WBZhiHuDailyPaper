//
//  MainController.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/18.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "MainController.h"
#import "LeftSideViewController.h"
#import "HomePageController.h"

@interface MainController ()

@end

@implementation MainController

#pragma mark - life cycle

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    HomePageController *homePageVC = [[HomePageController alloc] init];
    homePageVC.view.backgroundColor = kWhiteColor;
    
    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:homePageVC];
    self.naviController = naviController;
    naviController.navigationBar.hidden = YES;
    
    LeftSideViewController *leftSideDrawerViewController = [[LeftSideViewController alloc] init];
    leftSideDrawerViewController.delegate = self;
    
    self.centerViewController = naviController;
    self.leftDrawerViewController = leftSideDrawerViewController;
    
    [self setMaximumLeftDrawerWidth:220];
    
    [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self setShouldStretchDrawer:NO];

    [self setShowsShadow:NO];
    
}



@end
