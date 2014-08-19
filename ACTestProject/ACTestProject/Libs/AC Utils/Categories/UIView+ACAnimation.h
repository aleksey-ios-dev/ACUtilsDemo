//
// Created by Aleksey on 15.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

@interface UIView (ACAnimation)

- (void)ac_appearDuration:(NSTimeInterval)duration;
- (void)ac_appearDuration:(NSTimeInterval)duration completion:(void(^)(BOOL finished))completion;

- (void)ac_disappearDuration:(NSTimeInterval)duration;
- (void)ac_disappearDuration:(NSTimeInterval)duration completion:(void(^)(BOOL finished))completion;;

@end