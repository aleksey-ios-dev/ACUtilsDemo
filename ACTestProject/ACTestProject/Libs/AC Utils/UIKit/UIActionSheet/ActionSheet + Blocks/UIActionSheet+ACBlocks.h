//
// Created by Aleksey on 16.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "ACActionSheetDelegate.h"

@interface UIActionSheet (ACBlocks)

@property (nonatomic, strong) ACActionSheetDelegate *ac_delegate;

- (void)ac_setDestructiveBlock:(ACActionSheetActivityBlock)destructiveBlock;
- (void)ac_setCancelBlock:(ACActionSheetActivityBlock)block;
- (void)ac_setOtherBlocks:(ACActionSheetActivityBlock)firstBlock, ... NS_REQUIRES_NIL_TERMINATION;

- (void)ac_setWillPresent:(ACActionSheetAppearanceBlock)willPresent;
- (void)ac_setDidPresent:(ACActionSheetAppearanceBlock)didPresent;

- (void)ac_setWillDismiss:(ACActionSheetActivityBlock)willDismiss;
- (void)ac_setDidDismiss:(ACActionSheetActivityBlock)didDismiss;


@end