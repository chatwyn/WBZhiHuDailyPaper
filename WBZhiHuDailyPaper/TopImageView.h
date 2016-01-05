//
//  TopImageView.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/22.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopImageView : UIImageView
/**
 *  给tableView添加下拉伸缩的imageView
 *
 *  @param tableView 在此tableView上添加
 *
 *  @return 添加的imageView
 */
+ (TopImageView *)attachToTableView:(UITableView *)tableView;

@end
