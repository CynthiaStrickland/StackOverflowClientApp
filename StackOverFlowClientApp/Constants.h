//
//  Constants.h
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/8/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef void (^kNSDataCompletionHandler)(NSData * _Nullable data, NSError * _Nullable error);
typedef void (^kNSArrayCompletionHandler)(NSData * _Nullable data, NSError * _Nullable error);
typedef void (^kNSDictionaryCompletionHandler)(NSData * _Nullable data, NSError * _Nullable error);
typedef void (^kNSImageCompletionHandler)(NSData * _Nullable data, NSError * _Nullable error);

