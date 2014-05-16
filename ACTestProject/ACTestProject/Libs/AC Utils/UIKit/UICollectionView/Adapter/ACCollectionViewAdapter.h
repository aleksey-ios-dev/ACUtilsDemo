//
// Created by Aleksey on 13.05.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACDataSource.h"

typedef void (^ACCollectionViewCellAction)(UICollectionView *collectionView, NSIndexPath *indexPath, id object);

@interface ACCollectionViewAdapter : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) id<ACDataSource> dataSource;
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, copy) ACCollectionViewCellAction didSelectCell;
@property (nonatomic, copy) ACCollectionViewCellAction didDeselectCell;

@end