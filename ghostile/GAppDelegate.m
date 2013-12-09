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
<<<<<<< HEAD
    [self changeStatusBarColor];
    
    navController.navigationBar.barTintColor = [UIColor colorWithRed:74 / 255 green:72 / 255 blue:78 / 255 alpha:0.75];
    navController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                        NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:18.0]};
    
=======
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
    [[self window] setRootViewController:navController];     
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

<<<<<<< HEAD
#pragma mark - Appearance

-(void)changeStatusBarColor
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

=======
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351

@end
