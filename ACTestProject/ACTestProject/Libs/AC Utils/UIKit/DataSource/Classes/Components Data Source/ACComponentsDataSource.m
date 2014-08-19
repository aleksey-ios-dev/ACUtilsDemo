//
// Created by Aleksey on 26.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACComponentsDataSource.h"
#import "ACComponent.h"



@implementation ACComponentsDataSource

#pragma mark - Initialization

- (instancetype)initWithModel:(id)model cellClasses:(NSArray *)cellClasses delegate:(id)delegate {
    return [self initWithModel:model cellClasses:cellClasses delegate:delegate headerClass:nil];
}

- (instancetype)initWithModel:(id)model cellClasses:(NSArray *)cellClasses delegate:(id)delegate headerClass:(Class)headerClass {
    NSMutableArray *components = [NSMutableArray new];

    for (Class class in cellClasses) {
        [components addObject:[ACComponent componentWithObject:model cellClass:class delegate:delegate]];
    }

    return [self initWithComponents:[components copy] headerClass:headerClass];
}

- (instancetype)initWithComponents:(NSArray *)components {
    return [self initWithComponents:components headerClass:nil];
}

- (instancetype)initWithComponents:(NSArray *)components headerClass:(Class)headerClass {
    if (self = [super init]) {
        _array = [components mutableCopy];
        _headerClass = headerClass;
    }

    return self;
}

+ (instancetype)sourceWithComponents:(NSArray *)components {
    return [[self alloc] initWithComponents:components];
}

+ (instancetype)sourceWithComponents:(NSArray *)components headerClass:(Class)headerClass {
    return [[self alloc] initWithComponents:components headerClass:headerClass];
}

+ (instancetype)sourceWithModel:(id)model cellClasses:(NSArray *)cellClasses delegate:(id)delegate {
    return [[self alloc] initWithModel:model cellClasses:cellClasses delegate:delegate];
}

+ (instancetype)sourceWithModel:(id)model cellClasses:(NSArray *)cellClasses delegate:(id)delegate headerClass:(Class)headerClass {
    return [[self alloc] initWithModel:model cellClasses:cellClasses delegate:delegate headerClass:headerClass];
}

#pragma mark - ACDataSource

- (Class)cellClassForObjectAt:(NSIndexPath *)indexPath {
    NSInteger index = _headerClass ? indexPath.section : indexPath.row;
    return [[_array objectAtIndex:index] cellClass];
}

- (Class)classForHeaderInSection:(NSInteger)section {
    return _headerClass;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return _headerClass ? 1 : [_array count];
}

- (NSInteger)numberOfSections {
    return _headerClass ? [_array count] : 1;
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return nil;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    return _headerClass ? [_array objectAtIndex:(NSUInteger)indexPath.section] : [[_array objectAtIndex:(NSUInteger)indexPath.row] object];
}

- (NSIndexPath *)indexPathForObject:(id)object {
    NSInteger row = [_array indexOfObject:object];
    NSInteger section = _headerClass ? row : 1;

    return [NSIndexPath indexPathForRow:row inSection:section];
}

@end