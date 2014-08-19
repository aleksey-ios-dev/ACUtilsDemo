//
// Created by Aleksey on 14.04.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACDataSource.h"
#import "ACDataSourceDefinitions.h"

@interface ACFetchedResultsDataSource : NSObject <ACDataSource>

@property (nonatomic, copy) ACRowTitleBlock rowTitleBlock;
@property (nonatomic, strong) Class<ACTableViewHeaderFooter> headerClass;

- (instancetype)initWith:(NSFetchedResultsController *)fetchedResultsController cellClass:(Class)cellClass;
- (instancetype)initWith:(NSFetchedResultsController *)fetchedResultsController cellClassBlock:(ACCellClassBlock)cellClassBlock;

+ (instancetype)sourceWith:(NSFetchedResultsController *)fetchedResultsController cellClass:(Class)cellClass;
+ (instancetype)sourceWith:(NSFetchedResultsController *)fetchedResultsController cellClassBlock:(ACCellClassBlock)cellClassBlock;

@end