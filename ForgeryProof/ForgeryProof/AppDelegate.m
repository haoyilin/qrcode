//
//  AppDelegate.m
//  ForgeryProof
//
//  Created by haoyl on 13-9-2.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize tabBarController = _tabBarController;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    FastSecurityViewController *fastSecurityController = [[FastSecurityViewController alloc] initWithNibName:@"FastSecurityViewController" bundle:nil];
    CustomNavigationController *naviFastSecurity = [[[CustomNavigationController alloc] initWithRootViewController:fastSecurityController] autorelease];
    
    BrandConsultingViewController *brandConsultingViewController = [[BrandConsultingViewController alloc] initWithNibName:@"BrandConsultingViewController" bundle:nil];
    CustomNavigationController *naviBrandConsultingViewController = [[[CustomNavigationController alloc] initWithRootViewController:brandConsultingViewController] autorelease];

    BrandRecommendationViewController *brandRecommendationViewController = [[BrandRecommendationViewController alloc] initWithNibName:@"BrandRecommendationViewController" bundle:nil];
    CustomNavigationController *naviBrandRecommendationViewController = [[[CustomNavigationController alloc] initWithRootViewController:brandRecommendationViewController] autorelease];

    AboutViewController *aboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    CustomNavigationController *naviAboutViewController = [[[CustomNavigationController alloc] initWithRootViewController:aboutViewController] autorelease];
    
    NSArray *arrayControllers = [[NSArray alloc] initWithObjects:naviFastSecurity, naviBrandConsultingViewController, naviBrandRecommendationViewController, naviAboutViewController, nil];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:[UIImage imageNamed:@"TabBar_b1.png"] forKey:@"Default"];
    [dic1 setObject:[UIImage imageNamed:@"TabBar_b1.png"] forKey:@"Highlighted"];
    [dic1 setObject:[UIImage imageNamed:@"TabBar_b1.png"] forKey:@"Seleted"];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setObject:[UIImage imageNamed:@"TabBar_b2.png"] forKey:@"Default"];
    [dic2 setObject:[UIImage imageNamed:@"TabBar_b2.png"] forKey:@"Highlighted"];
    [dic2 setObject:[UIImage imageNamed:@"TabBar_b2.png"] forKey:@"Seleted"];

    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:[UIImage imageNamed:@"TabBar_b3.png"] forKey:@"Default"];
    [dic3 setObject:[UIImage imageNamed:@"TabBar_b3.png"] forKey:@"Highlighted"];
    [dic3 setObject:[UIImage imageNamed:@"TabBar_b3.png"] forKey:@"Seleted"];

    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setObject:[UIImage imageNamed:@"TabBar_b4.png"] forKey:@"Default"];
    [dic4 setObject:[UIImage imageNamed:@"TabBar_b4.png"] forKey:@"Highlighted"];
    [dic4 setObject:[UIImage imageNamed:@"TabBar_b4.png"] forKey:@"Seleted"];

    NSArray *arrayImages = [[NSArray alloc] initWithObjects:dic1, dic2, dic3, dic4, nil];
    
    _tabBarController = [[HylTabBarController alloc] initWithViewControllers:arrayControllers imageArray:arrayImages];    
        
    [self.window setRootViewController:_tabBarController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
