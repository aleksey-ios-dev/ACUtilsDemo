//
// Created by Aleksey on 23.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import <objc/runtime.h>
#import "UIPageViewController+ACPageController.h"

static void *ACPageControllerKey;

@interface UIPageViewController ()

@property (nonatomic, strong) ACPageController *ac_controller;

@end

@implementation UIPageViewController (ACPageController)

- (ACPageController *)ac_controller {
    ACPageController *controller = objc_getAssociatedObject(self, &ACPageControllerKey);
    if (controller) return controller;

    controller = [ACPageController new];
    objc_setAssociatedObject(self, &ACPageControllerKey, controller, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setDelegate:controller];
    [self setDataSource:controller];
    [controller setPageViewController:self];

    return controller;
}

- (void)ac_setViewControllers:(UIViewController *)firstController, ... {
    NSMutableArray *controllers = [NSMutableArray new];

    va_list args;
    va_start(args, firstController);

    for (id controller = firstController; controller != nil; controller = va_arg(args, id)) {
        [controllers addObject:controller];
    }

    [self.ac_controller setViewControllers:[controllers copy]];

    va_end(args);
}

- (void)ac_showViewController:(UIViewController *)viewController {
    [self.ac_controller showViewController:viewController animated:YES];
}

- (void)ac_showViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.ac_controller showViewController:viewController animated:animated];
}

- (void)ac_showPage:(NSInteger)page {
    [self ac_showPage:page animated:YES];
}

- (void)ac_showPage:(NSInteger)page animated:(BOOL)animated {
    [self.ac_controller showPage:(NSUInteger)page animated:animated];
}

- (void)ac_setDidFinishTransition:(ACPageControllerTransitionHook)didFinishTransition {
    [self.ac_controller setDidFinishTransition:didFinishTransition];
}

@end