//
//  UIWindow+Expand.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/18.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "UIWindow+Expand.h"
#import "LaunchViewController.h"

//#import "UMSocial.h"
//#import "UMSocialQQHandler.h"
//#import "UMSocialWechatHandler.h"
//#import "UMSocialSinaHandler.h"

@implementation UIWindow (Expand)

- (void)showLanuchPageAndSetUmeng{
    
    LaunchViewController *launchVC = [[LaunchViewController alloc] init];
    
//    [UMSocialData setAppKey:@"56824fe767e58eb93c0013fc"];
//    [UMSocialQQHandler setQQWithAppId:@"1105056922" appKey:@"iEGmtUwfoi57t2AP" url:@"http://www.umeng.com/social"];
//    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
//    [UMSocialWechatHandler setWXAppId:@"wx6784349eec646c51" appSecret:@"896b5288b28948115539b050ece07ba5" url:@"http://sns.whalecloud.com/sina2/callback"];
    
    [self addSubview:launchVC.view];
    
}

@end
