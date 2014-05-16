//
// Created by Aleksey on 18.04.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACSegmentedDataSource.h"

@implementation ACSegmentedDataSource

#pragma mark - ACDataSource

- (Class)cellClassForObjectAt:(NSIndexPath *)indexPath {
    return _cellClass;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [_segments[(NSUInteger)section] count];
}

- (NSInteger)numberOfSections {
    return [_segments count];
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    return _segments[(NSUInteger)indexPath.section][(NSUInteger)indexPath.row];
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%i", section];
}

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath {
    ACRowTitleBlock titleBlock = _rowTitleBlocks[(NSUInteger)indexPath.section];
    id object = _segments[(NSUInteger)indexPath.section][(NSUInteger)indexPath.row];

    return titleBlock(object);
}

@end