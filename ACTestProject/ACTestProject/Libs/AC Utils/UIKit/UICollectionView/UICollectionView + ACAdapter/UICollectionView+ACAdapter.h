//
// Created by Aleksey on 13.05.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACDataSource.h"
#import "ACCollectionViewAdapter.h"

@interface UICollectionView (ACAdapter)

- (void)ac_setDataSource:(id<ACDataSource>)dataSource;
- (void)ac_setDidSelectCell:(ACCollectionViewCellAction)didSelectCell;
- (void)ac_setDidDeselectCell:(ACCollectionViewCellAction)didDeselectCell;

@end