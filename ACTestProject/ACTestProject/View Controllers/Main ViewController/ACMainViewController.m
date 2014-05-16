//
// Created by Aleksey on 15.05.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACMainViewController.h"
#import "ACUtils.h"
#import "ACTableViewController.h"
#import "ACCollectionViewController.h"
#import "ACPickerViewController.h"
#import "UIView+TLKAppearance.h"
#import "ACSampleNetworkManager.h"
#import "ACSamplePlayer.h"
#import "NSManagedObject+MagicalRecord.h"

@interface ACMainViewController ()

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UIView *pageViewContainer;
@property (nonatomic, strong) UIPageViewController *pageViewController;

@end
@implementation ACMainViewController

- (instancetype)init {
    if (self = [super init]) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    }

    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [ACSampleNetworkManager importPlayersCount:25];

    [_pageViewContainer tlk_addSubview:_pageViewController.view options:TLKAppearanceOptionOverlay];
    [_pageViewController ac_setViewControllers:[ACTableViewController new], [ACCollectionViewController new], [ACPickerViewController new], nil];

    __weak typeof(self) weakSelf = self;

    [_pageViewController ac_setDidFinishTransition:^(UIPageViewController *pageViewController, NSUInteger pageIndex) {
        [weakSelf.segmentedControl setSelectedSegmentIndex:pageIndex];
    }];
}

#pragma mark - Actions

- (IBAction)segmentedControlValueDidChange:(UISegmentedControl *)sender {
    [_pageViewController ac_showPage:sender.selectedSegmentIndex];
}

@end