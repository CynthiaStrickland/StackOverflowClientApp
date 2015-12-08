//
//  JSONRequestService.h
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONRequestService : NSObject

+ (void)getRequestWithURL:(NSString *)url parameters:(NSDictionary *)parameters withCompletion:()completion;


@end
