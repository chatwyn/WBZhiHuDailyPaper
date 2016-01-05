//
//  LoginController.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/30.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "LoginController.h"
#import "LeftSideViewController.h"

//#import "UMSocial.h"
#import "CWAccountTool.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


- (void)loginWithAppName:(NSString *)name{
    
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:name];
//    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:name];
//            CWAccount *account = [[CWAccount alloc] init];
//            account.usernName = snsAccount.userName;
//            account.iconUrl = snsAccount.iconURL;
//            [CWAccountTool saveAccount:account];
//            [self.delegate updateAccount];
//            [self back];
//        }});
}

//- (IBAction)sinaLogin {
//    [self loginWithAppName:UMShareToSina];
//}
//
//- (IBAction)QQlogin {
//    [self loginWithAppName:UMShareToQQ];
//    
//}




@end
