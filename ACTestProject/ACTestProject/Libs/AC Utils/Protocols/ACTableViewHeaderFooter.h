//
// Created by Aleksey on 27.05.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

@protocol ACTableViewHeaderFooter <NSObject>

@required
+ (CGFloat)heightForObject:(id)object;

@end