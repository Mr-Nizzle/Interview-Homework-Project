//
//  AppDelegate.m
//  Interview Homework Project
//
//  Created by Ricardo Guillen on 6/15/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "EmptyViewController.h"
#import "DetailViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate, MasterViewControllerDelegate>
@property (nonatomic, strong) MasterViewController *masterViewController;
@property (nonatomic, strong) EmptyViewController *emptyViewController;
@property (nonatomic, strong) UINavigationController *mainNavigationController;
@property (nonatomic, strong) UINavigationController *detailNavigationController;
@property (nonatomic, strong) UISplitViewController *mainSplitViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if (IS_IPAD) {
        self.masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
        self.masterViewController.delegate = self;
        self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:self.masterViewController];
        
        self.emptyViewController = [[EmptyViewController alloc] initWithNibName:@"EmptyViewController" bundle:nil];
        self.detailNavigationController = [[UINavigationController alloc] initWithRootViewController:self.emptyViewController];
        
        self.mainSplitViewController = [[UISplitViewController alloc] init];
        self.mainSplitViewController.viewControllers = @[self.mainNavigationController, self.detailNavigationController];
        self.mainSplitViewController.delegate = self.emptyViewController;
        self.window.rootViewController = self.mainSplitViewController;
    }
    else{
        self.masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
        self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:self.masterViewController];
        self.window.rootViewController = self.mainNavigationController;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark Master Delegate 

-(void)ipadMasterdidSelectVenue:(Venue *)venue{
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
    detailViewController.venue = venue;
    self.mainSplitViewController.delegate = detailViewController;
    [self.detailNavigationController setViewControllers:@[detailViewController] animated:YES];
}


@end
