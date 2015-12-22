//
//  MyQuestionsService.h
//  SearchOverflow
//
//  Created by William Cremin on 12/9/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface MyQuestionsService : NSObject

+ (void)getMyQuestionsWithCompletion:(kNSDictionaryCompletionHandler)completion;

@end
