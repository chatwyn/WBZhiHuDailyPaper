//
//  NewsNavigation.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/20.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "NewsNavigation.h"
#import "DetailViewTool.h"
#import "DetailStory.h"

@interface NewsNavigation ()

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *voteBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *commentBtn;

@property (nonatomic, strong) UILabel *voteLabel;
@property (nonatomic, strong) UILabel *commentLabel;

@end

@implementation NewsNavigation

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        [self addSubview:self.backBtn];
        [self addSubview:self.nextBtn];
        [self addSubview:self.voteBtn];
        [self addSubview:self.shareBtn];
        [self addSubview:self.commentBtn];
        [self.voteBtn addSubview:self.voteLabel];
        [self.commentBtn addSubview:self.commentLabel];
        
    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backBtn.frame = self.bounds;
    self.backBtn.width = self.width * 0.2;
    
    self.nextBtn.frame = self.backBtn.frame;
    self.nextBtn.x = self.backBtn.x + self.backBtn.width;
    
    self.voteBtn.frame = self.nextBtn.frame;
    self.voteBtn.x = self.nextBtn.x + self.nextBtn.width;
    
    self.shareBtn.frame = self.voteBtn.frame;
    self.shareBtn.x = self.voteBtn.x + self.shareBtn.width;
    
    self.commentBtn.frame = self.shareBtn.frame;
    self.commentBtn.x = self.shareBtn.x + self.shareBtn.width;
    
    self.voteLabel.x = self.voteBtn.width * 0.5;
    self.voteLabel.y = self.voteBtn.height * 0.2;
    self.voteLabel.width = self.voteBtn.width * 0.3;
    self.voteLabel.height = self.voteBtn.height * 0.2;
    
    self.commentLabel.x = self.commentBtn.width * 0.5;
    self.commentLabel.y = self.commentBtn.height * 0.2;
    self.commentLabel.width = self.commentBtn.width * 0.3;
    self.commentLabel.height = self.commentBtn.height * 0.2;
}


- (IBAction)touchUpNaviBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(didTouchUpNaviBar:btnTag:)]) {
        [self.delegate didTouchUpNaviBar:self
                                  btnTag:sender.tag];
    }
    
}

#pragma mark - getter and setter
- (void)setId:(NSNumber *)number{
    _id = number;
    
    [DetailViewTool getStoryExtraWithStoryId:number Callback:^(StoryExtra* obj) {
        self.commentLabel.text = [NSString stringWithFormat:@"%@",obj.comments];
        self.voteLabel.text = [NSString stringWithFormat:@"%@",obj.popularity];
        
    }];
    
    
}
- (UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"News_Navigation_Arrow"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(touchUpNaviBtn:) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.tag = 1;
    }
    return _backBtn;
}

- (UIButton *)nextBtn{
    if (_nextBtn == nil) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setImage:[UIImage imageNamed:@"News_Navigation_Next"] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(touchUpNaviBtn:) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.tag = 2;
    }
    return _nextBtn;
}

- (UIButton *)voteBtn{
    if (_voteBtn == nil) {
        _voteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voteBtn setImage:[UIImage imageNamed:@"News_Navigation_Vote"] forState:UIControlStateNormal];
        [_voteBtn setImage:[UIImage imageNamed:@"News_Navigation_Voted"] forState:UIControlStateSelected];
        [_voteBtn addTarget:self action:@selector(touchUpNaviBtn:) forControlEvents:UIControlEventTouchUpInside];
        _voteBtn.tag = 4;
    }
    return _voteBtn;
}

- (UIButton *)shareBtn{
    if (_shareBtn == nil) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"News_Navigation_Share"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(touchUpNaviBtn:) forControlEvents:UIControlEventTouchUpInside];
        _shareBtn.tag = 8;
    }
    return _shareBtn;
}

- (UIButton *)commentBtn{
    if (_commentBtn == nil) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setImage:[UIImage imageNamed:@"News_Navigation_Comment"] forState:UIControlStateNormal];
        [_commentBtn addTarget:self action:@selector(touchUpNaviBtn:) forControlEvents:UIControlEventTouchUpInside];
        _commentBtn.tag = 16;
    }
    return _commentBtn;
}

- (UILabel *)voteLabel{
    if (_voteLabel == nil) {
        _voteLabel = [[UILabel alloc] init];
        _voteLabel.textColor = [UIColor grayColor];
        _voteLabel.font = [UIFont systemFontOfSize:8.f];
        _voteLabel.text = @"222";
        _voteLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _voteLabel;
}

- (UILabel *)commentLabel{
    if (_commentLabel == nil) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.textColor = [UIColor whiteColor];
        _commentLabel.font = [UIFont systemFontOfSize:8.f];
        _commentLabel.text =  @"111";
        _commentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _commentLabel;
}

@end
