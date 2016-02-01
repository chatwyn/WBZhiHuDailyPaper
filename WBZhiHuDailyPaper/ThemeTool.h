//
//  ThemeTool.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/22.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Theme.h"

typedef void(^SuccessfulBlock)(id obj);

@interface ThemeTool : NSObject
/**
 *  获得主题日报的列表
 *
 *  @param block 回调主题日报数据
 */
+ (void)getThemesWithSuccessfulBlock:(SuccessfulBlock)block;


@end
