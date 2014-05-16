//
// Created by Aleksey on 08.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACAlertViewDelegate.h"

@interface UIAlertView (ACBlocks)

@property (nonatomic, strong) ACAlertViewDelegate *ac_delegate;

- (void)ac_setCancelBlock:(ACAlertViewActivityBlock)block;
- (void)ac_setOtherBlocks:(ACAlertViewActivityBlock)firstBlock, ... NS_REQUIRES_NIL_TERMINATION;

- (void)ac_setWillPresent:(ACAlertViewAppearanceBlock)willPresent;
- (void)ac_setDidPresent:(ACAlertViewAppearanceBlock)didPresent;

- (void)ac_setWillDismiss:(ACAlertViewActivityBlock)willDismiss;
- (void)ac_setDidDismiss:(ACAlertViewActivityBlock)didDismiss;

@end


