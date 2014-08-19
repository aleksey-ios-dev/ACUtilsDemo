//
// Created by Aleksey on 22.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACTableViewHeaderFooter.h"
@protocol ACDataSource <NSObject>

@required
- (Class)cellClassForObjectAt:(NSIndexPath *)indexPath;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSections;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForObject:(id)object;

@optional
@property (nonatomic, strong) NSMutableArray *array;

@optional
- (void (^)(void))willChangeContent;
- (void)setWillChangeContent:(void (^)(void))willChangeContent;

- (void (^)(void (^)(void)))didChangeContent;
- (void)setDidChangeContent:(void (^)(void (^updates)(void)))didChangeContent;

- (void (^)(NSArray *indexPaths))insertRows;
- (void)setInsertRows:(void (^)(NSArray *indexPaths))insertRows;

- (void (^)(NSArray *indexPaths))deleteRows;
- (void)setDeleteRows:(void (^)(NSArray *indexPaths))deleteRows;

- (void (^)(NSArray *indexPaths))updateRows;
- (void)setUpdateRows:(void (^)(NSArray *indexPaths))updateRows;

- (void (^)(NSIndexSet *sectionIndexes))insertSections;
- (void)setInsertSections:(void (^)(NSIndexSet *sectionIndexes))insertSections;

- (void (^)(NSIndexSet *sectionIndexes))deleteSections;
- (void)setDeleteSections:(void (^)(NSIndexSet *sectionIndexes))deleteSections;

- (Class<ACTableViewHeaderFooter>)classForHeaderInSection:(NSInteger)section;

- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)removeObject:(id)object;
- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

@end