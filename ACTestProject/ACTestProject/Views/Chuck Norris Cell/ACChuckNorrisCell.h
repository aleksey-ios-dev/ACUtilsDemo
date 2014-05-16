//
// Created by Aleksey on 23.04.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACObjectConsuming.h"
#import "ACTableViewCell.h"

@interface ACChuckNorrisCell : UITableViewCell <ACObjectConsuming, ACTableViewCell>

@property (nonatomic, strong) id object;

@end