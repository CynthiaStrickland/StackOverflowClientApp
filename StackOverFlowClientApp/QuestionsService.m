//
//  QuestionsService.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "QuestionsService.h"
#import "JSONRequestService.h"
#import "Error.h"
#import "OAuthWebViewController.h"

@implementation QuestionsService

+ (void)getMyQuestionsWithCompletion:(kNSDictionaryCompletionHandler)completion {
    NSString *searchURL = @"https://api.stackexchange.com/2.2/me/questions";
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];

    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"token"];
    NSString *token = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [parameters setObject:@"Eu3RuEDArh1FkwEJyyfZ)g((" forKey:@"key"];
    [parameters setObject:@"desc" forKey:@"order"];
    [parameters setObject:@"activity" forKey:@"sort"];
    [parameters setObject:@"stackoverflow" forKey:@"site"];
    [parameters setObject:token forKey:@"access_token"];
    
    [JSONRequestService GETRequestWithURLString:searchURL parameters:parameters completion:^(id data, NSError *error) {
        if (error) {
            NSError *error = [NSError errorWithDomain:kStackErrorCodes code:StackOverflowQuestionFetchFailed userInfo:nil];
            completion(nil, error);
        } else {
            if ([data isKindOfClass:[NSDictionary class]]) {
                completion((NSDictionary *) data, nil);
            }
        }
    }];
}

@end
