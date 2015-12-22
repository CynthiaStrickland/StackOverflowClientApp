//
//  ImageFetchService.h
//  SearchOverflow
//
//  Created by William Cremin on 12/8/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface ImageFetchService : NSObject

+ (void)getImageWithURL:(NSURL *)url completion:(kUIImageCompletionHandler)completion;

@end
