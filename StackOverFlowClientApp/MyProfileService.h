//
//  MyProfileService.h
//  SearchOverflow
//
//  Created by William Cremin on 12/9/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface MyProfileService : NSObject

+ (void)getMyProfileWithCompletion:(kNSDictionaryCompletionHandler)completion;

@end
