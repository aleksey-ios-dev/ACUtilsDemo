//
// Created by Aleksey on 17.04.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACDataSource.h"
#import "ACPickerViewAdapter.h"

@interface UIPickerView (ACAdapter)

- (void)ac_setDataSource:(id<ACDataSource>)dataSource;
- (void)ac_setDidSelectRow:(ACPickerViewRowAction)block;

@end