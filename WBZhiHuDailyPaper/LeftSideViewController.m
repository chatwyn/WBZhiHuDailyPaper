//
//  LeftSideViewController.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/18.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "LeftSideViewController.h"
#import "MainController.h"
#import "ThemeViewController.h"

#import "ThemeTool.h"
#import "MJExtension.h"
#import "TableViewDataSource.h"
#import "OverAllSetting.h"

#import "LeftTableViewCell.h"

static NSString * const leftCell = @"leftCell";
static NSString * const isNight = @"isNight";

@interface LeftSideViewController ()<UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *themes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UINavigationController *naviVC;
@property (nonatomic, strong) ThemeViewController *themeVC;
@property (nonatomic, strong) TableViewDataSource *tableViewDataSource;

@property (weak, nonatomic) IBOutlet UIButton *nightBtn;

@end

@implementation LeftSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ThemeTool getThemesWithSuccessfulBlock:^(id obj) {
        [self.themes addObjectsFromArray:obj];
        [self setDataSource];
    }];
    
    
    BOOL night = [[NSUserDefaults standardUserDefaults] boolForKey:isNight];
    [OverAllSetting shareSetting].night = night;
    self.nightBtn.selected = night;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    选中首页
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.selected = NO;
    });
    
    Theme *theme = self.themes[indexPath.row];
    if (indexPath.row == 0) {
        [self.delegate setCenterViewController:self.delegate.naviController withCloseAnimation:YES completion:nil];
    }else{
        self.themeVC.theme = theme;
        [self.delegate setCenterViewController:self.naviVC withCloseAnimation:YES completion:nil];
    }
    
}
- (IBAction)nightDaySwitch:(UIButton *)sender {
    sender.selected =! sender.selected;
    
    [OverAllSetting shareSetting].night = sender.selected;
    [[NSUserDefaults standardUserDefaults] setBool:sender.selected forKey:isNight];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

#pragma mark - private method
- (void)setDataSource{
    
    TableViewCellConfigureBlock configureCell = ^(LeftTableViewCell *cell, Theme *theme) {
        cell.theme = theme;
    };
    
    self.tableViewDataSource = [[TableViewDataSource alloc] initWithItems:self.themes
                                                           cellIdentifier:leftCell
                                                       configureCellBlock:configureCell];
    self.tableView.dataSource = self.tableViewDataSource;
    
    [self.tableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:leftCell];
    self.tableView.rowHeight = 50;
    [self.tableView reloadData];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.selected = YES;
    
}

#pragma mark - setter and getter
- (NSMutableArray *)themes{
    if (_themes == nil) {
        _themes = [NSMutableArray array];
        Theme *theme = [[Theme alloc] init];
        theme.name =  @"首页";
        [_themes addObject:theme];
    }
    return _themes;
}

- (UINavigationController *)naviVC{
    
    if (_naviVC == nil) {
        _naviVC = [[UINavigationController alloc] initWithRootViewController:self.themeVC];
        _naviVC.navigationBar.hidden = YES;
    }
    return _naviVC;
}

- (ThemeViewController *)themeVC{
    if (_themeVC == nil) {
        _themeVC = [[ThemeViewController alloc] init];
        _themeVC.view.backgroundColor = kWhiteColor;
    }
    return _themeVC;
}

@end
