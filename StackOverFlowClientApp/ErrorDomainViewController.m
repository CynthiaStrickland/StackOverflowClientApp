//
//  ErrorDomainViewController.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/7/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "ErrorDomainViewController.h"

extern NSString * const kStackErrorCodes;

typedef enum : NSUInteger {
    StackErrorGeneralError,
    StackErrorInvalidLogin,
    StackErrorInvalidPassword,
    StackErrorInvalidUsername,
    
} StackErrorCodes;


@interface ErrorDomainViewController ()

@end

@implementation ErrorDomainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
