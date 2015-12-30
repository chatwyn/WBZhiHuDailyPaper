//
//  LeftSideViewController.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/18.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainController;

@interface LeftSideViewController : UIViewController

@property (nonatomic, weak) MainController *delegate;

- (void)updateAccount;

@end
