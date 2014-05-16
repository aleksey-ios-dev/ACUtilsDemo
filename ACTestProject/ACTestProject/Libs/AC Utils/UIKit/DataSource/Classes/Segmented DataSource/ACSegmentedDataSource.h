//
// Created by Aleksey on 18.04.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACDataSource.h"
#import "ACDataSourceDefinitions.h"

@interface ACSegmentedDataSource : NSObject <ACDataSource>

@property (nonatomic, copy) NSArray *segments;
@property (nonatomic, copy) NSArray *rowTitleBlocks;
@property (nonatomic, strong) Class cellClass;

@end