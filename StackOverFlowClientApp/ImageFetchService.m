//
//  ImageFetchService.m
//  SearchOverflow
//
//  Created by William Cremin on 12/8/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

#import "ImageFetchService.h"
#import "Error.h"

@implementation ImageFetchService

+ (void)getImageWithURL:(NSURL *)url completion:(kUIImageCompletionHandler)completion {
    dispatch_queue_t imageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(imageQueue, ^{
        NSData *data = [[NSData alloc]initWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image) {
                completion(image, nil);
            } else {
                NSError *error = [NSError errorWithDomain:kStackErrorCodes code:StackOverflowImageFetchFailed userInfo:nil];
                completion(nil, error);
            }
        });
    });
}

@end
