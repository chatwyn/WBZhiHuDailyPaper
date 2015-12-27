//
//  UIWindow+Expand.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/18.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "UIWindow+Expand.h"
#import "LaunchViewController.h"

@implementation UIWindow (Expand)

- (void)showLanuchPage{
    
    LaunchViewController *launchVC = [[LaunchViewController alloc] init];
    
    [self addSubview:launchVC.view];
    
}

@end
