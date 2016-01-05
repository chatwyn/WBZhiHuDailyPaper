//
//  LoginController.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/30.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginControllerDelegate <NSObject>

@optional

- (void)updateAccount;

@end

@interface LoginController : UIViewController

@property (nonatomic, weak) id <LoginControllerDelegate> delegate;

@end
