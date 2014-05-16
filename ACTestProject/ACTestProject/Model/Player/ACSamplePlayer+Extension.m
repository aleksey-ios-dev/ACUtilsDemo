//
// Created by Aleksey on 15.05.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACSamplePlayer+Extension.h"
#import "NSManagedObject+MagicalRecord.h"

@implementation ACSamplePlayer (Extension)

- (NSString *)nameDescription {
   return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (void)clone {
    ACSamplePlayer *clone = [ACSamplePlayer MR_createEntity];
    [clone setFirstName:self.firstName];
    [clone setLastName:self.lastName];
    [clone setWins:self.wins];
}


@end