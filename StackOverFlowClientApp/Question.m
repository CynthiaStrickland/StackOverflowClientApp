//
//  Question.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "Question.h"

@implementation Question

- (id)initWithTitle:(NSString *)title owner:(User *)owner {
    [self setTitle:title];
    [self setOwner:owner];
    return self;
}

@end


