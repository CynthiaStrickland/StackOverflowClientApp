//
//  SearchTableViewCell.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/10/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "ImageFetchService.h"
#import "Question.h"

@interface SearchTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

@implementation SearchTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setQuestion:(Question *)question {
    self.ownerNameLabel.text = question.owner.displayName;
    self.questionTitleLabel.text = question.title;
    
    [ImageFetchService getImageWithURL:question.owner.profileImageURL completion:^(UIImage *data, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            self.profileImage.image = data;
        }
    }];
}

@end
