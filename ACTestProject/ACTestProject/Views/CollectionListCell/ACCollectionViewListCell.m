//
// Created by Aleksey on 13.05.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACCollectionViewListCell.h"
#import "ACSamplePlayer.h"
@interface ACCollectionViewListCell ()

@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;

@end

@implementation ACCollectionViewListCell


- (void)setObject:(ACSamplePlayer *)object {
    [_lastNameLabel setText:[NSString stringWithFormat:@"%@ %@", object.firstName, object.lastName]];
}
@end