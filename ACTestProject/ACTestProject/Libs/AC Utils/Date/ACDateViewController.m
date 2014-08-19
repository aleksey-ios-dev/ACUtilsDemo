//
// Created by Aleksey on 17.08.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACDateViewController.h"

@interface ACDateViewController ()

@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation ACDateViewController

#pragma mark - ACObjectConsuming

- (id)init {
    if (self = [super init]) {
        _formatter = [NSDateFormatter new];
        [_formatter setDateStyle:NSDateFormatterMediumStyle];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setObject:_object];
}

- (void)setObject:(NSDate *)object {
    _object = object;

    [_dateLabel setText:[_formatter stringFromDate:object]];
}
@end