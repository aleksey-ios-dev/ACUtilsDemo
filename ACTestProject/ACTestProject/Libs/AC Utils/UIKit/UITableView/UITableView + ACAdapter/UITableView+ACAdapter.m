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

- (void)ac_setDataSource:(id<ACDataSource>)dataSource {
    [self.ac_adapter setDataSource:dataSource];

    [self reloadData];
}

- (void)ac_setDidSelectCell:(ACTableViewCellAction)didSelectCell {
    [self.ac_adapter setDidSelectCell:didSelectCell];
}

- (void)ac_setDidDeselectCell:(ACTableViewCellAction)didDeselectCell {
    [self.ac_adapter setDidDeselectCell:didDeselectCell];
}

- (void)ac_setDidScroll:(ACScrollViewAction)didScroll {
    [self.ac_adapter setDidScroll:didScroll];
}

- (void)ac_setWillDrag:(ACScrollViewAction)willDrag {
    [self.ac_adapter setWillDrag:willDrag];
}

- (void)ac_setDidDrag:(ACScrollViewAction)didDrag {
    [self.ac_adapter setDidDrag:didDrag];
}

- (void)ac_setDidEndDragging:(ACScrollViewAction)didEndDragging {
    [self.ac_adapter setDidEndDragging:didEndDragging];
}

- (void)ac_setWillBeginDecelerating:(ACScrollViewAction)willBeginDecelerating {
    [self.ac_adapter setWillBeginDecelerating:willBeginDecelerating];
}

- (void)ac_setDraggingOn:(BOOL)draggingOn {
    [self.ac_adapter setDraggingOn:draggingOn];
}

- (void)ac_setMoveRow:(ACMoveRowBlock)moveRow {
    [self.ac_adapter setMoveRow:moveRow];
}

- (void)ac_setWillDisplay:(ACCellAppearanceBlock)willDisplay {
    [self.ac_adapter setWillDisplayCell:willDisplay];
}

- (void)ac_setDidEndDisplay:(ACCellAppearanceBlock)didEndDisplay {
    [self.ac_adapter setDidEndDisplayCell:didEndDisplay];
}

- (void)ac_setHeaderDecorator:(ACHeaderViewDecorationBlock)headerDecorator {
    [self.ac_adapter setHeaderDecorator:headerDecorator];
}

- (void)ac_setCellDecorator:(ACCellDecorationBlock)cellDecorator {
    [self.ac_adapter setCellDecorator:cellDecorator];
}

- (void)ac_removeObject:(id)object {
    [self.ac_adapter removeObject:object];
}

- (void)ac_removeObjectAtIndexPath:(NSIndexPath *)indexPath {
    [self.ac_adapter removeObjectAtIndexPath:indexPath];
}

@end