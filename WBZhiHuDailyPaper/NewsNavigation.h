//
//  NewsNavigation.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/20.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsNavigation;

@protocol  NewsNavigationDelegate <NSObject>

@optional

- (void)didTouchUpNaviBar:(NewsNavigation *)naviBar btnTag:(NSInteger)tag;

@end

@interface NewsNavigation : UIView

@property (nonatomic, weak) id <NewsNavigationDelegate> delegate;

@property (nonatomic, strong) NSNumber *id;

@end
