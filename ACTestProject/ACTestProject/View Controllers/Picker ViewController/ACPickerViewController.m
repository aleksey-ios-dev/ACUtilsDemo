//
// Created by Aleksey on 15.05.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACPickerViewController.h"
#import "ACSamplePlayer.h"
#import "NSManagedObject+MagicalFinders.h"
#import "ACUtils.h"

@interface ACPickerViewController ()

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation ACPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSFetchedResultsController *fetchedResultsController = [ACSamplePlayer MR_fetchAllGroupedBy:nil
                                                                                  withPredicate:nil
                                                                                       sortedBy:@"lastName"
                                                                                      ascending:YES];

    ACFetchedResultsDataSource *dataSource = [[ACFetchedResultsDataSource alloc] initWith:fetchedResultsController cellClass:nil];
    [dataSource setRowTitleBlock:^NSString *(ACSamplePlayer *player) {
        return [player nameDescription];
    }];

    __weak typeof(self) weakSelf = self;

    [_pickerView ac_setDidSelectRow:^(UIPickerView *pickerView, NSInteger row, NSInteger segment, ACSamplePlayer *player) {
        [weakSelf treatPlayer:player];
    }];

    [_pickerView ac_setDataSource:dataSource];
}

@end