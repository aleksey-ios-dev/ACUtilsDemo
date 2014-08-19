//
// Created by Aleksey on 23.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACPageController.h"
#import "ACDataSourceDefinitions.h"

@implementation ACPageController

- (void)showPage:(NSUInteger)index animated:(BOOL)animated {
    [self showViewController:_viewControllers[index] animated:animated];
}

- (void)showViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSUInteger currentIndex = [_viewControllers indexOfObject:[_pageViewController.viewControllers lastObject]];
    NSUInteger index = [_viewControllers indexOfObject:viewController];
    if (index == currentIndex) return;

    UIPageViewControllerNavigationDirection direction = index > currentIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;

    [_pageViewController setViewControllers:@[viewController]
                                  direction:direction
                                   animated:animated
                                 completion:^(BOOL finished) {
        [self queueRefresh];
    }];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
    [_pageViewController setViewControllers:@[[_viewControllers firstObject]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
}

#pragma mark - UIPageViewController delegate and data source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    if (!viewController) return _viewControllers[0];

    NSInteger idx = [_viewControllers indexOfObject:viewController];
    NSParameterAssert(idx != NSNotFound);
    if (idx >= [_viewControllers count] - 1) {
        return nil;
    }

    return _viewControllers[(NSUInteger)(idx + 1)];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    if (!viewController) {
        return _viewControllers[0];
    }

    NSInteger idx = [_viewControllers indexOfObject:viewController];
    NSParameterAssert(idx != NSNotFound);
    if (idx <= 0) {
        return nil;
    }

    return _viewControllers[(NSUInteger)(idx - 1)];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    ac_safeBlockCall(_didFinishTransition, _pageViewController, [_viewControllers indexOfObject:[pageViewController.viewControllers lastObject]]);
}

- (void)queueRefresh {
    [self performSelector:@selector(refresh) withObject:nil afterDelay:0.05];
}

- (void)refresh {
    [_pageViewController setDataSource:nil];
    [_pageViewController setDataSource:self];
}

@end