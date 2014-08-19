//
// Created by Aleksey on 07.02.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

@interface UIView (ACNib)

+ (id)ac_viewFromNibNamed:(NSString *)name;
+ (id)ac_viewFromNibNamed:(NSString *)name owner:(id)owner;
+ (id)ac_viewFromNib;

+ (UINib *)ac_nib;

@end