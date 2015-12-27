//
//  StoryModel.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/19.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "StoryModel.h"


@implementation StoryModel

@synthesize id = _id;

@end

@implementation SectionModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"stories" : [StoryModel class],
             @"top_stories" : [StoryModel class],
             };
}


@end