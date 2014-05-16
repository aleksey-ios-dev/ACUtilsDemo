//
// Created by Aleksey on 26.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACComponentsDataSource.h"
#import "ACComponent.h"

@implementation ACComponentsDataSource

#pragma mark - Initialization

- (instancetype)initWithComponents:(NSArray *)components {
    if (self = [super init]) {
        _components = components;
    }

    return self;
}

+ (instancetype)sourceWithComponents:(NSArray *)components {
    return [[self alloc] initWithComponents:components];
}

#pragma mark - ACDataSource

- (Class)cellClassForObjectAt:(NSIndexPath *)indexPath {
    return [[_components objectAtIndex:(NSUInteger)indexPath.row] cellClass];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [_components count];
}

- (NSInteger)numberOfSections {
    return 1;
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return nil;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    return [[_components objectAtIndex:(NSUInteger)indexPath.row] object];
}

@end