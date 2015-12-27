//
//  SearchAPIService.h
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface SearchAPIService : NSObject

+ (void)searchTerms:(NSString *)searchTerm pageNumber:(int)pageNumber completion:(kNSDictionaryCompletionHandler)completion;

@end
