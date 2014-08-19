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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    Class<ACTableViewHeaderFooter> class = [_dataSource classForHeaderInSection:section];

    if (!class) return 0.f;

    NSAssert([(id)class conformsToProtocol:@protocol(ACTableViewHeaderFooter)], @"Header must conform ACTableViewHeaderFooter protocol");

    return [class heightForObject:[_dataSource objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<ACObjectConsuming> cell = [_tableView dequeueReusableCellWithIdentifier:[[_dataSource cellClassForObjectAt:indexPath] ac_reuseIdentifier]];

    if (!cell) {
        cell = [[_dataSource cellClassForObjectAt:indexPath] new];
    }

    [cell setObject:[_dataSource objectAtIndexPath:indexPath]];
    ac_safeBlockCall(_cellDecorator, (UITableViewCell *)cell);

    return (UITableViewCell *)cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_dataSource titleForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Class headerClass = [_dataSource classForHeaderInSection:section];
    
    if (!headerClass) {
        return nil;
    }
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[headerClass ac_reuseIdentifier]];
    
    if (!header) {
        header = [headerClass new];
    }

   [(id<ACObjectConsuming>)header setObject:[_dataSource objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]]];

    ac_safeBlockCall(_headerDecorator, header);
    return header;
}


#pragma mark - Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ac_safeBlockCall(_didSelectCell, tableView, indexPath, [self.dataSource objectAtIndexPath:indexPath]);
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    ac_safeBlockCall(_didDeselectCell, tableView, indexPath, [self.dataSource objectAtIndexPath:indexPath]);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    ac_safeBlockCall(_didScroll, scrollView);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    ac_safeBlockCall(_willDrag, scrollView);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    ac_safeBlockCall(_didDrag, scrollView);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    ac_safeBlockCall(_didEndDragging, scrollView);
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    ac_safeBlockCall(_willBeginDecelerating, scrollView);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ac_safeBlockCall(_willDisplayCell, tableView, cell);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ac_safeBlockCall(_didEndDisplayCell, tableView, cell);
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

#pragma mark - Dragging

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
    ac_safeBlockCall(_removeGestureRecognizer);
    id objectToMove = [[_dataSource array] objectAtIndex:(NSUInteger)sourceIndexPath.row];
    [[_dataSource array] removeObjectAtIndex:(NSUInteger) sourceIndexPath.row];
    [[_dataSource array] insertObject:objectToMove atIndex:(NSUInteger) destinationIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if ([proposedDestinationIndexPath row] < [[_dataSource array] count]) {
        return proposedDestinationIndexPath;
    }
    NSIndexPath *betterIndexPath = [NSIndexPath indexPathForRow:[[_dataSource array] count]-1 inSection:0];
    return betterIndexPath;
}

#pragma mark - Manipulations on objects

- (void)removeObject:(id)object {
    if (![_dataSource respondsToSelector:@selector(removeObject:)]) return;
    [self removeObjectAtIndexPath:[_dataSource indexPathForObject:object]];
}

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath {
    if(![_dataSource respondsToSelector:@selector(removeObjectAtIndexPath:)]) return;

    [_tableView beginUpdates];
    [_dataSource removeObjectAtIndexPath:indexPath];
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [_tableView endUpdates];
}

@end