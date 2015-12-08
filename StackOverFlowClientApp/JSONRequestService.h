//
//  JSONRequestService.h
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface JSONRequestService : NSObject

+ (void)getRequestWithURL:(NSString * _Nonnull)url parameters:(NSDictionary * _Nullable)parameters withCompletion:()completion;

@end
