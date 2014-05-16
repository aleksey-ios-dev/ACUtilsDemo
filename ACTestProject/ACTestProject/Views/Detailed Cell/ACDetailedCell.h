//
// Created by Aleksey on 23.04.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACTableViewCell.h"
#import "ACObjectConsuming.h"

@class ACSamplePlayer;

@interface ACDetailedCell : UITableViewCell <ACTableViewCell, ACObjectConsuming>

@property (nonatomic, strong) ACSamplePlayer *object;

@end