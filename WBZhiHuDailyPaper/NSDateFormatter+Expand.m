//
//  NSDateFormatter+Expand.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/24.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "NSDateFormatter+Expand.h"

static NSDateFormatter * dateFormatter;

@implementation NSDateFormatter (Expand)


+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [super allocWithZone:zone];
    });
    return dateFormatter;
}

+ (instancetype)shareDateFormatter{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        dateFormatter = [[self alloc]init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CH"];
    });
    return dateFormatter;
}


@end
