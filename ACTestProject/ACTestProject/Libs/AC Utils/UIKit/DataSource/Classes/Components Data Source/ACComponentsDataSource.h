//
// Created by Aleksey on 26.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACDataSource.h"

@class ACComponent;

@interface ACComponentsDataSource : NSObject <ACDataSource>

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong, readonly) Class headerClass;

- (instancetype)initWithModel:(id)model cellClasses:(NSArray *)cellClasses delegate:(id)delegate;
- (instancetype)initWithModel:(id)model cellClasses:(NSArray *)cellClasses delegate:(id)delegate headerClass:(Class)headerClass;;
- (instancetype)initWithComponents:(NSArray *)components;
- (instancetype)initWithComponents:(NSArray *)components headerClass:(Class)headerClass;

+ (instancetype)sourceWithComponents:(NSArray *)components;
+ (instancetype)sourceWithComponents:(NSArray *)components headerClass:(Class)headerClass;
+ (instancetype)sourceWithModel:(id)model cellClasses:(NSArray *)cellClasses delegate:(id)delegate;
+ (instancetype)sourceWithModel:(id)model cellClasses:(NSArray *)cellClasses delegate:(id)delegate headerClass:(Class)headerClass;;

@end
