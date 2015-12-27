//
//  ThemeNews.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/22.
//  Copyright © 2015年 曹文博. All rights reserved.
//  主题新闻内容

#import <Foundation/Foundation.h>

#import "StoryModel.h"

@interface ThemeNews : NSObject

/** storys  故事*/
@property (nonatomic, strong) NSArray *stories;

/** image  背景图片*/
@property (nonatomic, copy) NSString *image;

@end //ThemeNews

