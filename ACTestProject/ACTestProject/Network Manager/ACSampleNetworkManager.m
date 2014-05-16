//
// Created by Aleksey on 11.04.14.
// Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACSampleNetworkManager.h"
#import "ACSamplePlayer.h"
#import "NSManagedObject+MagicalRecord.h"

@implementation ACSampleNetworkManager

+ (void)importPlayersCount:(NSInteger)count {
    NSArray *names = [NSArray arrayWithObjects:@"John", @"Ringo", @"George", @"Ben", @"William", @"James", @"Richard", @"Henry", @"Edward", @"Paul", @"Chuck", @"Bruce", nil];
    NSArray *lastNames = [NSArray arrayWithObjects:@"Lennon", @"Starr", @"McCartney", @"Harrison", @"Atkinson", @"Willis", @"Norris", nil];

        NSMutableArray *players = [NSMutableArray new];

        for (NSInteger i = 0; i < count; i++) {
            ACSamplePlayer *player = [ACSamplePlayer MR_createEntity];
            NSUInteger randomIndex = arc4random() % [names count];
            [player setFirstName:names[randomIndex]];
            randomIndex = arc4random() % [lastNames count];
            [player setLastName:lastNames[randomIndex]];
            [player setWins:@(arc4random() % 15)];

            [players addObject:player];
        }
}

@end
