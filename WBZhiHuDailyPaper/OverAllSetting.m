//
//  OverAllSetting.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/26.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "OverAllSetting.h"

static id _setting;

@implementation OverAllSetting

+(instancetype)shareSetting{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _setting = [[self alloc]init];
    });
    return _setting;
}


@end
