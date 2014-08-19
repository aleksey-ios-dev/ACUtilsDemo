//
// Created by Aleksey on 18.04.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACDataSource.h"
#import "ACDataSourceDefinitions.h"

@interface ACSegmentedDataSource : NSObject <ACDataSource>

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy) NSArray *rowTitleBlocks;
@property (nonatomic, strong) Class cellClass;

@end