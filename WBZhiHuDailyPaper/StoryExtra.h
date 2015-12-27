//
//  StoryExtra.h
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/26.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryExtra : NSObject

/**long_comments  长评论总数*/
@property (nonatomic, strong) NSNumber *long_comments;
/**popularity  点赞总数*/
@property (nonatomic, strong) NSNumber *popularity;
/**short_comments  短评论总数*/
@property (nonatomic, strong) NSNumber *short_comments;
/**comments  评论总数*/
@property (nonatomic, strong) NSNumber *comments;

@end
