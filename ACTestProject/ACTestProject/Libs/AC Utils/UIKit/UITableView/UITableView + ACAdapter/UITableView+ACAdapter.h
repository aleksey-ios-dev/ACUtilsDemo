//
// Created by Aleksey on 22.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACDataSource.h"
#import "ACTableViewAdapter.h"

@interface UITableView (ACAdapter)

- (void)ac_setDataSource:(id<ACDataSource>)dataSource;
- (void)ac_setDidSelectCell:(ACTableViewCellAction)didSelectCell;
- (void)ac_setDidDeselectCell:(ACTableViewCellAction)didDeselectCell;
- (void)ac_setDidScroll:(ACScrollViewAction)didScroll;
- (void)ac_setWillDrag:(ACScrollViewAction)willDrag;
- (void)ac_setDidDrag:(ACScrollViewAction)didDrag;
- (void)ac_setDidEndDragging:(ACScrollViewAction)didEndDragging;
- (void)ac_setWillBeginDecelerating:(ACScrollViewAction)willBeginDecelerating;

- (void)ac_setDraggingOn:(BOOL)draggingOn;
- (void)ac_setMoveRow:(ACMoveRowBlock)moveRow;
- (void)ac_setWillDisplay:(ACCellAppearanceBlock)willDisplay;
- (void)ac_setDidEndDisplay:(ACCellAppearanceBlock)didEndDisplay;
- (void)ac_setHeaderDecorator:(ACHeaderViewDecorationBlock)headerDecorator;
- (void)ac_setCellDecorator:(ACCellDecorationBlock)cellDecorator;

- (void)ac_removeObject:(id)object;
- (void)ac_removeObjectAtIndexPath:(NSIndexPath *)indexPath;

@end