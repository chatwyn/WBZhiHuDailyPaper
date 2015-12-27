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

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:kScreenBounds];
 
    self.mainViewController = [[MainController alloc] init];
    self.window.rootViewController = self.mainViewController;
    
    [self.window makeKeyAndVisible];
    
    [self.window showLanuchPage];

    return YES;
}

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
