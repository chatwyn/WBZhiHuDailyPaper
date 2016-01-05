//
//  AppDelegate.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/18.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "AppDelegate.h"
#import "UIWindow+Expand.h"
#import "SDWebImageManager.h"
#import "MainController.h"
//#import "UMSocialSnsService.h"

//取消了登陆和分享，友盟有点占空间，全部注释了，你可重新导入框架 ，把注释取消使用

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:kScreenBounds];
    
    self.mainViewController = [[MainController alloc] init];
    
    self.window.rootViewController = self.mainViewController;
    [self.window makeKeyAndVisible];
    
    [self.window showLanuchPageAndSetUmeng];
    
    return YES;
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    if (result == FALSE) {
//        //调用其他SDK，例如支付宝SDK等
//    }
//    return result;
//}


- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
    
    if([shortcutItem.type isEqualToString:@"one"]){
        
    }
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
    [[SDWebImageManager sharedManager] cancelAll];
    
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
}

- (void)applicationWillResignActive:(UIApplication *)application{
    
    [[SDWebImageManager sharedManager] cancelAll];
    
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}


@end
