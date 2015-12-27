//
//  User.h
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface User : NSObject

-(id)initWithName:(NSString*)displayName link:(NSURL *)link userID:(int)userID reputation:(NSInteger *)reputation profileImageURL:(NSURL *)profileImageURL profileImage:(UIImage *)profileImage viewCount:(NSInteger *)viewCount title:(NSString *)title userType:(NSString *)userType;

@property NSString *displayName;
@property NSURL *link;
@property int userID;
@property NSInteger *reputation;
@property NSURL *profileImageURL;
@property UIImage *profileImage;
@property NSInteger *viewCount;
@property NSString *title;
@property NSString *userType;

@end
