//
// Created by Aleksey on 17.08.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+ACPageNumber.h"

static char ACPageNumberKey;

@implementation UIViewController (ACPageNumber)

- (void)ac_setPageNumber:(id)ac_pageNumber {
    objc_setAssociatedObject(self, &ACPageNumberKey, ac_pageNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)ac_pageNumber {
    return objc_getAssociatedObject(self, &ACPageNumberKey);
}

@end