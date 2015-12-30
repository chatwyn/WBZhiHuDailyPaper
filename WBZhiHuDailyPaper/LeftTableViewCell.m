
//
//  LeftTableViewself.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/22.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "LeftTableViewCell.h"
#import "Theme.h"

#import <objc/runtime.h>
@implementation LeftTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = kClearColor;
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = kColor(31, 38, 46, 1);
        self.textLabel.textColor = kColor(128, 133, 140, 1);
        self.textLabel.highlightedTextColor = kWhiteColor;
    }
    return self;
}

- (void)setTheme:(Theme *)theme{
    _theme = theme;
    self.textLabel.text = theme.name;
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}


@end
