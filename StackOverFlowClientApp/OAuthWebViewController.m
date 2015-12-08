//
//  OAuthWebViewController.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/7/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "Error.m"
#import "ErrorDomainViewController.h"
#import "OAuthWebViewController.h"
@import WebKit;

NSString const *kClientID = @"6106";
NSString const *kBaseURL = @"https://stackexchange.com/oauth/dialog?";
NSString const *kRedirectURI = @"https://stackexchange.com/oauth/login_success";

@interface OAuthWebViewController () <WKNavigationDelegate>

@property(strong, nonatomic) WKWebView *webView;


@end

@implementation OAuthWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *stackOverflowError = [NSError errorWithDomain:kStackErrorCodes code: userInfo:nil];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    
    self.webView.navigationDelegate = self;
    
    NSString *stackURLString = [NSString stringWithFormat:@"%@client_id=%@&redirect_uri=%@&scope=write_access", kBaseURL, kClientID, kRedirectURI];
    NSLog(@"stackURLString: %@", stackURLString);
    
    NSURL *stackURL = [NSURL URLWithString:stackURLString];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:stackURL]];
    
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSURLRequest *request = navigationAction.request;
    NSURL *requestURL = request.URL;
    
    NSLog(@"request URL: %@", requestURL);
    
    if([requestURL.description containsString:@"access_token"]){
        NSArray *urlComponents = [[requestURL description] componentsSeparatedByString:@"="];
        NSString *accessToken = urlComponents.lastObject;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:accessToken forKey:@"accessToken"];
        [userDefaults synchronize];
        
        if (self.completion) {
            self.completion();
        }
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
