//
//  Constants.h
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

@import Foundation;
@import UIKit;
#import "User.h"
#import "Constants.h"

typedef void(^kNSDataCompletionHandler)(NSData *data, NSError *error);
typedef void(^kNSArrayCompletionHandler)(NSArray *array, NSError *error);
typedef void(^kNSDictionaryCompletionHandler)(NSDictionary *dictionary, NSError *error);
typedef void(^kUIImageCompletionHandler)(UIImage *image, NSError *error);
typedef void(^kIdCompletionHandler)(id responseObject, NSError *error);




