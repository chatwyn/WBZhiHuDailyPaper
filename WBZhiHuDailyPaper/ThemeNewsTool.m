//
//  ThemeNewsTool.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/22.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "ThemeNewsTool.h"
#import "MJExtension.h"

@interface ThemeNewsTool ()

@property (nonatomic, strong) NSArray *newsIds;

@end

@implementation ThemeNewsTool

- (void)getThemeNewsWithId:(NSNumber *)Id SuccessfulBlock:(SuccessfulBlock)block{
    
    NSString *str = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/theme/%@",Id];
    
    [HttpTool get:str params:nil success:^(id json) {
        
        ThemeNews *news = [ThemeNews mj_objectWithKeyValues:json];
        
        self.newsIds = [news.stories valueForKeyPath:@"id"];
        
        block(news);
        
    } failure:^(NSError *error) {
        nil;
    }];
    
}

- (BOOL)isTheFirstNewsWithStoryId:(NSNumber *)number{
    if ([number isEqual:self.newsIds[0]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isTheLastNewsWithStoryId:(NSNumber *)number{
    if ([number isEqual:self.newsIds.lastObject]) {
        return YES;
    }
    return NO;
}

- (NSNumber *)getNextNewsWithId:(NSNumber *)number{
    NSInteger index = [self.newsIds indexOfObject:number];
    return [self.newsIds objectAtIndex:++index];
    
}

- (NSNumber *)getLastNewsWithId:(NSNumber *)number{
    NSInteger index = [self.newsIds indexOfObject:number];
    return [self.newsIds objectAtIndex:--index];
}

@end
