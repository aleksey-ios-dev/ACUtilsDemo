//
// Created by Aleksey on 22.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACTableViewAdapter.h"
#import "ACObjectConsuming.h"
#import "NSObject+ACClassName.h"
#import "ACTableViewCell.h"
#import "ACDataSourceDefinitions.h"

@implementation ACTableViewAdapter

#pragma mark - Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_dataSource numberOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id class = [_dataSource cellClassForObjectAt:indexPath];
    NSAssert([class conformsToProtocol:@protocol(ACTableViewCell)], @"Cell must conform ACTableViewCell protocol");

    return [(id<ACTableViewCell>)class cellHeightForObject:[_dataSource objectAtIndexPath:indexPath]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<ACObjectConsuming> cell = [_tableView dequeueReusableCellWithIdentifier:[[_dataSource cellClassForObjectAt:indexPath] ac_reuseIdentifier]];

    if (!cell) {
        cell = [[_dataSource cellClassForObjectAt:indexPath] new];
    }

    [cell setObject:[_dataSource objectAtIndexPath:indexPath]];

    return (UITableViewCell *)cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_dataSource titleForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

#pragma mark - Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ac_safeBlockCall(_didSelectCell, tableView, indexPath, [self.dataSource objectAtIndexPath:indexPath]);
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    ac_safeBlockCall(_didDeselectCell, tableView, indexPath, [self.dataSource objectAtIndexPath:indexPath]);
}

#pragma mark - Accessors

- (void)setDataSource:(id<ACDataSource>)dataSource {
    _dataSource = dataSource;

    __weak typeof(self) weakSelf = self;

    if ([dataSource respondsToSelector:@selector(setWillChangeContent:)]) {
        [dataSource setWillChangeContent:^{
            [weakSelf.tableView beginUpdates];
        }];
    }

    if ([dataSource respondsToSelector:@selector(setDidChangeContent:)]) {
        [dataSource setDidChangeContent:^(void (^updates)()) {
            ac_safeBlockCall(updates);
            [weakSelf.tableView endUpdates];
        }];
    }

    if ([dataSource respondsToSelector:@selector(setInsertRows:)]) {
        [dataSource setInsertRows:^(NSArray *indexPaths) {
            [weakSelf.tableView insertRowsAtIndexPaths:indexPaths
                            withRowAnimation:UITableViewRowAnimationFade];
        }];
    }

    if ([dataSource respondsToSelector:@selector(setDeleteRows:)]) {
        [dataSource setDeleteRows:^(NSArray *indexPaths) {
            [weakSelf.tableView deleteRowsAtIndexPaths:indexPaths
                            withRowAnimation:UITableViewRowAnimationFade];
        }];
    }

    if ([dataSource respondsToSelector:@selector(setUpdateRows:)]) {
        [dataSource setUpdateRows:^(NSArray *indexPaths) {
            [weakSelf.tableView reloadRowsAtIndexPaths:indexPaths
                                      withRowAnimation:UITableViewRowAnimationFade];
        }];
    }

    if ([dataSource respondsToSelector:@selector(setInsertSections:)]) {
        [dataSource setInsertSections:^(NSIndexSet *sectionIndexes) {
            [weakSelf.tableView insertSections:sectionIndexes withRowAnimation:UITableViewRowAnimationFade];
        }];
    }

    if ([dataSource respondsToSelector:@selector(setDeleteSections:)]) {
        [dataSource setDeleteSections:^(NSIndexSet *sectionIndexes) {
            [weakSelf.tableView deleteSections:sectionIndexes withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
}

@end