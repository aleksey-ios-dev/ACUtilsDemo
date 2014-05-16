//
// Created by Aleksey on 15.05.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACCollectionViewController.h"
#import "ACSamplePlayer.h"
#import "NSManagedObject+MagicalFinders.h"
#import "ACUtils.h"
#import "ACCollectionViewListCell.h"

@interface ACCollectionViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ACCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_collectionView registerNib:[ACCollectionViewListCell ac_nib] forCellWithReuseIdentifier:[ACCollectionViewListCell ac_reuseIdentifier]];

    NSFetchedResultsController *fetchedResultsController = [ACSamplePlayer MR_fetchAllGroupedBy:@"lastName"
                                                                                  withPredicate:nil
                                                                                       sortedBy:@"lastName"
                                                                                      ascending:YES];

    __weak typeof(self) weakSelf = self;

    [_collectionView ac_setDidSelectCell:^(UICollectionView *collectionView, NSIndexPath *indexPath, ACSamplePlayer *player) {
        [weakSelf treatPlayer:player];
    }];

    [_collectionView ac_setDataSource:[ACFetchedResultsDataSource sourceWith:fetchedResultsController cellClass:[ACCollectionViewListCell class]]];
}

@end