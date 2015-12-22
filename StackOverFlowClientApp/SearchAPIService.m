//
//  SearchAPIService.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "SearchAPIService.h"
#import "JSONRequestService.h"
#import "Question.h"
#import "Error.h"

@implementation SearchAPIService

+ (void)searchWithTerm:(NSString *)searchTerm pageNumber:(int)pageNumber completion:(kNSDictionaryCompletionHandler)completion {
    NSString *searchURL = @"https://api.stackexchange.com/2.2/search";
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *pageNumberString;
    
    if (pageNumber > 0) {
        pageNumberString = [NSString stringWithFormat:@"%i", pageNumber];
    } else {
        pageNumberString = @"1";
    }
    
    [parameters setObject:pageNumberString forKey:@"page"];
    [parameters setObject:@"desc" forKey:@"order"];
    [parameters setObject:@"activity" forKey:@"sort"];
    [parameters setObject:searchTerm forKey:@"intitle"];
    [parameters setObject:@"stackoverflow" forKey:@"site"];
    
    [JSONRequestService GETRequestWithURLString:searchURL parameters:parameters completion:^(id data, NSError *error) {
        if (error) {
            NSError *searchError = [NSError errorWithDomain:kStackErrorCodes code:StackOverflowSearchFailed userInfo:nil];
            completion(nil, searchError);
        } else {
            if ([data isKindOfClass:[NSDictionary class]]) {
                completion((NSDictionary *) data, nil);
            }
        }
    }];
}

@end