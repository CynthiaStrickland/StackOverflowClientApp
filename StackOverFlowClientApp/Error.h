//
//  Error.h
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/9/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kStackErrorCodes = @"Stack Error";

typedef enum : NSInteger {
    StackOverflowBadGetRequest,
    StackOverflowSearchFailed,
    StackOverflowJSONParseFailed,
    StackOverflowImageFetchFailed,
    StackOverflowQuestionFetchFailed,
    StackOverflowProfileFetchFailed,
} StackOverflowErrorCodes;
