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

+ (void)getThemesWithSuccessfulBlock:(SuccessfulBlock)block;

@end
