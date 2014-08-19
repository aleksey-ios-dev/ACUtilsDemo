//
// Created by Aleksey on 22.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACArrayDataSource.h"

@interface ACArrayDataSource ()

@property (nonatomic, copy) NSOrderedSet *sections;
@property (nonatomic, copy) NSString *groupKey;
@property (nonatomic, copy) ACCellClassBlock cellClassBlock;

@end

@implementation ACArrayDataSource

#pragma mark - LifeCycle

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"sectionTitleBlock"];
    [self removeObserver:self forKeyPath:@"inSectionSortingComparator"];
}

- (instancetype)initWith:(NSArray *)array cellClass:(Class)cellClass{
    return [self initWith:array groupedBy:nil cellClass:cellClass];
}

- (instancetype)initWith:(NSArray *)array cellClassBlock:(ACCellClassBlock)cellClassBlock {
    return [self initWith:array groupedBy:nil cellClassBlock:cellClassBlock];
}

- (instancetype)initWith:(NSArray *)array groupedBy:(NSString *)group cellClass:(Class)cellClass {
    ACCellClassBlock cellClassBlock = ^Class(NSIndexPath *indexPath, id object) {
        return cellClass;
    };

    return [self initWith:array groupedBy:group cellClassBlock:cellClassBlock];
}

- (instancetype)initWith:(NSArray *)array groupedBy:(NSString *)group cellClassBlock:(ACCellClassBlock)cellClassBlock {
    if (self = [super init]) {
        _cellClassBlock = cellClassBlock;
        _groupKey = group;
        _array = [array mutableCopy];

        [self addObserver:self forKeyPath:@"sectionTitleBlock" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"inSectionSortingComparator" options:NSKeyValueObservingOptionNew context:nil];

        [self recalculateContents];
    }

    return self;}

+ (instancetype)sourceWith:(NSArray *)array cellClassBlock:(ACCellClassBlock)cellClassBlock {
    return [[self alloc] initWith:array cellClassBlock:cellClassBlock];
}

+ (instancetype)sourceWith:(NSArray *)array groupedBy:(NSString *)group cellClassBlock:(ACCellClassBlock)cellClassBlock {
    return [[self alloc] initWith:array groupedBy:group cellClassBlock:cellClassBlock];
}

+ (instancetype)sourceWith:(NSArray *)array cellClass:(Class)class {
    return [[self alloc] initWith:array cellClass:class];
}

+ (instancetype)sourceWith:(NSArray *)array groupedBy:(NSString *)group cellClass:(Class)class {
    return [[self alloc] initWith:array groupedBy:group cellClass:class];
}

#pragma mark - ACTableViewDataSource

- (Class<ACTableViewHeaderFooter>)classForHeaderInSection:(NSInteger)section {
    return _headerClass;
}

- (Class)cellClassForObjectAt:(NSIndexPath *)indexPath {
    return _cellClassBlock(indexPath, [self objectAtIndexPath:indexPath]);
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [_sections[(NSUInteger)section] count];
}

- (NSInteger)numberOfSections {
    return [_sections count];
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    return [[_sections objectAtIndex:(NSUInteger)indexPath.section] objectAtIndex:(NSUInteger)indexPath.row];
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return ac_safeBlockCall(_sectionTitleBlock, [_sections[(NSUInteger)section] lastObject]);
}

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ac_safeBlockCall(_rowTitleBlock, [_array objectAtIndex:(NSUInteger)indexPath.row]);
}

#pragma mark - Setup

- (void)recalculateContents {
    if (!_groupKey)  {
        _sections = [NSOrderedSet orderedSetWithObject:_array];

        return;
    }

    NSMutableSet *keys = [NSMutableSet new];

    for (id object in _array) {
        id key = [object valueForKeyPath:_groupKey];
        if (key) {
            [keys addObject:key];
        }
    }

    NSArray *sortedKeys = [[keys allObjects] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];

    NSMutableOrderedSet *sections = [NSMutableOrderedSet new];

    for (NSString *key in sortedKeys) {
        NSIndexSet *sectionIndexes = [_array indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            return [[obj valueForKeyPath:_groupKey] isEqual:key];
        }];

        NSArray *sectionContents = [_array objectsAtIndexes:sectionIndexes];
        if (_inSectionSortingComparator) {
            sectionContents = [sectionContents sortedArrayUsingComparator:_inSectionSortingComparator];
        }

        [sections addObject:sectionContents];
    }

    _sections = [sections copy];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self recalculateContents];
}

#pragma mark - Helpers

- (NSIndexPath *)indexPathForObject:(id)searchedObject {
    __block NSInteger sectionIndex = 0;
    __block NSInteger rowIndex = 0;
    __block BOOL objectFound = NO;

    [_sections enumerateObjectsUsingBlock:^(NSArray *section, NSUInteger sectionIdx, BOOL *stop) {
        [section enumerateObjectsUsingBlock:^(id obj, NSUInteger objectIndex, BOOL *s) {
            if (obj == searchedObject) {
                sectionIndex = sectionIdx;
                rowIndex = objectIndex;
                objectFound = YES;
            }
        }];
    }];

    if (!objectFound) return nil;

    return [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
}

- (void)removeObject:(id)object {
    [self removeObjectAtIndexPath:[self indexPathForObject:object]];
}

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *section = [_sections objectAtIndex:(NSUInteger)indexPath.section];
    [section removeObjectAtIndex:(NSUInteger)indexPath.row];
}

@end