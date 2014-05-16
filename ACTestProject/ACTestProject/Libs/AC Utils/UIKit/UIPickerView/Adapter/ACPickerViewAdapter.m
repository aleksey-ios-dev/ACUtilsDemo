//
// Created by Aleksey on 17.04.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACPickerViewAdapter.h"
#import "ACDataSourceDefinitions.h"

@implementation ACPickerViewAdapter

#pragma mark - UIPickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [_dataSource numberOfSections];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_dataSource numberOfRowsInSection:component];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_dataSource titleForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:component]];
}

#pragma mark - UIPickerView Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    ac_safeBlockCall(_didSelectRow, _pickerView, row, component, [_dataSource objectAtIndexPath:[NSIndexPath indexPathForRow:row inSection:component]]);
}

- (void)setDataSource:(id<ACDataSource>)dataSource {
    _dataSource = dataSource;

    __weak typeof(self) weakSelf = self;

    if ([dataSource respondsToSelector:@selector(setDidChangeContent:)]) {
        [dataSource setDidChangeContent:^(void (^updates)()) {
            ac_safeBlockCall(updates);
            [weakSelf.pickerView reloadAllComponents];
        }];
    }
}

@end