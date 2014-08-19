//
// Created by Aleksey on 08.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACAlertViewDelegate.h"
#import "ACDataSourceDefinitions.h"

@implementation ACAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex && self.cancelBlock) {
        ac_safeBlockCall(_cancelBlock, alertView, buttonIndex);
        return;
    }

    NSInteger indexShift = alertView.cancelButtonIndex != -1 ? 1 : 0;
    NSUInteger indexInArray = (NSUInteger)(buttonIndex - indexShift);

    if (indexInArray >= [_otherBlocks count] || [[_otherBlocks objectAtIndex:indexInArray] isEqual:[NSNull null]]) {
        return;
    }

    ACAlertViewActivityBlock block = [_otherBlocks objectAtIndex:indexInArray];
    block(alertView, buttonIndex);
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
    ac_safeBlockCall(_willPresent, alertView);
}

- (void)didPresentAlertView:(UIAlertView *)alertView {
    ac_safeBlockCall(_didPresent, alertView);
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    ac_safeBlockCall(_willDismiss, alertView, buttonIndex);
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    ac_safeBlockCall(_didDismiss, alertView, buttonIndex);
}

@end