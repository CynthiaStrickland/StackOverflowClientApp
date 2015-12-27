//
//  MyQuestionsJSONParser.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface MyQuestionsJSONParser : NSObject

+ (void)myQuestionsFromDictionary:(NSDictionary *)dictionary completion:(kNSArrayCompletionHandler)completion;

@end
