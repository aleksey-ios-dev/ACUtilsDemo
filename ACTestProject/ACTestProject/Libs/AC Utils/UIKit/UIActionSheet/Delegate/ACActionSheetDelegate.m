//
// Created by Aleksey on 16.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACActionSheetDelegate.h"
#import "ACDataSourceDefinitions.h"

@implementation ACActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        ac_safeBlockCall(_destructiveBlock, actionSheet, buttonIndex);
        return;
    }

    if (buttonIndex == actionSheet.cancelButtonIndex) {
        ac_safeBlockCall(_cancelBlock, actionSheet, buttonIndex);
        return;
    }

    NSInteger indexShift = actionSheet.destructiveButtonIndex != -1 ? 1 : 0;
    NSUInteger indexInArray = (NSUInteger)(buttonIndex - indexShift);

    if (indexInArray >= [_otherBlocks count] || [[_otherBlocks objectAtIndex:indexInArray] isEqual:[NSNull null]]) {
        return;
    }

    ACActionSheetActivityBlock block = [_otherBlocks objectAtIndex:indexInArray];
    block(actionSheet, buttonIndex);
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    ac_safeBlockCall(_willPresent, actionSheet);
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet {
    ac_safeBlockCall(_didPresent, actionSheet);
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    ac_safeBlockCall(_willDismiss, actionSheet, buttonIndex);
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    ac_safeBlockCall(_didDismiss, actionSheet, buttonIndex);
}

@end