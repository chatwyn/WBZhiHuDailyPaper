//
//  DetailHeaderView.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/23.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "DetailHeaderView.h"
#import <objc/message.h>

static float const animatinDuration = 0.2f;

@interface DetailHeaderView ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *arrowImage;

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, assign, getter = isLoading) BOOL loading;

@end



@implementation DetailHeaderView

+ (DetailHeaderView *)attachObserveToScrollView:(UIScrollView *)scrollView
                                         target:(id)target
                                         action:(SEL)action{
    
    DetailHeaderView *headerView = [[DetailHeaderView alloc] init];
    
    headerView.scrollView = scrollView;
    headerView.target = target;
    headerView.action = action;
    headerView.x = 0;
    headerView.backgroundColor = [UIColor clearColor];
    headerView.size = CGSizeMake(kScreenWidth, 30);
    
    [headerView initViews];
    
    [headerView.scrollView addObserver:headerView
                            forKeyPath:@"contentOffset"
                               options:NSKeyValueObservingOptionNew |
     NSKeyValueObservingOptionOld
                               context:nil];
    
    return headerView;
    
}

- (void)initViews{
    [self addSubview:self.label];
    [self addSubview:self.arrowImage];
    
    self.arrowImage.frame = CGRectMake(130,5, 15,20);
    self.label.x = self.arrowImage.x + self.arrowImage.width + 10;
    self.label.centerY = self.arrowImage.centerY;
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    UIScrollView *scrollView = object;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY >= 0.f) {
        return;
    }
    
    if (offsetY < - 60.f) {
        [UIView animateWithDuration:animatinDuration animations:^{
            self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
        }];
        
        if (!self.scrollView.isDragging&&!self.loading) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.target performSelector:self.action withObject:nil];
#pragma clang diagnostic pop
            
            self.loading = YES;
        }
        
    }else {
        [UIView animateWithDuration:animatinDuration animations:^{
            self.arrowImage.transform = CGAffineTransformIdentity;
        }];
        
        
    }
}
- (UILabel *)label{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.attributedText = [[NSAttributedString alloc]
                                 initWithString:@"载入上一篇"
                                 attributes:@{NSFontAttributeName:
                                                  [UIFont systemFontOfSize:13]
                                              ,
                                              NSForegroundColorAttributeName:
                                                  [UIColor grayColor]}];
        [_label sizeToFit];
    }
    return _label;
}

- (UIImageView *)arrowImage{
    
    if (_arrowImage == nil) {
        _arrowImage = [[UIImageView alloc] init];
        _arrowImage.image = [UIImage imageNamed:@"ZHAnswerViewBackIcon"];
    }
    return _arrowImage;
}

- (void)dealloc{
    
}
@end
