//
// Created by Aleksey on 16.05.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACPlayerTreatmentViewController.h"
#import "ACSamplePlayer.h"
#import "ACUtils.h"
#import "NSManagedObject+MagicalRecord.h"

@implementation ACPlayerTreatmentViewController

- (void)treatPlayer:(ACSamplePlayer *)player {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[player nameDescription]
                                                        message:@"What action do you want to perform?"
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Delete", @"Clone", nil];

    ACAlertViewActivityBlock deletion = ^(UIAlertView *alert, NSInteger buttonIndex) {
        [player MR_deleteEntity];
    };

    ACAlertViewActivityBlock cloning = ^(UIAlertView *alert, NSInteger buttonIndex) {
        [player clone];
    };

    [alertView ac_setOtherBlocks:deletion, cloning, nil];

    [alertView show];
}

@end