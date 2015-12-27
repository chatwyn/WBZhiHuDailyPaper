//
//  WebImgScrollView.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/26.
//  Copyright © 2015年 曹文博. All rights reserved.
//  图片浏览器

#import <UIKit/UIKit.h>

@interface WebImgScrollView : UIView

/** imgUrl  图像地址*/
@property (nonatomic, copy) NSString *imgUrl;

+ (WebImgScrollView *)showImageWithStr:(NSString *)url;

@end
