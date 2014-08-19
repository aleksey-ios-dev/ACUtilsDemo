//
// Created by Aleksey on 17.04.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACDataSource.h"

typedef void (^ACPickerViewRowAction)(UIPickerView *pickerView, NSInteger row, NSInteger segment, id object);

@interface ACPickerViewAdapter : NSObject <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) id<ACDataSource> dataSource;
@property (nonatomic, weak) UIPickerView *pickerView;

@property (nonatomic, copy) ACPickerViewRowAction didSelectRow;

@end