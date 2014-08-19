//
// Created by Aleksey on 22.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACDataSource.h"

typedef void (^ACTableViewCellAction)(UITableView *tableView, NSIndexPath *indexPath, id object);
typedef void (^ACMoveRowBlock)(UITableView *tableView, NSIndexPath *oldPath, NSIndexPath *newPath, id movedObject);
typedef void (^ACScrollViewAction)(UIScrollView *scrollView);
typedef void (^ACCellAppearanceBlock)(UITableView *tableView, UITableViewCell *cell);
typedef void (^ACHeaderViewDecorationBlock)(UITableViewHeaderFooterView *headerView);
typedef void (^ACCellDecorationBlock)(UITableViewCell *cell);

@interface ACTableViewAdapter : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) id<ACDataSource> dataSource;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) ACTableViewCellAction didSelectCell;
@property (nonatomic, copy) ACTableViewCellAction didDeselectCell;
@property (nonatomic, copy) ACScrollViewAction didScroll;
@property (nonatomic, copy) ACScrollViewAction willDrag;
@property (nonatomic, copy) ACScrollViewAction didDrag;
@property (nonatomic, copy) ACScrollViewAction didEndDragging;
@property (nonatomic, copy) ACScrollViewAction willBeginDecelerating;
@property (nonatomic, copy) ACMoveRowBlock moveRow;
@property (nonatomic, copy) void(^removeGestureRecognizer)(void);
@property (nonatomic, copy) void(^addGestureRecognizer)(void);
@property (nonatomic, copy) ACCellAppearanceBlock willDisplayCell;
@property (nonatomic, copy) ACCellAppearanceBlock didEndDisplayCell;

@property (nonatomic, copy) ACHeaderViewDecorationBlock headerDecorator;
@property (nonatomic, copy) ACCellDecorationBlock cellDecorator;
@property (nonatomic, getter = isDraggingOn) BOOL draggingOn;

- (void)removeObject:(id)object;
- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

@end