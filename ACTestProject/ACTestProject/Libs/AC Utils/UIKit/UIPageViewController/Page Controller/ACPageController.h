//
// Created by Aleksey on 23.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

typedef void (^ACPageControllerTransitionHook)(UIPageViewController *pageViewController, NSUInteger pageIndex);

@interface ACPageController : NSObject <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, weak) UIPageViewController *pageViewController;
@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, copy) ACPageControllerTransitionHook didFinishTransition;

- (void)showPage:(NSUInteger)index animated:(BOOL)animated;
- (void)showViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end