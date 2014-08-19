//
// Created by Aleksey on 14.04.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACDataSource.h"
#import "ACDataSourceDefinitions.h"

@interface ACFetchedResultsDataSource : NSObject <ACDataSource>

@property (nonatomic, copy) ACRowTitleBlock rowTitleBlock;

@property (nonatomic, strong) Class<ACTableViewHeaderFooter> headerClass;

@property (nonatomic, copy) void (^willChangeContent)(void);
@property (nonatomic, copy) void (^didChangeContent)(void(^updates)(void));

@property (nonatomic, copy) void (^insertRows)(NSArray *indexPaths);
@property (nonatomic, copy) void (^deleteRows)(NSArray *indexPaths);
@property (nonatomic, copy) void (^updateRows)(NSArray *indexPaths);

@property (nonatomic, copy) void (^insertSections)(NSIndexSet *sectionIndexes);
@property (nonatomic, copy) void (^deleteSections)(NSIndexSet *sectionIndexes);

- (instancetype)initWith:(NSFetchedResultsController *)fetchedResultsController cellClass:(Class)cellClass;
- (instancetype)initWith:(NSFetchedResultsController *)fetchedResultsController cellClassBlock:(ACCellClassBlock)cellClassBlock;

+ (instancetype)sourceWith:(NSFetchedResultsController *)fetchedResultsController cellClass:(Class)cellClass;
+ (instancetype)sourceWith:(NSFetchedResultsController *)fetchedResultsController cellClassBlock:(ACCellClassBlock)cellClassBlock;

@end