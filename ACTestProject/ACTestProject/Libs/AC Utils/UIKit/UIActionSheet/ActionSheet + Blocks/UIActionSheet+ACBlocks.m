//
// Created by Aleksey on 16.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import <objc/runtime.h>
#import "UIActionSheet+ACBlocks.h"

static void *ACActionSheetDelegateKey;

@implementation UIActionSheet (ACBlocks)

@dynamic ac_delegate;

- (void)ac_setDestructiveBlock:(ACActionSheetActivityBlock)destructiveBlock{
    [self.ac_delegate setDestructiveBlock:destructiveBlock];
}

- (void)ac_setCancelBlock:(ACActionSheetActivityBlock)block {
    [self.ac_delegate setCancelBlock:block];
}

- (void)ac_setOtherBlocks:(ACActionSheetActivityBlock)firstBlock, ... {
    NSMutableArray *blocks = [NSMutableArray new];

    va_list args;
    va_start(args, firstBlock);


    for (id block = firstBlock; block != nil; block = va_arg(args, id)) {
        [blocks addObject:block];
    }

    [self.ac_delegate setOtherBlocks:[blocks copy]];

    va_end(args);
}

- (void)ac_setWillPresent:(ACActionSheetAppearanceBlock)willPresent {
    [self.ac_delegate setWillPresent:willPresent];
}

- (void)ac_setDidPresent:(ACActionSheetAppearanceBlock)didPresent {
    [self.ac_delegate setDidPresent:didPresent];
}

- (void)ac_setWillDismiss:(ACActionSheetActivityBlock)willDismiss {
    [self.ac_delegate setWillDismiss:willDismiss];
}

- (void)ac_setDidDismiss:(ACActionSheetActivityBlock)didDismiss {
    [self.ac_delegate setDidDismiss:didDismiss];
}

- (ACActionSheetDelegate *)ac_delegate {
    ACActionSheetDelegate *delegate = objc_getAssociatedObject(self, &ACActionSheetDelegateKey);
    if (delegate) return delegate;

    delegate = [ACActionSheetDelegate new];
    objc_setAssociatedObject(self, &ACActionSheetDelegateKey, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setDelegate:delegate];

    return delegate;
}

@end