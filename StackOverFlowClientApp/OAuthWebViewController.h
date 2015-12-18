//
//  OAuthWebViewController.h
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/7/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OAuthWebViewControllerComletion)();

@interface OAuthWebViewController : UIViewController

@property (copy, nonatomic) OAuthWebViewControllerComletion completion;

@end
