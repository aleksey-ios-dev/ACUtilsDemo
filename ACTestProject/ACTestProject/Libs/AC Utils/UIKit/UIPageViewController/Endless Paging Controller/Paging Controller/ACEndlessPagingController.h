//
// Created by Aleksey on 03.06.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

@class ACEndlessPagingController;

@protocol ACEndlessPagingControllerDelegate <NSObject>

@optional
- (void)pageController:(ACEndlessPagingController *)pageController didFinishTransitionToObject:(id)object;
- (void)pageController:(ACEndlessPagingController *)pageController didInstantiateViewController:(UIViewController *)viewController;

@end

@protocol ACEndlessPagingControllerDataSource <NSObject>

@required
- (id)objectBeforeObject:(id)object forPageController:(ACEndlessPagingController *)pageController;
- (id)objectAfterObject:(id)object forPageController:(ACEndlessPagingController *)pageController;
- (id)initialObjectForPageController:(ACEndlessPagingController *)pageController;

@end

@interface ACEndlessPagingController : NSObject

@property (nonatomic, weak) id<ACEndlessPagingControllerDelegate> delegate;
@property (nonatomic, weak) id<ACEndlessPagingControllerDataSource> dataSource;

@property (nonatomic, getter = isPagingEnabled) BOOL pagingEnabled;


- (instancetype)initWithPageViewController:(UIPageViewController *)pageViewController
                                 pageClass:(Class)class;

- (void)reloadData;

@end