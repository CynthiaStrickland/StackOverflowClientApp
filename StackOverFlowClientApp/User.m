//
//  User.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "User.h"

@implementation User

-(id)initWithName:(NSString*)displayName link:(NSURL *)link userID:(int)userID reputation:(NSInteger *)reputation profileImageURL:(NSURL *)profileImageURL profileImage:(UIImage *)profileImage viewCount:(NSInteger *)viewCount title:(NSString *)title userType:(NSString*)userType {
     
    if (self = [super init]) {
        
        [self setDisplayName:displayName];
        [self setLink:link];
        [self setUserID:userID];
        [self setReputation:reputation];
        [self setProfileImageURL:profileImageURL];
        [self setProfileImage:profileImage];
        [self setViewCount:viewCount];
        [self setTitle:title];
        [self setUserType:userType];
    }
    return self;
}

@end
