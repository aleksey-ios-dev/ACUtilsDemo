//
// Created by Aleksey on 08.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import <objc/runtime.h>
#import "UIAlertView+ACBlocks.h"

static void *ACAlertViewDelegateKey;

@implementation UIAlertView (ACBlocks)

@dynamic ac_delegate;

- (void)ac_setCancelBlock:(ACAlertViewActivityBlock)block {
    [self.ac_delegate setCancelBlock:block];
}

- (void)ac_setOtherBlocks:(ACAlertViewActivityBlock)firstBlock, ... {
    NSMutableArray *blocks = [NSMutableArray new];

    va_list args;
    va_start(args, firstBlock);

    for (id block = firstBlock; block != nil; block = va_arg(args, id)) {
        [blocks addObject:block];
    }

    [self.ac_delegate setOtherBlocks:[blocks copy]];

    va_end(args);
}

- (void)ac_setWillPresent:(ACAlertViewAppearanceBlock)willPresent {
    [self.ac_delegate setWillPresent:willPresent];
}

- (void)ac_setDidPresent:(ACAlertViewAppearanceBlock)didPresent {
    [self.ac_delegate setDidPresent:didPresent];
}

- (void)ac_setWillDismiss:(ACAlertViewActivityBlock)willDismiss {
    [self.ac_delegate setWillDismiss:willDismiss];
}

- (void)ac_setDidDismiss:(ACAlertViewActivityBlock)didDismiss {
    [self.ac_delegate setDidDismiss:didDismiss];
}

- (ACAlertViewDelegate *)ac_delegate {
    ACAlertViewDelegate *delegate = objc_getAssociatedObject(self, &ACAlertViewDelegateKey);
    if (delegate) {
        return delegate;
    }

    delegate = [ACAlertViewDelegate new];
    objc_setAssociatedObject(self, &ACAlertViewDelegateKey, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setDelegate:delegate];

    return delegate;
}

@end