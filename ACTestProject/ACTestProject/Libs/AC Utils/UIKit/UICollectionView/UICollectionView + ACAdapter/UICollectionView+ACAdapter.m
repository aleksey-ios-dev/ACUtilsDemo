//
// Created by Aleksey on 13.05.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import <objc/runtime.h>
#import "UICollectionView+ACAdapter.h"

static void *ACCollectionViewAdapterKey;

@interface UICollectionView ()

@property (nonatomic, readonly) ACCollectionViewAdapter *ac_adapter;

@end

@implementation UICollectionView (ACAdapter)

- (ACCollectionViewAdapter *)ac_adapter {
    ACCollectionViewAdapter *adapter = objc_getAssociatedObject(self, &ACCollectionViewAdapterKey);
    if (adapter) return adapter;

    adapter = [ACCollectionViewAdapter new];
    objc_setAssociatedObject(self, &ACCollectionViewAdapterKey, adapter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setDelegate:adapter];
    [self setDataSource:adapter];
    [adapter setCollectionView:self];

    return adapter;
}

- (void)ac_setDataSource:(id<ACDataSource>)dataSource {
    [self.ac_adapter setDataSource:dataSource];

    [self reloadData];
}

- (void)ac_setDidSelectCell:(ACCollectionViewCellAction)didSelectCell {
    [self.ac_adapter setDidSelectCell:didSelectCell];
}

- (void)ac_setDidDeselectCell:(ACCollectionViewCellAction)didDeselectCell {
    [self.ac_adapter setDidDeselectCell:didDeselectCell];
}

@end