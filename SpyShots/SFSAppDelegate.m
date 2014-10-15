//
//  SFSAppDelegate.m
//  SpyShots
//
//  Created by pixelhacker on 3/4/14.
//  Copyright (c) 2014 Small Factory Studios. All rights reserved.
//

#import "SFSAppDelegate.h"
#import "Mixpanel.h"

#define MIXPANEL_TOKEN @"fa530efa6725648d6c4299dc71788a11"

@implementation SFSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    // Initialize the MixpanelAPI object
    self.mixpanel = [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
    
    Mixpanel *mixpanelStartup = [Mixpanel sharedInstance];
    [mixpanelStartup track:@"LaunchedApp"];
    
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:101.0/255.0 green:24.0/255.0 blue:10/255.0 alpha:1.0]];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application{
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
}

- (void)applicationWillTerminate:(UIApplication *)application{
}

@end
