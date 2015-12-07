//
//  OAuthWebViewController.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/7/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "OAuthWebViewController.h"
@import WebKit;
@import WKWebView;

NSString const *kClientID = @"6106";
NSString const *kBaseURL = @"https://codefellows.com";




@interface OAuthWebViewController ()

@end

@implementation OAuthWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *stackURLString = [NSString stringWithFormat:@"%@client_id=%@&redirect_uri=%@", kBaseURL, kClientID, kRedirectURI];
    NSURL *stackURL = [NSURL URLWithString:stackURLString]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:stackURL]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSRULRequest *request = navigationAction.reqeust;
    NSURL *requestURL = 
}

@end
