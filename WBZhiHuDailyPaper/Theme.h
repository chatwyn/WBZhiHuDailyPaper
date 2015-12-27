//
//  Theme.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/20.
//  Copyright © 2015年 曹文博. All rights reserved.
//  主题日报

#import <Foundation/Foundation.h>

@interface Theme : NSObject

/** thumbnail  图片地址*/
@property (nonatomic, copy) NSString *thumbnail;

/** id  编号*/
@property (nonatomic, copy) NSNumber *id;

/** name  名称*/
@property (nonatomic, copy) NSString *name;

@end
