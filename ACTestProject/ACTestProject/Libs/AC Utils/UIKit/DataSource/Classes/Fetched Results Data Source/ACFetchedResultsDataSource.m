//
// Created by Aleksey on 14.04.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACFetchedResultsDataSource.h"

@interface ACFetchedResultsDataSource () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSBlockOperation *operation;
@property (nonatomic, copy) ACCellClassBlock cellClassBlock;

@end

@implementation ACFetchedResultsDataSource

#pragma mark - Initialization

- (instancetype)initWith:(NSFetchedResultsController *)fetchedResultsController cellClass:(Class)cellClass {
    ACCellClassBlock cellClassBlock = ^Class(NSIndexPath *indexPath, id object) {
        return cellClass;
    };

    return [self initWith:fetchedResultsController cellClassBlock:cellClassBlock];
}

- (instancetype)initWith:(NSFetchedResultsController *)fetchedResultsController cellClassBlock:(ACCellClassBlock)cellClassBlock {
    if (self = [super init]) {
        _fetchedResultsController = fetchedResultsController;
        [_fetchedResultsController setDelegate:self];
        [_fetchedResultsController performFetch:nil];

        _cellClassBlock = cellClassBlock;
    }

    return self;
}

+ (instancetype)sourceWith:(NSFetchedResultsController *)fetchedResultsController cellClass:(Class)cellClass {
    return [[self alloc] initWith:fetchedResultsController cellClass:cellClass];
}

+ (instancetype)sourceWith:(NSFetchedResultsController *)fetchedResultsController cellClassBlock:(ACCellClassBlock)cellClassBlock {
    return [[self alloc] initWith:fetchedResultsController cellClassBlock:cellClassBlock];
}

#pragma mark - ACDataSource

- (Class)cellClassForObjectAt:(NSIndexPath *)indexPath {
    return ac_safeBlockCall(_cellClassBlock, indexPath, [self objectAtIndexPath:indexPath]);
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [[[_fetchedResultsController sections] objectAtIndex:(NSUInteger)section] numberOfObjects];
}

- (NSInteger)numberOfSections {
    return [[_fetchedResultsController sections] count];
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    return [_fetchedResultsController objectAtIndexPath:indexPath];
}

- (NSIndexPath *)indexPathForObject:(id)object {
    return [_fetchedResultsController indexPathForObject:object];
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return [[[_fetchedResultsController sections] objectAtIndex:(NSUInteger)section] name];
}

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ac_safeBlockCall(_rowTitleBlock, [self objectAtIndexPath:indexPath]);
}

#pragma mark - NSFetchedResultsController Delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    _operation = [NSBlockOperation new];
    ac_safeBlockCall(_willChangeContent);
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    __weak typeof(self) weakSelf = self;
    ac_safeBlockCall(_didChangeContent, ^{
        [weakSelf.operation start];
    });
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    __weak typeof(self) weakSelf = self;

    switch(type) {

        case NSFetchedResultsChangeInsert: {
            [_operation addExecutionBlock:^{
                ac_safeBlockCall(weakSelf.insertRows, @[newIndexPath]);
            }];
        }
            break;

        case NSFetchedResultsChangeDelete: {
            [_operation addExecutionBlock:^{
                ac_safeBlockCall(weakSelf.deleteRows, @[indexPath]);
            }];
        }
            break;

        case NSFetchedResultsChangeUpdate: {
            [_operation addExecutionBlock:^{
                ac_safeBlockCall(weakSelf.updateRows, @[indexPath]);
            }];
        }
            break;

        case NSFetchedResultsChangeMove: {
            [_operation addExecutionBlock:^{
                ac_safeBlockCall(weakSelf.deleteRows, @[indexPath]);
                ac_safeBlockCall(weakSelf.insertRows, @[newIndexPath]);
            }];
        }
            break;

        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    __weak typeof(self) weakSelf = self;

    switch(type) {
        case NSFetchedResultsChangeInsert: {
            [_operation addExecutionBlock:^{
                ac_safeBlockCall(weakSelf.insertSections, [NSIndexSet indexSetWithIndex:sectionIndex]);
            }];
        }
            break;

        case NSFetchedResultsChangeDelete: {
            [_operation addExecutionBlock:^{
                ac_safeBlockCall(weakSelf.deleteSections, [NSIndexSet indexSetWithIndex:sectionIndex]);
            }];
        }
            break;

        default:
            break;
    }
}

- (Class)classForHeaderInSection:(NSInteger)section {
    return _headerClass;
}

@end