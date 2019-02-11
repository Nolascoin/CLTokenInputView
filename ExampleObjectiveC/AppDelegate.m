//
//  AppDelegate.m
//  ExampleObjectiveC
//
//  Created by Alex Nolasco on 2/10/19.
//

#import "AppDelegate.h"
#import "CLTokenInputViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    CLTokenInputViewController *tokenVC = [[CLTokenInputViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tokenVC];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    return YES;
    
}

@end
