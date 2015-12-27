//
//  CircleRefreshView.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/22.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleRefreshView : UIView

+ (CircleRefreshView *)attachObserveToScrollView:(UIScrollView *)scrollView
                            target:(id)target
                            action:(SEL)action;

- (void)endRefreshing;

@end
