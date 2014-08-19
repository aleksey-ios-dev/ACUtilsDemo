//
// Created by Aleksey on 23.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACPageController.h"

@interface UIPageViewController (ACPageController)

- (void)ac_setViewControllers:(UIViewController *)firstController, ... NS_REQUIRES_NIL_TERMINATION;
- (void)ac_showViewController:(UIViewController *)viewController;
- (void)ac_showViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)ac_showPage:(NSInteger)page;
- (void)ac_showPage:(NSInteger)page animated:(BOOL)animated;
- (void)ac_setDidFinishTransition:(ACPageControllerTransitionHook)didFinishTransition;

@end