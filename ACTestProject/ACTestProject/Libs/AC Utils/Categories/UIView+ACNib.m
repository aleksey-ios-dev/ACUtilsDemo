//
// Created by Aleksey on 07.02.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "UIView+ACNib.h"

@implementation UIView (ACNib)

+ (id)ac_viewFromNibNamed:(NSString *)name owner:(id)owner {
    return [[[NSBundle mainBundle] loadNibNamed:name owner:owner options:nil] lastObject];
}

+ (id)ac_viewFromNibNamed:(NSString *)name {
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] lastObject];
}

+ (id)ac_viewFromNib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (UINib *)ac_nib {
    return [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
}

@end