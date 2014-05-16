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

@end