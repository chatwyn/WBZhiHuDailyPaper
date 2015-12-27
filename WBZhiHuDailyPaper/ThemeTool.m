//
//  ThemeTool.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/22.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "ThemeTool.h"
#import "MJExtension.h"

@implementation ThemeTool

+ (void)getThemesWithSuccessfulBlock:(SuccessfulBlock )block{
    
    [HttpTool get:@"http://news-at.zhihu.com/api/4/themes" params:nil success:^(id json) {
        NSArray *array = [NSArray array];
        array = [Theme mj_objectArrayWithKeyValuesArray: json[@"others"]];
        block(array);

    } failure:^(NSError *error) {
        nil;
    }];
    
}

@end
