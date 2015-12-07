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

- (void)checkForAccessToken {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUSerDefaults];
    NSString *accessToken = [userDefaults]

}

@end
