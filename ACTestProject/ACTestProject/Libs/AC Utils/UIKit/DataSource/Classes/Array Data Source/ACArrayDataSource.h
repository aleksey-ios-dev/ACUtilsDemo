//
// Created by Aleksey on 22.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACDataSource.h"
#import "ACDataSourceDefinitions.h"

@interface ACArrayDataSource : NSObject <ACDataSource>

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy) ACRowTitleBlock rowTitleBlock;
@property (nonatomic, copy) ACSectionTitleBlock sectionTitleBlock;
@property (nonatomic, copy) ACComparisonBlock inSectionSortingComparator;

@property (nonatomic, strong) Class<ACTableViewHeaderFooter> headerClass;

//PRIVATE

- (instancetype)initWith:(NSArray *)array cellClass:(Class)cellClass;
- (instancetype)initWith:(NSArray *)array cellClassBlock:(ACCellClassBlock)cellClassBlock;
- (instancetype)initWith:(NSArray *)array groupedBy:(NSString *)group cellClass:(Class)cellClass;
- (instancetype)initWith:(NSArray *)array groupedBy:(NSString *)group cellClassBlock:(ACCellClassBlock)cellClassBlock;

+ (instancetype)sourceWith:(NSArray *)array cellClass:(Class)class;
+ (instancetype)sourceWith:(NSArray *)array cellClassBlock:(ACCellClassBlock)cellClassBlock;
+ (instancetype)sourceWith:(NSArray *)array groupedBy:(NSString *)group cellClass:(Class)class;
+ (instancetype)sourceWith:(NSArray *)array groupedBy:(NSString *)group cellClassBlock:(ACCellClassBlock)cellClassBlock;

- (NSIndexPath *)indexPathForObject:(id)object;

//PRIVATE
- (void)removeObject:(id)object;
- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

@end