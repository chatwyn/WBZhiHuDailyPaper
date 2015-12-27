//
//  ThemeNewsTool.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/22.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeNews.h"

typedef void(^SuccessfulBlock)(id obj);

@interface ThemeNewsTool : NSObject

- (void)getThemeNewsWithId:(NSNumber *)Id SuccessfulBlock:(SuccessfulBlock)block;

- (BOOL)isTheFirstNewsWithStoryId:(NSNumber *)number;

- (BOOL)isTheLastNewsWithStoryId:(NSNumber *)number;

- (NSNumber *)getNextNewsWithId:(NSNumber *)number;

- (NSNumber *)getLastNewsWithId:(NSNumber *)number;

@end
