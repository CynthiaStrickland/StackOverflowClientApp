//
//  QuestionsJSONParser.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "QuestionsJSONParser.h"
#import "User.h"
#import "Question.h"
#import "Error.h"

@implementation QuestionsJSONParser

+ (void)myQuestionsFromDictionary:(NSDictionary *)dictionary completion:(kNSArrayCompletionHandler)completion {
    if (dictionary) {
        NSMutableArray *results = [[NSMutableArray<Question *> alloc]init];
        NSArray *questions = dictionary[@"items"];
        for (NSDictionary *question in questions) {
            NSString *title = question[@"title"];
            Question *question = [[Question alloc]initWithTitle:title owner:nil];
            
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
