//
//  SearchJSONParser.m
//  SearchOverflow
//
//  Created by William Cremin on 12/8/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "SearchJSONParser.h"
#import "User.h"
#import "Question.h"
#import "Error.h"

@implementation SearchJSONParser

+ (void)questionsArrayFromDictionary:(NSDictionary *)dictionary completion:(kNSArrayCompletionHandler)completion {
    if (dictionary) {
        NSMutableArray *results = [[NSMutableArray<Question *> alloc]init];
        NSMutableArray *questions = dictionary[@"items"];
        for (NSDictionary *question in questions) {
            User *owner;
            NSDictionary *ownerInfo = question[@"owner"];
            if (ownerInfo) {
                int userID = (int) ownerInfo[@"user_id"];
                NSString *userType = ownerInfo[@"user_type"];
                NSString *profileImageString = ownerInfo[@"profile_image"];
                NSURL *profileImageURL = [[NSURL alloc]initWithString:profileImageString];
                NSString *displayName = ownerInfo[@"display_name"];
                NSString *linkString = ownerInfo[@"link"];
                NSURL *link = [[NSURL alloc]initWithString:linkString];
            
                owner = [[User alloc]initWithName:displayName link:link userID:userID reputation:nil profileImageURL:profileImageURL profileImage:nil viewCount:nil title:nil userType:userType];
            }

            NSString *title = question[@"title"];
            Question *question = [[Question alloc]initWithTitle:title owner:owner];
            
            if (question) {
                [results addObject:question];
            }
        }
        if (results) {
            completion(results, nil);
            return;
        }
    }
    NSError *error = [NSError errorWithDomain:kStackErrorCodes code:StackOverflowJSONParseFailed userInfo:nil];
    completion(nil, error);
}

@end
