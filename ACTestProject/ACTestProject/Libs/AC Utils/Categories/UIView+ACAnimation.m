//
// Created by Aleksey on 15.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "UIView+ACAnimation.h"

@implementation UIView (ACAnimation)

- (void)ac_appearDuration:(NSTimeInterval)duration {
    [self ac_appearDuration:duration completion:nil];
}

- (void)ac_appearDuration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion {
    [self setHidden:NO];
    [self setAlpha:0.f];
    [UIView animateWithDuration:duration animations:^{
        [self setAlpha:1.f];
    } completion:completion];
}

- (void)ac_disappearDuration:(NSTimeInterval)duration {
    [self ac_disappearDuration:duration completion:nil];
}

- (void)ac_disappearDuration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion {
    [UIView animateWithDuration:duration animations:^{
        [self setAlpha:0.f];
    } completion:completion];
}

@end