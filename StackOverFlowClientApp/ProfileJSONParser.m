//
//  ProfileJSONParser.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "ProfileJSONParser.h"
#import "Error.h"
#import "User.h"
#import "Question.h"

@implementation ProfileJSONParser

+ (void)myProfileFromDictionary:(NSDictionary *)dictionary completion:(kUserCompletionHandler)completion {
    if (dictionary) {
        NSArray *userInfoList = dictionary[@"items"];
        for (NSDictionary *userInfo in userInfoList) {
            NSString *displayName = userInfo[@"display_name"];
            NSString *userIDString = userInfo[@"user_id"];
            int userID = userIDString.intValue;
            NSString *profileImageURLString = userInfo[@"profile_image"];
            NSURL *profileImageURL = [NSURL URLWithString:profileImageURLString];
            
            User *user = [[User alloc]initWithName:displayName link:nil userID:userID reputation:nil profileImageURL:profileImageURL profileImage:nil viewCount:nil title:nil userType:nil];
            
            if (user) {
                completion(user, nil);
                return;
            }
        }
    }
    NSError *error = [NSError errorWithDomain:kStackErrorCodes code:StackOverflowJSONParseFailed userInfo:nil];
    completion(nil, error);
}

@end
