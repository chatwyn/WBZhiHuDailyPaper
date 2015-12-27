
//  CycleScrollView.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/21.
//  Copyright © 2015年 曹文博. All rights reserved.
//  循环滚动条

#import <UIKit/UIKit.h>

typedef void(^TouchUpTopView)(id topStory);

@interface CycleScrollView : UIView

@end//CycleScrollView



@interface CycleView :CycleScrollView

@property (nonatomic, copy) TouchUpTopView topViewBlock;

/** topStories  首页滚动新闻*/
@property (nonatomic, strong) NSArray *topStories;

+ (instancetype)attchToView:(UIView *)view observeScorllView:(UIScrollView *)scrollView;

@end//CycleView


@class DetailStory;

@interface TopView : UIView

@property (nonatomic, strong) DetailStory *detailStory;

+ (instancetype)attchToView:(UIView *)view observeScorllView:(UIWebView *)scrollView;

@end






