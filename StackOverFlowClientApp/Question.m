//
//  Question.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "Question.h"
#import "User.h"

@implementation Question

-(id)initWithDisplayName:(NSString*)displayName link:(NSURL *)link userID:(NSInteger *)userID reputation:(NSInteger *)reputation profileImageURL:(NSURL *)profileImageURL profileImage:(UIImage *)profileImage viewCount:(NSInteger *)viewCount title:(NSString *)title {
    
    
    if (self = [super init]) {
        
        [self setDisplayName:displayName];
        [self setLink:link];
        [self setUserID:userID];
        [self setReputation:reputation];
        [self setProfileImageURL:profileImageURL];
        [self setProfileImage:profileImage];
        [self setViewCount:viewCount];
        [self setTitle:title];
    }
    return self;
}

@end
