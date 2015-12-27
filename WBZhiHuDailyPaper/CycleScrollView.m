//
//  CycleScrollView.m
//  WBZhiHuDailyPaper
//
//  Created by caowenbo on 15/12/21.
//  Copyright © 2015年 曹文博. All rights reserved.
//

#import "CycleScrollView.h"
#import "StoryModel.h"
#import "DetailStory.h"
#import "UIImageView+WebCache.h"

static CGFloat const animationDuration = 5.0;

@interface NSTimer (Addition)

- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end//Addition

@implementation NSTimer (Addition)

-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end //Addition

@interface CycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, assign) NSInteger totalPageCount;
@property (nonatomic, strong) NSMutableArray *contentViews;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, strong) UIPageControl *pageControl;


/** 数据源：获取总的page个数  */
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/** 数据源：获取第pageIndex个位置的contentView  */
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/** 当点击的时候，执行的block */
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

@end

@implementation CycleScrollView

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    _totalPageCount = totalPagesCount();
    if (_totalPageCount > 0) {
        [self configContentViews];
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        self.pageControl =  [[UIPageControl alloc] init];
        self.pageControl.centerX = self.centerX;
        self.pageControl.y = self.scrollView.height - 10;
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        self.currentPageIndex = 0;
    }
    
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.scrollView.frame = self.bounds;
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        UIView *view = self.scrollView.subviews[i];
        view.height = self.scrollView.height;
        self.pageControl.y = self.scrollView.height - 10;
    }
}

#pragma mark - private method

- (void)configContentViews
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    self.pageControl.numberOfPages = _totalPageCount;
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {
        [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        [self configContentViews];
    }
    self.pageControl.currentPage = self.currentPageIndex;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}


#pragma mark - event response

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}

@end//CycleScrollView

@interface TopView ()

@property (nonatomic, strong) StoryModel *storyModel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) UIWebView *scrollView;

@property (nonatomic, assign, getter=isObserve) BOOL observe;

@end

@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame
                   storyModel:(StoryModel *)storyModel{
    TopView *view = [[[NSBundle mainBundle] loadNibNamed:@"TopView"
                                                   owner:self
                                                 options:nil]
                     lastObject];
    view.frame = frame;
    view.storyModel = storyModel;
    return view;
    
}

+ (instancetype)attchToView:(UIView *)view
          observeScorllView:(UIWebView *)webView{
    
    TopView *topView = [[[NSBundle mainBundle] loadNibNamed:@"TopView"
                                                      owner:self
                                                    options:nil]
                        lastObject];
    topView.frame = CGRectMake(0, -45, kScreenWidth, 265);
    topView.observe = YES;
    [view addSubview:topView];
    topView.scrollView = webView;
    [webView.scrollView addObserver:topView
                         forKeyPath:@"contentOffset"
                            options:NSKeyValueObservingOptionNew
                            context:nil];
    return topView;
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context{
    UIScrollView *scrollView = object;
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY<=0&&offSetY>=-90) {
        self.frame = CGRectMake(0, -45 - 0.5 * offSetY, kScreenWidth, 265 - 0.5 * offSetY);
    }else if(offSetY<-90){
        self.scrollView.scrollView.contentOffset = CGPointMake(0, -90);
    }else if(offSetY <= 500) {
        
        if (offSetY <= 220) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        }else [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
        self.y = -45 - offSetY;
    }
    
}

- (void)dealloc{
    if (self.isObserve) {
        [self.scrollView.scrollView removeObserver:self
                                        forKeyPath:@"contentOffset"];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    
}

- (void)setDetailStory:(DetailStory *)detailStory{
    _detailStory = detailStory;
    self.titleLabel.text =  detailStory.title;
    self.sourceLabel.text = [NSString stringWithFormat:@"图片:%@",detailStory.image_source];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:detailStory.image] placeholderImage:[UIImage imageNamed:@"Field_Mask_Bg"]];
    
}

- (void)setStoryModel:(StoryModel *)storyModel{
    _storyModel = storyModel;
    self.titleLabel.text = storyModel.title;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:storyModel.image] placeholderImage:[UIImage imageNamed:@"Field_Mask_Bg"]];
}

@end

@interface CycleView ()

@property (nonatomic, weak)UIScrollView *myScrollView;

@end

@implementation CycleView

+ (instancetype)attchToView:(UIView *)view
          observeScorllView:(UIScrollView *)scrollView{
    
    CycleView *cycleView = [[CycleView alloc] initWithFrame:CGRectMake(0, -45, kScreenWidth, 265)];
    cycleView.myScrollView = scrollView;
    [scrollView addObserver:cycleView
                 forKeyPath:@"contentOffset"
                    options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                    context:nil];
    return cycleView;
    
}

- (void)setTopStories:(NSArray *)topStories{
    _topStories = topStories;
    
    __weak typeof(self) weakSelf = self;
    
    self.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return [[TopView alloc] initWithFrame:weakSelf.frame storyModel:topStories[pageIndex]];
    };
    
    self.totalPagesCount = ^NSInteger(void){
        return topStories.count;
    };
    
    self.TapActionBlock = ^(NSInteger pageIndex){
        weakSelf.topViewBlock(topStories[pageIndex]);
    };
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context{
    
    UIScrollView *scrollView = object;
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY<=0&&offSetY>=-90) {
        self.frame = CGRectMake(0, -45 - 0.5 * offSetY, kScreenWidth, 265 - 0.5 * offSetY);
    }else if(offSetY<-90){
        self.myScrollView.contentOffset = CGPointMake(0, -90);
    }else if(offSetY <= 500) {
        self.y = -45 - offSetY;
    }
}

- (void)dealloc{
    [self.myScrollView removeObserver:self
                           forKeyPath:@"contentOffset"];
}

@end//CycleView

