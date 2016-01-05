//
//  DetailViewTool.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/20.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBack)(id obj);

@interface DetailViewTool : NSObject
/**
 *  获得某个id的详细内容
 */
+ (void)getDetailStoryWithStoryId:(NSNumber *)storyId Callback:(CallBack)callBack;
/**
 *  获得id的点赞评论数
 */
+ (void)getStoryExtraWithStoryId:(NSNumber *)storyId Callback:(CallBack)callBack;

@end

