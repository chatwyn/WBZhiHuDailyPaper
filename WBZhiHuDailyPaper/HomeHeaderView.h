//
//  HomeHeaderView.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/19.
//  Copyright © 2015年 曹文博. All rights reserved.
//  首页的sectionHeaderView

#import <UIKit/UIKit.h>

@class StoryModel;

@interface HomeHeaderView : UITableViewHeaderFooterView

@property (nonatomic,copy) NSString *date;

+ (instancetype)HomeHeaderViewWithTableView:(UITableView *)tableView;

@end
