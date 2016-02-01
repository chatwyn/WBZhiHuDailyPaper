//
//  HomePageController.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/18.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "HomePageController.h"
#import "ContainerController.h"
#import "DetailViewController.h"

#import "ArrayDataSource.h"
#import "StoryModelTool.h"

#import "AppDelegate.h"
#import "MainController.h"

#import "HomeCell.h"
#import "HomeHeaderView.h"
#import "CycleScrollView.h"
#import "CircleRefreshView.h"

static CGFloat const rowHeight = 90.f;
static CGFloat const sectionHeight = 35.f;
static NSString * const homeCellIdentifier = @"HomeCell";

@interface HomePageController ()
<UITableViewDelegate,
HomeCellDelegate>

@property (nonatomic, strong) StoryModelTool *tool;
@property (nonatomic, strong) ArrayDataSource *newsArrayDataSource;
@property (nonatomic, strong) NSMutableArray *stories;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CycleView *headerView;
@property (nonatomic, strong) UIView *naviBar;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftSideButton;
@property (nonatomic, strong) CircleRefreshView *refreshView;

@end

@implementation HomePageController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.naviBar];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.leftSideButton];
    [self.view addSubview:self.refreshView];
    
    [self.tool loadNewStoriesWithCallBack:^(id obj) {
        [self setTableViewWithArray:obj];
    }];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offSetY = scrollView.contentOffset.y;
    //    上拉刷新
    if (offSetY  > scrollView.contentSize.height - 1.5 * kScreenHeight) {
        [_tool loadFormerStoriesWithUpdateBack:^{
            
            [self.tableView insertSections:
             [NSIndexSet indexSetWithIndex:self.stories.count -1]
                          withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    
    if (offSetY<=0&&offSetY>=-90)  _naviBar.alpha = 0;
    else if(offSetY <= 500) _naviBar.alpha = offSetY/200;
    
}

#pragma mark - HomeCell Delegate
- (UIViewController *)getViewControllerWithId:(NSNumber *)storyId{
    ContainerController *container = [[ContainerController alloc] init];
    container.tool = self.tool;
    container.storyId = storyId;
    return container;
}

#pragma mark - UITablView Delegte
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StoryModel *storyModel = [self.newsArrayDataSource itemAtIndexPath:indexPath];
    [self pushViewDetailViewControllerWithStoryModel:storyModel];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeHeaderView *headerView = [HomeHeaderView HomeHeaderViewWithTableView:tableView];
    SectionModel *dailyStory =  self.stories[section];
    headerView.date = dailyStory.date;
    return section?headerView:nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //    写成0  display  不会在0的section 执行
    return section?sectionHeight:CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == 0) {
        _naviBar.height = 55;
        _titleLabel.alpha = 1;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == 0) {
        _naviBar.height = 20;
        _titleLabel.alpha = 0;
    }
}

#pragma mark - event response
- (void)openLeftSide{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.mainViewController toggleDrawerSide:MMDrawerSideLeft
                                         animated:YES
                                       completion:nil];
}

#pragma mark - private method
- (void)setTableViewWithArray:(id)obj{
    self.stories = obj;
    SectionModel *sm = self.stories.firstObject;
    [self setUpDataSource];
    self.headerView.topStories = sm.top_stories;
    [self.view insertSubview:self.tableView belowSubview:self.headerView];
}

//下拉刷新第一组
-(void)updateData{
    [self.tool updateStoriesWithCallBack:^{
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                      withRowAnimation:UITableViewRowAnimationFade];
        SectionModel *sm = self.stories.firstObject;
        
        self.headerView.topStories = sm.top_stories;
        [self.refreshView endRefreshing];
    }];
}

- (void)setUpDataSource{
    TableViewCellConfigureBlock configureCell = ^(HomeCell *cell, StoryModel * story) {
        cell.storyModel = story;
        cell.delegate = self;
        [self registerForPreviewingWithDelegate:cell sourceView:cell.contentView];
        
    };
    self.newsArrayDataSource = [[ArrayDataSource alloc]initWithItems:self.stories
                                                      cellIdentifier:homeCellIdentifier
                                                  configureCellBlock:configureCell];
    self.tableView.dataSource = self.newsArrayDataSource;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell"
                                               bundle:nil]
         forCellReuseIdentifier:homeCellIdentifier];
}

- (void)pushViewDetailViewControllerWithStoryModel:(StoryModel *)storyModel{
    ContainerController *container = [[ContainerController alloc] init];
    container.tool = self.tool;
    container.storyId = storyModel.id;
    [self.navigationController pushViewController:container animated:YES];
}

#pragma mark - getter and setter
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20,kScreenWidth, kScreenHeight - 20)
                                                  style:UITableViewStylePlain];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        _tableView.rowHeight = rowHeight;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (CycleView *)headerView{
    if (_headerView == nil) {
        _headerView = [CycleView attchToView:self.view
                           observeScorllView:self.tableView];
        __weak typeof(self) weakSelf = self;
        _headerView.topViewBlock = ^(StoryModel *storyModel){
            [weakSelf pushViewDetailViewControllerWithStoryModel:storyModel];
        };
        
    }
    return _headerView;
}

- (StoryModelTool *)tool{
    if (_tool == nil) {
        _tool = [[StoryModelTool alloc] init];
    }
    return _tool;
}

- (UIView *)naviBar{
    if (_naviBar == nil) {
        _naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
        _naviBar.backgroundColor = kColor(23, 144, 211, 1);
        _naviBar.alpha = 0;
    }
    return _naviBar;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.attributedText = [[NSAttributedString alloc]
                                      initWithString:@"今日热闻"
                                      attributes:@{NSFontAttributeName:
                                                       [UIFont
                                                        systemFontOfSize:18],NSForegroundColorAttributeName:
                                                       [UIColor whiteColor]}];
        [_titleLabel sizeToFit];
        _titleLabel.centerX = self.view.centerX;
        _titleLabel.centerY = 35;
    }
    return _titleLabel;
}

- (UIButton *)leftSideButton{
    if (_leftSideButton == nil) {
        _leftSideButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 30, 30)];
        [_leftSideButton addTarget:self
                            action:@selector(openLeftSide)
                  forControlEvents:UIControlEventTouchUpInside];
        [_leftSideButton setImage:[UIImage imageNamed:@"Home_Icon"]
                         forState:UIControlStateNormal];
    }
    return _leftSideButton;
}

- (CircleRefreshView *)refreshView{
    if (_refreshView == nil) {
        _refreshView = [CircleRefreshView attachObserveToScrollView:self.tableView
                                                             target:self
                                                             action:@selector
                        (updateData)];
        _refreshView.frame = CGRectMake(10, 20, 20, 20);
        _refreshView.centerY = 35;
        _refreshView.x = self.titleLabel.x - 30;
    }
    return _refreshView;
}

@end
