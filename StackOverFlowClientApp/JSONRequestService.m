//
//  JSONRequestService.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "JSONRequestService.h"
#import "AFNetworking.h"
#import "Error.h"

@implementation JSONRequestService

+ (void)GETRequestWithURLString:(NSString *)url parameters:(NSDictionary *)parameters completion:(kIDCompletionHandler)completion {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSOperationQueue *managerQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [managerQueue setSuspended:NO];
                break;
            default:
                [managerQueue setSuspended:YES];
                break;
        }
    }];
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completion(responseObject, nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
        NSLog(@"%@", url);
        NSLog(@"%@", parameters);
        
    }];
}

@end
