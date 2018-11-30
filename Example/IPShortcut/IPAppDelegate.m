//
//  IPAppDelegate.m
//  IPShortcut
//
//  Created by Brian Donohue on 11/29/2018.
//  Copyright (c) 2018 Brian Donohue. All rights reserved.
//

#import "IPAppDelegate.h"

#import "IPViewController.h"

@implementation IPAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    IPViewController *viewController = [[IPViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.rootViewController = navController;
    //[self.window makeKeyAndVisible];
}

@end
