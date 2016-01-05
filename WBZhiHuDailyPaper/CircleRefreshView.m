//
//  CircleRefreshView.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/22.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "CircleRefreshView.h"

@interface CircleRefreshView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

@property (nonatomic, assign, getter = isRefreshing) BOOL refreshing;
@property (nonatomic, assign, getter = isCanLoading) BOOL canLoading;
@property (nonatomic, assign, getter = isHidding) BOOL hidding;

@property (nonatomic, assign) CGFloat offsetY;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation CircleRefreshView


+ (CircleRefreshView *)attachObserveToScrollView:(UIScrollView *)scrollView
                                   target:(id)target
                                   action:(SEL)action{
    
    CircleRefreshView *refreshView = [[CircleRefreshView alloc] init];
    
    refreshView.scrollView = scrollView;
    refreshView.target = target;
    refreshView.action = action;
    refreshView.backgroundColor = [UIColor clearColor];
    
    refreshView.activityView = [[UIActivityIndicatorView alloc] init];
    refreshView.activityView.hidesWhenStopped = YES;
    [refreshView.activityView stopAnimating];
    [refreshView addSubview:refreshView.activityView];
    
    [refreshView.scrollView addObserver:refreshView
                             forKeyPath:@"contentOffset"
                                options:NSKeyValueObservingOptionNew |
     NSKeyValueObservingOptionOld
                                context:nil];
    
    return refreshView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    UIScrollView *scrollView = object;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    self.offsetY = offsetY;
    
    if (self.hidding && offsetY >=0) {
        self.hidding = NO;
        self.refreshing = NO;
        [self.activityView stopAnimating];
    }
    
    if (self.isRefreshing) {
        return;
    }
    
    if (offsetY < -60.f && offsetY >= -90.f && !self.scrollView.isDragging){
        
        self.refreshing = YES;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.activityView startAnimating];
        [self.target performSelector:self.action withObject:nil];
#pragma clang diagnostic pop
        
    }
    [self setNeedsDisplay];
}

#pragma mark - private method
- (void)endRefreshing{
   
    if (self.scrollView.contentOffset.y < 0) self.hidding = YES;
    else {
         self.refreshing = NO;
        [self.activityView stopAnimating];
    }
}


- (void)drawRect:(CGRect)rect{
    
    if (self.scrollView.contentOffset.y >=0 || self.isRefreshing) {
        return;
    }
    
    CGFloat radius = (self.width - 5) * 0.5;
    
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGContextAddArc(context2, self.width * 0.5, self.width * 0.5, radius,0, M_PI * 2, 0);
    [[UIColor lightGrayColor] set];
    CGContextStrokePath(context2);
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat endAngle = - M_PI / 30 * self.offsetY - M_PI * 1.5;
    
    CGContextAddArc(context, self.width * 0.5, self.width * 0.5, radius, - M_PI * 1.5, endAngle, 0);
    [[UIColor whiteColor] set];
    CGContextStrokePath(context);
    
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.activityView.frame = self.bounds;
}


@end
