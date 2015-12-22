//
//  JSONRequestService.h
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

@import UIKit;
@import Foundation;
#import "Constants.h"

@interface JSONRequestService : NSObject

+ (void)GETRequestWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters completion:(kIDCompletionHandler)completion;

@end

