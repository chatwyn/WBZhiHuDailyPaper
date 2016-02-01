//
//  StoryModelTool.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/19.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "StoryModelTool.h"
#import "MJExtension.h"
#import "HttpTool.h"
#import <objc/runtime.h>

@interface StoryModelTool ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign, getter=isLoading)BOOL loading;

@property (nonatomic, strong) NSMutableArray *newsIds;

@end

@implementation StoryModelTool

- (void)loadNewStoriesWithCallBack:(CallBack)callBack{
    
    [HttpTool get:@"http://news-at.zhihu.com/api/4/news/latest" params:nil success:^(id json) {
        SectionModel *sc = [SectionModel mj_objectWithKeyValues:json];
        [self.items addObject:sc];
//    计算现有的id
        [self calculteNewsIds];
        objc_setAssociatedObject([self class], @selector(items), sc.date, OBJC_ASSOCIATION_COPY_NONATOMIC);
        callBack(self.items);
    } failure:^(NSError *error) {
        nil;
    }];
}

- (void)updateStoriesWithCallBack:(UpdateBack)updateBack{
    [HttpTool get:@"http://news-at.zhihu.com/api/4/news/latest" params:nil success:^(id json) {
        SectionModel *sc = [SectionModel mj_objectWithKeyValues:json];
        [self.items replaceObjectAtIndex:0 withObject:sc];
        [self calculteNewsIds];
        updateBack(self.items);
    } failure:^(NSError *error) {
        nil;
    }];
}

- (void)loadFormerStoriesWithUpdateBack:(UpdateBack)updateBack{
    id data = objc_getAssociatedObject([self class], @selector(items));
    if (self.isLoading) {
        return;
    }
    self.loading = !self.loading;
    NSString *url = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/before/%@",data];

    [HttpTool get:url params:nil success:^(id json) {
        SectionModel *sc = [SectionModel mj_objectWithKeyValues:json];
        [self.items addObject:sc];
        [self calculteNewsIds];
        objc_setAssociatedObject([self class], @selector(items), sc.date, OBJC_ASSOCIATION_COPY_NONATOMIC);
        updateBack();
        self.loading = !self.loading;
    } failure:^(NSError *error) {
        nil;
    }];
}

- (BOOL)isTheFirstNewsWithStoryId:(NSNumber *)number{
    
    if ([number isEqual:self.newsIds[0]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isTheLastNewsWithStoryId:(NSNumber *)number{
    if ([number isEqual:self.newsIds.lastObject]) {
        return YES;
    }
    return NO;
}

#pragma mark - private method
- (void)calculteNewsIds{
    
    self.newsIds = [self.items valueForKeyPath:@"stories.id"];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i < self.newsIds.count; i++) {
        NSArray *array = self.newsIds[i];
        [arrayM addObjectsFromArray:array];
    }
    self.newsIds = arrayM;
    
}

- (NSNumber *)getNextNewsWithId:(NSNumber *)number{
    NSInteger index = [self.newsIds indexOfObject:number];

    return [self.newsIds objectAtIndex:++index];
    
}

- (NSNumber *)getLastNewsWithId:(NSNumber *)number{
    NSInteger index = [self.newsIds indexOfObject:number];

    return [self.newsIds objectAtIndex:--index];
}
#pragma mark - getter and setter

- (NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}
@end
