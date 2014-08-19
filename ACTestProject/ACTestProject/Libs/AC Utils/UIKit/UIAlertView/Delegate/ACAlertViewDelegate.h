//
// Created by Aleksey on 08.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

typedef void (^ACAlertViewActivityBlock)(UIAlertView *alertView, NSInteger buttonIndex);
typedef void (^ACAlertViewAppearanceBlock)(UIAlertView *alertView);

@interface ACAlertViewDelegate : NSObject <UIAlertViewDelegate>

@property (nonatomic, copy) ACAlertViewActivityBlock cancelBlock;
@property (nonatomic, copy) NSArray *otherBlocks;

@property (nonatomic, copy) ACAlertViewAppearanceBlock willPresent;
@property (nonatomic, copy) ACAlertViewAppearanceBlock didPresent;

@property (nonatomic, copy) ACAlertViewActivityBlock willDismiss;
@property (nonatomic, copy) ACAlertViewActivityBlock didDismiss;

@end