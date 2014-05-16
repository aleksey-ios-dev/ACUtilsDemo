//
// Created by Aleksey on 11.04.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACTableViewCell.h"
#import "ACObjectConsuming.h"

@interface ACSimpleCell : UITableViewCell <ACTableViewCell, ACObjectConsuming>

@property (nonatomic, strong) id object;

@end