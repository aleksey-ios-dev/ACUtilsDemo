//
//  ACSamplePlayer.h
//  ACTestProject
//
//  Created by Aleksey on 23.04.14.
//  Copyright (c) 2014 yalantis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ACSamplePlayer : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * wins;
@property (nonatomic, retain) NSString * details;

@end

#import "ACSamplePlayer+Extension.h"
