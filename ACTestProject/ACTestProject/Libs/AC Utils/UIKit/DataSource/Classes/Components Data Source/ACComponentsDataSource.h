//
// Created by Aleksey on 26.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACDataSource.h"

@class ACComponent;

@interface ACComponentsDataSource : NSObject <ACDataSource>

@property (nonatomic, strong) NSArray *components;

- (instancetype)initWithComponents:(NSArray *)components;
+ (instancetype)sourceWithComponents:(NSArray *)components;

@end
