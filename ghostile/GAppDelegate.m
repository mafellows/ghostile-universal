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
    
    
    navController.navigationBar.barTintColor = [UIColor colorWithRed:74 / 255 green:72 / 255 blue:78 / 255 alpha:0.75];
    navController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                        NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:18.0]};
    [self changeStatusBarColor];

    
    
    [[self window] setRootViewController:navController];     
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)applicationDidEnterBackground:(UIApplication *)application
{
//    BOOL success = [[UserStore sharedStore] saveChanges];
//    if (success) {
//        NSLog(@"Saved all user info");
//    } else {
//        NSLog(@"Unable to save user info"); 
//    }
}

-(void)countLaunch
{
    

}

#pragma mark - Appearance

-(void)changeStatusBarColor
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}



@end
