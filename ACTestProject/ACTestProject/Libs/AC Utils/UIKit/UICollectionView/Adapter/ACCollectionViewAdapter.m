//
// Created by Aleksey on 13.05.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACCollectionViewAdapter.h"
#import "ACObjectConsuming.h"
#import "NSObject+ACClassName.h"
#import "ACDataSourceDefinitions.h"

@implementation ACCollectionViewAdapter

#pragma mark - Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataSource numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [_dataSource numberOfSections];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<ACObjectConsuming> cell = [_collectionView dequeueReusableCellWithReuseIdentifier:[[_dataSource cellClassForObjectAt:indexPath] ac_reuseIdentifier]
                                                                            forIndexPath:indexPath];

    [cell setObject:[_dataSource objectAtIndexPath:indexPath]];

    return (UICollectionViewCell *)cell;
}

#pragma mark - Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ac_safeBlockCall(_didSelectCell, collectionView, indexPath, [self.dataSource objectAtIndexPath:indexPath]);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    ac_safeBlockCall(_didDeselectCell, collectionView, indexPath, [self.dataSource objectAtIndexPath:indexPath]);
}

#pragma mark - Accessors

- (void)setDataSource:(id<ACDataSource>)dataSource {
    _dataSource = dataSource;

    __weak typeof(self) weakSelf = self;

    if ([dataSource respondsToSelector:@selector(setDidChangeContent:)]) {
        [dataSource setDidChangeContent:^(void (^updates)()) {
            [weakSelf.collectionView performBatchUpdates:updates completion:nil];
        }];
    }

    if ([dataSource respondsToSelector:@selector(setInsertRows:)]) {
        [dataSource setInsertRows:^(NSArray *indexPaths) {
            [weakSelf.collectionView insertItemsAtIndexPaths:indexPaths];
        }];
    }

    if ([dataSource respondsToSelector:@selector(setDeleteRows:)]) {
        [dataSource setDeleteRows:^(NSArray *indexPaths) {
            [weakSelf.collectionView deleteItemsAtIndexPaths:indexPaths];
        }];
    }

    if ([dataSource respondsToSelector:@selector(setUpdateRows:)]) {
        [dataSource setUpdateRows:^(NSArray *indexPaths) {
            [weakSelf.collectionView reloadItemsAtIndexPaths:indexPaths];
        }];
    }

    if ([dataSource respondsToSelector:@selector(setInsertSections:)]) {
        [dataSource setInsertSections:^(NSIndexSet *sectionIndexes) {
            [weakSelf.collectionView insertSections:sectionIndexes];
        }];
    }

    if ([dataSource respondsToSelector:@selector(setDeleteSections:)]) {
        [dataSource setDeleteSections:^(NSIndexSet *sectionIndexes) {
            [weakSelf.collectionView deleteSections:sectionIndexes];
        }];
    }
}

@end