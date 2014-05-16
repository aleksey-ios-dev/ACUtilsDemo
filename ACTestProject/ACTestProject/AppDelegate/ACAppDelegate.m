//
//  ACAppDelegate.m
//  ACTestProject
//
//  Created by Aleksey on 10.04.14.
//  Copyright (c) 2014 yalantis. All rights reserved.
//

#import "ACAppDelegate.h"
#import "MagicalRecord+Setup.h"
#import "ACMainViewController.h"

@implementation ACAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MagicalRecord setupCoreDataStack];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [self.window setRootViewController:[ACMainViewController new]];

    [self.window makeKeyAndVisible];

    return YES;
}

@end
