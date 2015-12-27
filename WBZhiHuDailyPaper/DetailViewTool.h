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

+ (void)getDetailStoryWithStoryId:(NSNumber *)storyId Callback:(CallBack)callBack;

+ (void)getStoryExtraWithStoryId:(NSNumber *)storyId Callback:(CallBack)callBack;

@end

