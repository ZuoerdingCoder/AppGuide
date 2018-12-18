//
//  SMAppGuideViewController.m
//  APPGuideDemo
//
//  Created by ZED on 2018/12/5.
//  Copyright © 2018年 ZED. All rights reserved.
//

#import "SMAppGuideViewController.h"

@interface SMAppGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *pageScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) NSMutableArray<UIImageView *> *imageViews;

@end

@implementation SMAppGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

#pragma mark - SetUp
- (void)setup {
    
    if ([self.guideImageNames count] == 0) {
        NSLog(@"GuideImageNames can not be null");
        return;
    }
    
    [self.view addSubview:self.pageScrollView];

    for (NSInteger i = 0; i < [self.guideImageNames count]; i++) {
        NSString *imgName = [self.guideImageNames objectAtIndex:i];
        UIImage *image = [UIImage imageNamed:imgName];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.pageScrollView addSubview:imageView];
        
        if( i == [self.guideImageNames count] - 1) {
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:self.closeButton];
        }
        [self.imageViews addObject:imageView];
    }
    
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = [self.guideImageNames count];

}

#pragma mark - Layout
- (void)viewWillLayoutSubviews {
    [self subViewsLayout];
}

- (void)subViewsLayout {
    self.pageScrollView.frame = self.view.bounds;
    self.pageScrollView.contentSize = CGSizeMake(self.view.frame.size.width*[self.guideImageNames count], self.view.frame.size.height);
    self.pageControl.frame = CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 20);
    for (NSInteger i = 0; i < [self.imageViews count]; i++) {
        UIImageView *imageView = [self.imageViews objectAtIndex:i];
        imageView.frame = CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        if (i == [self.imageViews count] - 1) {
            self.closeButton.frame = imageView.bounds;
        }
    }
}

#pragma mark - Actions
- (void)closeAction {
    if ([self.delegate respondsToSelector:@selector(appGuideViewControllerWillDismiss)]) {
        [self.delegate appGuideViewControllerWillDismiss];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    if(offset.x <= 0){
        offset.x = 0;
        scrollView.contentOffset = offset;
    }
    NSInteger index = round(offset.x / scrollView.frame.size.width);
    self.pageControl.currentPage = index;
}

#pragma mark - Getter
- (UIScrollView *)pageScrollView {
    if (!_pageScrollView) {
        _pageScrollView = [[UIScrollView alloc] init];
        _pageScrollView.bounces = NO;
        _pageScrollView.pagingEnabled = YES;
        _pageScrollView.showsHorizontalScrollIndicator = NO;
        _pageScrollView.delegate = self;
    }
    return _pageScrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.backgroundColor = [UIColor clearColor];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (NSMutableArray<UIImageView *> *)imageViews {
    if (!_imageViews) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

@end
