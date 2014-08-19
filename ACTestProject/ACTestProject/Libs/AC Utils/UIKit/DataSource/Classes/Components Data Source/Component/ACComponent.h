//
// Created by Aleksey on 26.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

@interface ACComponent : NSObject

@property (nonatomic, strong) id object;
@property (nonatomic, strong) Class cellClass;
@property (nonatomic, weak) id delegate;

- (instancetype)initWithObject:(id)object cellClass:(Class)cellClass;
- (instancetype)initWithObject:(id)object cellClass:(Class)cellClass delegate:(id)delegate;

+ (instancetype)componentWithObject:(id)object cellClass:(Class)cellClass;
+ (instancetype)componentWithObject:(id)object cellClass:(Class)cellClass delegate:(id)delegate;;

@end