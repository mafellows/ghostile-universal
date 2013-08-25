//
//  GAppDelegate.m
//  ghostile
//
//  Created by Michael Fellows on 8/23/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import "GAppDelegate.h"
#import "FirstViewController.h"

@implementation GAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    FirstViewController *fvc = [[FirstViewController alloc] init]; 
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:fvc];
    [[self window] setRootViewController:navController];     
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
