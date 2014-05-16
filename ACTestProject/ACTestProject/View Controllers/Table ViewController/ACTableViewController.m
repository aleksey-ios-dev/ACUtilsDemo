//
// Created by Aleksey on 15.05.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACTableViewController.h"
#import "ACSimpleCell.h"
#import "ACUtils.h"
#import "ACSamplePlayer.h"
#import "NSManagedObject+MagicalFinders.h"

@interface ACTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ACTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_tableView registerNib:[ACSimpleCell ac_nib] forCellReuseIdentifier:[ACSimpleCell ac_reuseIdentifier]];

    NSFetchedResultsController *fetchedResultsController = [ACSamplePlayer MR_fetchAllGroupedBy:@"lastName"
                                                                                  withPredicate:nil
                                                                                       sortedBy:@"lastName"
                                                                                      ascending:YES];

    __weak typeof(self) weakSelf = self;

    [_tableView ac_setDidSelectCell:^(UITableView *tableView, NSIndexPath *indexPath, ACSamplePlayer *player) {
        [weakSelf treatPlayer:player];
    }];

    [_tableView ac_setDataSource:[ACFetchedResultsDataSource sourceWith:fetchedResultsController cellClass:[ACSimpleCell class]]];
}

@end