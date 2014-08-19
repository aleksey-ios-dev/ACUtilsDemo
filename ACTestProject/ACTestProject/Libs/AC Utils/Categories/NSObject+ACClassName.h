//
// Created by Aleksey on 20.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.

@interface NSObject (ACClassName)

- (NSString *)ac_className;
+ (NSString *)ac_name;
+ (NSString *)ac_reuseIdentifier;

@end