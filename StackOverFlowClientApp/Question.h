//
//  Question.h
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@import UIKit;

@interface Question : NSObject

-(id)initWithTitle:(NSString *)title owner:(User *)owner;

@property NSString *displayName;
@property NSURL *link;
@property NSInteger *userID;
@property NSInteger *reputation;
@property NSURL *profileImageURL;
@property UIImage *profileImage;
@property NSInteger *viewCount;
@property NSString *title;
@property NSDate *creationDate;
@property NSDate *lastActivityDate;
@property NSInteger *score;
@property NSInteger *answerCount;
@property User *owner;

@end

