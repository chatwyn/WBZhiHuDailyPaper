//
//  OverAllSetting.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/26.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OverAllSetting : NSObject

@property (nonatomic, assign, getter=isNight) BOOL night;

+(instancetype)shareSetting;

@end
