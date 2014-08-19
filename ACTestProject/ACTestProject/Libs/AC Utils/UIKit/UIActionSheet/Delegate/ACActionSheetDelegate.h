//
// Created by Aleksey on 16.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

typedef void (^ACActionSheetActivityBlock)(UIActionSheet *actionSheet, NSInteger buttonIndex);
typedef void (^ACActionSheetAppearanceBlock)(UIActionSheet *actionSheet);

@interface ACActionSheetDelegate : NSObject <UIActionSheetDelegate>

@property (nonatomic, copy) ACActionSheetActivityBlock destructiveBlock;
@property (nonatomic, copy) ACActionSheetActivityBlock cancelBlock;
@property (nonatomic, copy) NSArray *otherBlocks;

@property (nonatomic, copy) ACActionSheetAppearanceBlock willPresent;
@property (nonatomic, copy) ACActionSheetAppearanceBlock didPresent;

@property (nonatomic, copy) ACActionSheetActivityBlock willDismiss;
@property (nonatomic, copy) ACActionSheetActivityBlock didDismiss;

@end