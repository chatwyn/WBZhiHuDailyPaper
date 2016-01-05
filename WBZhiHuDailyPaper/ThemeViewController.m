//
//  ThemeViewController.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/22.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "ThemeViewController.h"
#import "AppDelegate.h"
#import "MainController.h"
#import "ThemeNewsTool.h"
#import "TableViewDataSource.h"
#import "HomeCell.h"
#import "StoryModel.h"
#import "TopImageView.h"
#import "Theme.h"
#import "UIImageView+WebCache.h"
#import "CircleRefreshView.h"
#import "ContainerController.h"

static NSString *const homeCellIdentifier = @"HomeCell";

@interface ThemeViewController ()
<UITableViewDelegate,
HomeCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) TopImageView *topView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) ThemeNews *themeNews;
@property (nonatomic, strong) TopImageView *naviView;

@property (nonatomic, strong) TableViewDataSource *tableViewDataSource;

@property (nonatomic, strong) CircleRefreshView *refreshView;

@property (nonatomic, strong) ThemeNewsTool *tool;

@end

@implementation ThemeViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.refreshView];
    
}

- (void)dealloc{
    [self.tableView removeObserver:self.topView forKeyPath:@"contentOffset"];
}
#pragma mark - HomeCell Delegate

- (UIViewController *)getViewControllerWithId:(NSNumber *)storyId{
    ContainerController *container = [[ContainerController alloc] init];
    container.tool = self.tool;
    container.storyId = storyId;
    return container;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StoryModel *story = [self.tableViewDataSource itemAtIndexPath:indexPath];
    ContainerController *container = [[ContainerController alloc] init];
    container.tool = self.tool;
    container.storyId = story.id;
    [self.navigationController pushViewController:container animated:YES];
}

#pragma mark - private method
- (void)openLeftSide{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.mainViewController toggleDrawerSide:MMDrawerSideLeft
                                         animated:YES
                                       completion:nil];
}

- (void)updateData{
    [self.tool getThemeNewsWithId:self.theme.id SuccessfulBlock:^(id obj) {
        self.themeNews = obj;
        [self.topView sd_setImageWithURL:[NSURL URLWithString:self.themeNews.image]];
        [self setDataSource];
        [self.refreshView endRefreshing];
    }];
}

- (void)setDataSource{
    
    TableViewCellConfigureBlock configureCell = ^(HomeCell *cell, StoryModel *story) {
        story.multipic = NO;
        cell.storyModel = story;
        cell.delegate = self;
        [self registerForPreviewingWithDelegate:cell sourceView:cell.contentView];
    };
    
    self.tableViewDataSource = [[TableViewDataSource alloc] initWithItems:self.themeNews.stories
                                                           cellIdentifier:homeCellIdentifier
                                                       configureCellBlock:configureCell];
    self.tableView.dataSource = self.tableViewDataSource;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell"
                                               bundle:nil]
         forCellReuseIdentifier:homeCellIdentifier];
    self.tableView.rowHeight = 90;
    [self.tableView reloadData];
    
}

#pragma mark - getter and setter

- (TopImageView *)topView{
    
    if (_topView == nil) {
        _topView = [TopImageView attachToTableView:self.tableView];
        _topView.backgroundColor = kColor(23, 144, 211, 1);
    }
    return _topView;
    
}

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, kScreenWidth, kScreenHeight - 55)];
        _tableView.delegate = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = kWhiteColor;
    }
    return _tableView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.centerY = 25;
    }
    return _titleLabel;
}

- (UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 25, 25)];
        [_backBtn addTarget:self
                     action:@selector(openLeftSide)
           forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setImage:[UIImage imageNamed:@"News_Arrow"]
                  forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (void)setTheme:(Theme *)theme{
    _theme = theme;
    
    self.tableView.contentOffset = CGPointMake(0, 0);
    
    self.titleLabel.attributedText = [[NSAttributedString alloc]
                                      initWithString:self.theme.name
                                      attributes:@{NSFontAttributeName:
                                                       [UIFont systemFontOfSize:18] ,
                                                   NSForegroundColorAttributeName:
                                                       [UIColor whiteColor]}];
    [self.titleLabel sizeToFit];
    _titleLabel.centerX = self.view.centerX;
    self.refreshView.x = self.titleLabel.x - 30;
    
    [self updateData];
    
    
}

- (CircleRefreshView *)refreshView{
    if (_refreshView == nil) {
        _refreshView = [CircleRefreshView attachObserveToScrollView:self.tableView
                                                             target:self
                                                             action:@selector
                        (updateData)];
        _refreshView.frame = CGRectMake(10, 20, 20, 20);
        _refreshView.centerY = 35;
    }
    return _refreshView;
}

- (ThemeNewsTool *)tool{
    if (_tool == nil) {
        _tool = [[ThemeNewsTool alloc] init];
    }
    return _tool;
}

@end
