//
//  DetailViewController.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/20.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DetailViewController,ContainerController;

@protocol  DetailViewControllerDelegate <NSObject>

@optional
/**
 *  通知containerController滚动到下一个页面
 *
 */
- (void)scrollToNextViewWithNumber:(NSNumber *)storyId;

- (void)scrollToLastViewWithNumber:(NSNumber *)storyId;


@end


@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSNumber *storyId;

@property (nonatomic, strong) id tool;

@property (nonatomic, weak) id <DetailViewControllerDelegate> delegate;

@end
