//
// Created by Aleksey on 11.03.14.
// Copyright (c) 2014 Aleksey Chernish. All rights reserved.
//

#import "DAValidator.h"

typedef DAValidationResult (^DAValidationBlock)(id object);

@interface DAValidator ()

@property (nonatomic, copy) DAValidationBlock block;

@end

@implementation DAValidator

- (id)initWithBlock:(DAValidationBlock)block {
    if (self = [super init]) {
        _block = block;
    }
    return self;
}

+ (DAValidator *)validatorWithBlock:(DAValidationBlock)block {
    return [[self alloc] initWithBlock:block];
}

#pragma mark - Fabric

- (DAValidationResult)validate:(id)object {
    if (!object) return DAValidationInvalid;

    if ([object isKindOfClass:[NSString class]]) {
        if (![(NSString *)object length]) return DAValidationInvalid;
    }

    return self.block(object);
}

+ (DAValidator *)nameValidator {
    return [self validatorWithBlock:^DAValidationResult(NSString *string){
        NSString *regex = @"[a-zA-Z а-яА-Я]+";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        return (DAValidationResult)[predicate evaluateWithObject:string];
    }];
}

+ (DAValidator *)passwordValidator {
    return [self validatorWithBlock:^DAValidationResult(NSString *string){
        return (DAValidationResult)([string length] > 5);
    }];
}

+ (DAValidator *)emailValidator {
    return [self validatorWithBlock:^DAValidationResult(NSString *string){
        // http://www.regular-expressions.info/email.html
        NSString *regex =
                @"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*"
                        "@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        return (DAValidationResult)[predicate evaluateWithObject:string];
    }];
}

+ (DAValidator *)numericValidator {
    return [self validatorWithBlock:^DAValidationResult(NSString *string){
        return (DAValidationResult)([string floatValue] > 0);
    }];
}

+ (DAValidator *)birthdayValidator {
    return [self validatorWithBlock:^DAValidationResult(NSDate *date){
        return (DAValidationResult)([date compare:[NSDate date]] == NSOrderedAscending);
    }];
}

@end