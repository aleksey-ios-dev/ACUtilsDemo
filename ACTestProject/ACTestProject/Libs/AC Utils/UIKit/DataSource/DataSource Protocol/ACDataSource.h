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
@property (nonatomic, copy) void (^willChangeContent)(void);
@property (nonatomic, copy) void (^didChangeContent)(void(^updates)(void));

@property (nonatomic, copy) void (^insertRows)(NSArray *indexPaths);
@property (nonatomic, copy) void (^deleteRows)(NSArray *indexPaths);
@property (nonatomic, copy) void (^updateRows)(NSArray *indexPaths);

@property (nonatomic, copy) void (^insertSections)(NSIndexSet *sectionIndexes);
@property (nonatomic, copy) void (^deleteSections)(NSIndexSet *sectionIndexes);

- (Class<ACTableViewHeaderFooter>)classForHeaderInSection:(NSInteger)section;

- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)removeObject:(id)object;
- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

@end