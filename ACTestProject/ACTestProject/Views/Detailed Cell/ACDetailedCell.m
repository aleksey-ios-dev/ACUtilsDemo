//
// Created by Aleksey on 23.04.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACDetailedCell.h"
#import "ACSamplePlayer.h"

@interface ACDetailedCell ()

@property (nonatomic, weak) IBOutlet UILabel *firstNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *lastNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *winsLabel;
@property (nonatomic, weak) IBOutlet UITextView *detailsTextView;

@end

@implementation ACDetailedCell

+ (CGFloat)cellHeightForObject:(ACSamplePlayer *)player {
    CGSize size = [player.details sizeWithFont:[UIFont systemFontOfSize:14.f]
                              constrainedToSize:CGSizeMake(280.f, MAXFLOAT)
                                  lineBreakMode:NSLineBreakByWordWrapping];

    return 70.f + size.height;
}

- (void)setObject:(ACSamplePlayer *)object {
    _object = object;

    [_firstNameLabel setText:object.firstName];
    [_lastNameLabel setText:object.lastName];
    [_winsLabel setText:[object.wins stringValue]];
    [_detailsTextView setText:object.details];
}

@end