//
// Created by Aleksey on 22.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import <objc/runtime.h>
#import "UITableView+ACAdapter.h"

static void *ACTableViewAdapterKey;

@interface UITableView ()

@property (nonatomic, readonly) ACTableViewAdapter *ac_adapter;

@end

@implementation UITableView (ACAdapter)

- (ACTableViewAdapter *)ac_adapter {
    ACTableViewAdapter *adapter = objc_getAssociatedObject(self, &ACTableViewAdapterKey);
    if (adapter) return adapter;

    adapter = [ACTableViewAdapter new];
    objc_setAssociatedObject(self, &ACTableViewAdapterKey, adapter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setDelegate:adapter];
    [self setDataSource:adapter];
    [adapter setTableView:self];

    return adapter;
}

- (void)ac_setDataSource:(id <ACDataSource>)dataSource {
    [self.ac_adapter setDataSource:dataSource];

    [self reloadData];
}

- (void)ac_setDidSelectCell:(ACTableViewCellAction)didSelectCell {
    [self.ac_adapter setDidSelectCell:didSelectCell];
}

- (void)ac_setDidDeselectCell:(ACTableViewCellAction)didDeselectCell {
    [self.ac_adapter setDidDeselectCell:didDeselectCell];
}

@end