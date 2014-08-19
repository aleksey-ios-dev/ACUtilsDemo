//
// Created by Aleksey on 20.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "NSObject+ACClassName.h"


@implementation NSObject (ACClassName)

- (NSString *)ac_className {
    return [[self class] ac_name];
}

+ (NSString *)ac_name {
    return NSStringFromClass(self);
}

+ (NSString *)ac_reuseIdentifier {
    return [self ac_name];
}

@end