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
#import "CWAccountTool.h"
#import "LoginController.h"

#import "LeftTableViewCell.h"

static NSString * const leftCell = @"leftCell";
static NSString * const isNight = @"isNight";

@interface LeftSideViewController ()
<UITableViewDelegate,
LoginControllerDelegate>

@property (nonatomic, strong) NSMutableArray *themes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UINavigationController *naviVC;
@property (nonatomic, strong) ThemeViewController *themeVC;
@property (nonatomic, strong) TableViewDataSource *tableViewDataSource;

@property (weak, nonatomic) IBOutlet UIButton *nightBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LeftSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    获取账号信息
    [self updateAccount];
    
    [ThemeTool getThemesWithSuccessfulBlock:^(id obj) {
        [self.themes addObjectsFromArray:obj];
        [self setDataSource];
    }];
    
    
    BOOL night = [[NSUserDefaults standardUserDefaults] boolForKey:isNight];
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

    [[NSUserDefaults standardUserDefaults] setBool:sender.selected forKey:isNight];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
#pragma mark - event response
- (IBAction)Login:(id)sender {
    LoginController *lvc = [[LoginController alloc] init];
    lvc.delegate = self;
    [self presentViewController:lvc animated:YES completion:nil];
    
}

#pragma mark - private method

- (void)updateAccount{
    CWAccount *account = [CWAccountTool account];
    if (!account)  return;

    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:account.iconUrl]]];
    image = [self OriginImage:image scaleToSize:CGSizeMake(35, 35)];
    [self.loginBtn setImage:image forState:UIControlStateNormal];
    self.loginBtn.imageView.layer.cornerRadius = self.loginBtn.imageView.width * 0.5;
    self.loginBtn.imageView.layer.masksToBounds = YES;
    self.loginBtn.imageView.size = CGSizeMake(35, 35);
    [self.loginBtn setTitle:account.usernName forState:UIControlStateNormal];
}

- (UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

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
