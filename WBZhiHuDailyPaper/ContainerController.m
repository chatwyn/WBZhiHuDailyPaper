//
//  ContainerController.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/24.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "ContainerController.h"
#import "NewsNavigation.h"

#import "DetailViewController.h"

#import "DetailViewTool.h"
#import "ThemeNewsTool.h"
#import "MBProgressHUD+MJ.h"
//#import "UMSocial.h"

#import "AppDelegate.h"
#import "MainController.h"

#import "DetailStory.h"

typedef NS_OPTIONS(NSUInteger, NavigationTag){
    NavigationTagBack = 1 << 0,
    NavigationTagNext = 1 << 1,
    NavigationTagVote = 1 << 2,
    NavigationTagShare = 1 << 3,
    NavigationTagComment = 1 << 4,
};

static CGFloat const animationDuraion = 0.2f;

@interface ContainerController ()
<NewsNavigationDelegate,
DetailViewControllerDelegate>

@property (nonatomic, strong) NewsNavigation *naviView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) DetailViewController *detailVc;

@property (nonatomic, strong) DetailStory *story;

@end

@implementation ContainerController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.naviView];
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    self.detailVc = [self setContainerController];
    
    [self.scrollView addSubview:self.detailVc.view];
    [self addChildViewController:self.detailVc];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.mainViewController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

- (void)dealloc{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.mainViewController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - 3Dtouch 下栏
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    
    UIPreviewAction *p1 =[UIPreviewAction actionWithTitle:@"分享" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
//        [UMSocialData defaultData].extConfig.qqData.title = @"文博日报";
//        [UMSocialData defaultData].extConfig.qqData.url = self.story.share_url;
//        
//        [[UMSocialDataService defaultDataService]
//         postSNSWithTypes:@[UMShareToQQ]
//         content:self.story.title
//         image:[UIImage imageWithData:
//                [NSData dataWithContentsOfURL:
//                 [NSURL URLWithString:self.story.image]]]
//         location:nil urlResource:nil
//         presentedController:self completion:^(UMSocialResponseEntity *response){
//             [MBProgressHUD showSuccess:@"分享成功"];
//        }];
//        
    }];

    
    NSArray *actions = @[p1];
    return actions;
}

#pragma mark - DetailViewControllerDelegate
- (void)scrollToNextViewWithNumber:(NSNumber *)storyId{
    
    self.storyId = storyId;
    [self setContentOffset:2.f];
    
}

- (void)scrollToLastViewWithNumber:(NSNumber *)storyId{
    
    self.storyId = storyId;
    [self setContentOffset:0.f];
    
}

#pragma mark - NewsNavigationDelegate
- (void)didTouchUpNaviBar:(NewsNavigation *)naviBar btnTag:(NSInteger)tag{
    switch (tag) {
        case NavigationTagBack:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case NavigationTagNext:
            if (![self.tool isTheLastNewsWithStoryId:self.storyId]) {
                [self scrollToNextViewWithNumber:[self.tool getNextNewsWithId:self.storyId]];
            }
            break;
        case NavigationTagVote:

            break;
        case NavigationTagShare:
//            [self share];
            break;
        case NavigationTagComment:
            
            break;
    }
}


#pragma mark - private method
//- (void)share{
//    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
//    [UMSocialData defaultData].extConfig.qqData.title = @"文博日报";
//    [UMSocialData defaultData].extConfig.qqData.url = self.story.share_url;
//    
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.story.share_url;
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"文博日报";
//    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:self.story.share_url];
//    
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:nil
//                                      shareText:self.story.title
//                                     shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.story.image]]]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQQ,UMShareToRenren,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToInstagram,UMShareToLWSession,nil]
//                                       delegate:nil];
//}

/**
 *  创建一个子控制器
 *
 *  @return 子控制器
 */
- (DetailViewController *)setContainerController{
    
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.view.frame = CGRectMake(0, self.scrollView.height, kScreenWidth, self.scrollView.height);
    detail.storyId = self.storyId;
    _naviView.id = self.storyId;
    detail.tool = self.tool;
    detail.delegate = self;
    return detail;
}

//设置滚动偏移值
- (void)setContentOffset:(CGFloat)number{
    
    DetailViewController *dvc = [self setContainerController];
    
    [UIView animateWithDuration:animationDuraion animations:^{
        self.scrollView.contentOffset = CGPointMake(0, number * kScreenHeight);
    } completion:^(BOOL finished) {
        [self.detailVc removeFromParentViewController];
        [self.detailVc.view removeFromSuperview];
        self.detailVc = nil;
        self.scrollView.contentOffset = CGPointMake(0, kScreenHeight);
        self.detailVc = dvc;
        [self.scrollView addSubview:self.detailVc.view];
        [self addChildViewController:self.detailVc];
    }];
    
}

#pragma mark - getter and setter
- (void)setStoryId:(NSNumber *)storyId{
    _storyId = storyId;
    [DetailViewTool getDetailStoryWithStoryId:storyId Callback:^(id obj) {
        self.story = obj;
        
    }];
}

- (NewsNavigation *)naviView{
    if (_naviView == nil) {
        _naviView = [[NewsNavigation alloc] initWithFrame:CGRectMake(0, kScreenHeight - 40, kScreenWidth, 40)];
        _naviView.delegate = self;
    }
    return _naviView;
}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth, 3 * kScreenHeight);
        _scrollView.contentOffset = CGPointMake(0, kScreenHeight);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}


@end
