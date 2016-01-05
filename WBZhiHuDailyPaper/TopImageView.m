//
//  TopImageView.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/22.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "TopImageView.h"

@interface TopImageView ()

#warning 以前用的strong是错误的，会导致循环引用无法释放
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation TopImageView

+ (TopImageView *)attachToTableView:(UITableView *)tableView{
    
    TopImageView *topView = [[TopImageView alloc] init];
    
    topView.scrollView = tableView;
    topView.contentMode = UIViewContentModeCenter;
    topView.clipsToBounds = YES;
    [topView.scrollView addObserver:topView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    topView.frame = CGRectMake(0, -45, kScreenWidth, 100);

    return topView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    UIScrollView *scrollView = object;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0 && offsetY >= -90) {
        self.y = -45 - 0.5 * offsetY;
        self.height = 100 - offsetY * 0.5;
    }else if(offsetY < -90){
        self.scrollView.contentOffset = CGPointMake(0, -90);
    }else{
        self.y = -45;
        self.height = 100;
    }
    
}

#warning 互相引用，会导致无法释放  用weak的话scrollView 会先释放
//- (void)dealloc{
//    [self.scrollView removeObserver:self forKeyPath:@"contentOffSet"];
//
//}
@end
