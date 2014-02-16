//
//  MSAppDelegate.m
//  MSPageViewController
//
//  Created by Nacho Soto on 2/16/14.
//  Copyright (c) 2014 MindSnacks. All rights reserved.
//

#import "MSAppDelegate.h"

#import "MSPageViewControllerExample.h"

@implementation MSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[UIStoryboard storyboardWithName:NSStringFromClass(MSPageViewControllerExample.class)
                                                                       bundle:nil] instantiateInitialViewController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
