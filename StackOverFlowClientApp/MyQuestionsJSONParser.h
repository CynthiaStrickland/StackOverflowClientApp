//
//  MyQuestionsJSONParser.h
//  SearchOverflow
//
//  Created by William Cremin on 12/9/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface MyQuestionsJSONParser : NSObject

+ (void)myQuestionsFromDictionary:(NSDictionary *)dictionary completion:(kNSArrayCompletionHandler)completion;

@end
