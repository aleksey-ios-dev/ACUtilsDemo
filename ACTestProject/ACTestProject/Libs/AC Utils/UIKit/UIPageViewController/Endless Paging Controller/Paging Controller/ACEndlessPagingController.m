//
// Created by Aleksey on 03.06.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACEndlessPagingController.h"
#import "ACObjectConsuming.h"
#import "UIViewController+ACPageNumber.h"

@interface ACEndlessPagingController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) Class pageClass;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *reusePool;

@end

@implementation ACEndlessPagingController

#pragma mark - LifeCycle;

- (instancetype)initWithPageViewController:(UIPageViewController *)pageViewController
                                 pageClass:(Class)class {
    if (self = [super init]) {
        _reusePool = [NSMutableArray new];
        _pageClass = class;
        _pageViewController = pageViewController;
        [_pageViewController setDelegate:self];
        [_pageViewController setDataSource:self];
    }

    return self;
}

- (void)reloadData {
    UIViewController *initialController = [self dequeueReusableViewController];
    [(id<ACObjectConsuming>)initialController setObject:[_dataSource initialObjectForPageController:self]];
    [initialController ac_setPageNumber:@(0)];

    [_pageViewController setViewControllers:@[initialController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
}


- (UIViewController *)dequeueReusableViewController {
    UIViewController *dequeuedViewController = nil;
    NSInteger currentPageNumber = [[[[self.pageViewController viewControllers] firstObject] ac_pageNumber] integerValue];

    for (UIViewController *viewController in _reusePool) {
        NSInteger pageNumber = [[viewController ac_pageNumber] integerValue];
        if (pageNumber != currentPageNumber - 1 && pageNumber != currentPageNumber + 1 && pageNumber != currentPageNumber) {
            dequeuedViewController = viewController;
        }
    }

    if (!dequeuedViewController) {
        dequeuedViewController = [_pageClass new];

        if ([_delegate respondsToSelector:@selector(pageController:didInstantiateViewController:)]) {
            [_delegate pageController:self didInstantiateViewController:dequeuedViewController];
        }
        [_reusePool addObject:dequeuedViewController];
    }

    return dequeuedViewController;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)currentController {
    UIViewController *controller = [self dequeueReusableViewController];

    id currentObject = [(id<ACObjectConsuming>)currentController object];
    [(id<ACObjectConsuming>) controller setObject:[_dataSource objectBeforeObject:currentObject forPageController:self]];

    [controller ac_setPageNumber:@([[currentController ac_pageNumber] integerValue] - 1)];

    return controller;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)currentController {

    UIViewController *controller = [self dequeueReusableViewController];

    id currentObject = [(id<ACObjectConsuming>)currentController object];
    [(id<ACObjectConsuming>)controller setObject:[_dataSource objectAfterObject:currentObject forPageController:self]];

    [controller ac_setPageNumber:@([[currentController ac_pageNumber] integerValue] + 1)];

    return controller;
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    UIViewController *controller = [pageViewController.viewControllers firstObject];
    id object = [(id <ACObjectConsuming>) controller object];
    if ([_delegate respondsToSelector:@selector(pageController:didFinishTransitionToObject:)]) {
        [_delegate pageController:self didFinishTransitionToObject:object];
    }
}

- (void)setPagingEnabled:(BOOL)pagingEnabled {
    _pagingEnabled = pagingEnabled;

    for (UIView *view in _pageViewController.view.subviews){
        if ([view isKindOfClass:[UIScrollView class]]){
            [(UIScrollView *)view setScrollEnabled:pagingEnabled];

            return;
        }
    }
}

@end