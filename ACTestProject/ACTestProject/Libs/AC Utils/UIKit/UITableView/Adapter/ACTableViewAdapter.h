//
// Created by Aleksey on 22.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACDataSource.h"

typedef void (^ACTableViewCellAction)(UITableView *tableView, NSIndexPath *indexPath, id object);

@interface ACTableViewAdapter : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) id<ACDataSource> dataSource;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) ACTableViewCellAction didSelectCell;
@property (nonatomic, copy) ACTableViewCellAction didDeselectCell;

@end