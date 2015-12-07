//
//  AppDelegate.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/7/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "AppDelegate.h"
#import "OAuthWebViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self checkForAccessToken];
    return YES;
}

-(void)checkForAccessToken{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [userDefaults stringForKey:@"accessToken"];
    
    if(!accessToken){
        [self fetchAccessToken];
    }
}

-(void)fetchAccessToken{
    UIViewController *rootViewController = self.window.rootViewController;
    OAuthWebViewController *oAuthVC = [[OAuthWebViewController alloc] init];
    __weak typeof(oAuthVC) weakOauthVC = oAuthVC;
    oAuthVC.completion = ^() {
        __strong typeof(oAuthVC) strongOauthVC = weakOauthVC;
        [strongOauthVC.view removeFromSuperview];
        [strongOauthVC removeFromParentViewController];
    };
    
    [rootViewController addChildViewController:oAuthVC];
    [rootViewController.view addSubview:oAuthVC.view];
    [oAuthVC didMoveToParentViewController:rootViewController];
}

@end