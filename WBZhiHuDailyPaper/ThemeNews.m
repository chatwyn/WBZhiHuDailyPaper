//
//  ThemeNews.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/22.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "ThemeNews.h"


@implementation ThemeNews

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"stories" : [StoryModel class]
             };
}

@end
