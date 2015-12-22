//
//  SearchTableViewCell.h
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/10/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface SearchTableViewCell : UITableViewCell

@property(strong, nonatomic) Question *question;

@end
