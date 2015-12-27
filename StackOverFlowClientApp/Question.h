//
//  Question.h
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "User.h"

@interface Question : NSObject

@property (strong, nonatomic) User *owner;
@property (strong, nonatomic) NSString *title;

- (id)initWithTitle:(NSString *)title owner:(User *)owner;

@end

