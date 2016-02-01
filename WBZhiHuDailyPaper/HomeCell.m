//
//  HomeCell.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/19.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "HomeCell.h"
#import "StoryModel.h"
#import "UIImageView+WebCache.h"

@interface HomeCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *multipicImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelConstraint;

@end

@implementation HomeCell

- (void)setStoryModel:(StoryModel *)storyModel{
    _storyModel = storyModel;
    
    self.titleLabel.text = storyModel.title;
    
    NSURL *url = [NSURL URLWithString:storyModel.images[0]];
    
    if (url) {
        self.titleLabelConstraint.constant = 15;
        self.iconImageView.hidden = NO;
        
        [self.iconImageView
         sd_setImageWithURL:[NSURL URLWithString:storyModel.images[0]]
         placeholderImage:[UIImage imageNamed:@"News_Avatar"]];
        
    }else{
        self.titleLabelConstraint.constant = -70;
        self.iconImageView.hidden = YES;
    }
    
    self.multipicImageView.hidden = !storyModel.isMutipic;
    
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    
    UIViewController *vc = [self.delegate getViewControllerWithId:self.storyModel.id];
    
    return vc;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}
@end
