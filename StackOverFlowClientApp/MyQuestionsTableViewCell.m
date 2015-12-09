//
//  MyQuestionsTableViewCell.m
//  
//
//  Created by Cynthia Whitlatch on 12/9/15.
//
//

#import "MyQuestionsTableViewCell.h"


@interface MyQuestionsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *creationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *answersLabel;

@end

@implementation MyQuestionsTableViewCell : UITableViewCell


- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setQuestion:(Question *)question {
    _question = question;
    self.titleLabel.text = question.title;
    self.creationDateLabel.text = [NSString stringWithFormat:@"Creation Date: %@", [NSDateFormatter localizedStringFromDate:question.creationDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle]];
    self.viewsLabel.text = [NSString stringWithFormat:@"Views: %li", question.viewCount];
    self.answersLabel.text = [NSString stringWithFormat:@"Answers: %i", question.answerCount];
}

@end
