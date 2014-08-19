//
// Created by Aleksey on 17.04.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import <objc/runtime.h>
#import "UIPickerView+ACAdapter.h"

static void *ACPikerViewAdapterKey;

@interface UIPickerView ()

@property (nonatomic, strong) ACPickerViewAdapter *ac_adapter;

@end

@implementation UIPickerView (ACAdapter)

- (ACPickerViewAdapter *)ac_adapter {
    ACPickerViewAdapter *adapter = objc_getAssociatedObject(self, &ACPikerViewAdapterKey);
    if (adapter) return adapter;

    adapter = [ACPickerViewAdapter new];
    objc_setAssociatedObject(self, &ACPikerViewAdapterKey, adapter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setDelegate:adapter];
    [self setDataSource:adapter];
    [adapter setPickerView:self];

    return adapter;
}

- (void)ac_setDataSource:(id<ACDataSource>)dataSource {
    [self.ac_adapter setDataSource:dataSource];
    [self reloadAllComponents];
}

- (void)ac_setDidSelectRow:(ACPickerViewRowAction)block {
    [self.ac_adapter setDidSelectRow:block];
}

@end