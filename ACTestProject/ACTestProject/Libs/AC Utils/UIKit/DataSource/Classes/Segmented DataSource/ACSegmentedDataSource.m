//
// Created by Aleksey on 18.04.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACSegmentedDataSource.h"

@implementation ACSegmentedDataSource

#pragma mark - ACDataSource

- (Class)cellClassForObjectAt:(NSIndexPath *)indexPath {
    return _cellClass;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [_array[(NSUInteger)section] count];
}

- (NSInteger)numberOfSections {
    return [_array count];
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    return _array[(NSUInteger)indexPath.section][(NSUInteger)indexPath.row];
}

- (NSIndexPath *)indexPathForObject:(id)object {
    //TODO write this part
    return nil;
}


- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%i", section];
}

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath {
    ACRowTitleBlock titleBlock = _rowTitleBlocks[(NSUInteger)indexPath.section];
    id object = _array[(NSUInteger)indexPath.section][(NSUInteger)indexPath.row];

    return titleBlock(object);
}

@end