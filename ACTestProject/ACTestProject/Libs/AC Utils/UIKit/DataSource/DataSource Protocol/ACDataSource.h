//
// Created by Aleksey on 22.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

@protocol ACDataSource <NSObject>

@required
- (Class)cellClassForObjectAt:(NSIndexPath *)indexPath;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSections;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

@optional
@property (nonatomic, copy) void (^willChangeContent)(void);
@property (nonatomic, copy) void (^didChangeContent)(void(^updates)(void));

@property (nonatomic, copy) void (^insertRows)(NSArray *indexPaths);
@property (nonatomic, copy) void (^deleteRows)(NSArray *indexPaths);
@property (nonatomic, copy) void (^updateRows)(NSArray *indexPaths);

@property (nonatomic, copy) void (^insertSections)(NSIndexSet *sectionIndexes);
@property (nonatomic, copy) void (^deleteSections)(NSIndexSet *sectionIndexes);

- (Class)classForHeaderInSection:(NSInteger)section;

- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath;

@end