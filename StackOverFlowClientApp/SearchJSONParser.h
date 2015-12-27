//
//  SearchJSONParser.h
//  SearchOverflow
//
//  Created by William Cremin on 12/8/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface SearchJSONParser : NSObject

+ (void)questionsArrayFromDictionary:(NSDictionary *)dictionary completion:(kNSArrayCompletionHandler)completion;



@end
