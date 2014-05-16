//
// Created by Aleksey on 11.04.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACSimpleCell.h"
#import "ACSamplePlayer.h"

@interface ACSimpleCell ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ACSimpleCell

+ (CGFloat)cellHeightForObject:(id)object {
    return 50.f;
}

- (void)setObject:(ACSamplePlayer *)object {
    _object = object;

    [_nameLabel setText:[NSString stringWithFormat:@"%@ %@, wins: %i", object.firstName, object.lastName, [object.wins integerValue]]];
}

@end