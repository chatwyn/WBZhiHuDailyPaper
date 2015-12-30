//
//  CWAccountTool.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/30.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#define CWAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "CWAccountTool.h"

@implementation CWAccountTool

+ (void)saveAccount:(CWAccount *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:CWAccountPath];
    
}

+ (CWAccount *)account{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:CWAccountPath];
    
}


@end
