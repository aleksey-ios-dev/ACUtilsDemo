//
// Created by Aleksey on 26.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACComponent.h"

@implementation ACComponent

- (instancetype)initWithObject:(id)object cellClass:(Class)cellClass {
    return [self initWithObject:object cellClass:cellClass delegate:nil];
}

- (instancetype)initWithObject:(id)object cellClass:(Class)cellClass delegate:(id)delegate {
    if (self = [super init]) {
        _object = object;
        _cellClass = cellClass;
        _delegate = delegate;
    }

    return self;
}

+ (instancetype)componentWithObject:(id)object cellClass:(Class)cellClass {
    return [[self alloc] initWithObject:object cellClass:cellClass];
}

+ (instancetype)componentWithObject:(id)object cellClass:(Class)cellClass delegate:(id)delegate {
    return [[self alloc] initWithObject:object cellClass:cellClass delegate:delegate];
}

@end