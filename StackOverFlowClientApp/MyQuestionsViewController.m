//
//  MyQuestionsViewController.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/7/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "MyQuestionsViewController.h"
#import "QuestionsService.h"
#import "QuestionsJSONParser.h"
#import "Question.h"

@interface MyQuestionsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation MyQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableViewWithData];
}


#pragma mark - Set up UITableView

- (void)setupTableViewWithData {
    [QuestionsService getMyQuestionsWithCompletion:^(NSDictionary *dictionary, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            [QuestionsJSONParser myQuestionsFromDictionary:dictionary completion:^(NSArray *data, NSError *error) {
                if (data.count > 0) {
                    [self setDataSource:data];
                }
            }];
        }
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}


#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource.count > 0) {
        return self.dataSource.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyQuestionsViewControllerCell"];
    if (_dataSource) {
        Question *questionForCell = self.dataSource[indexPath.row];
        cell.textLabel.text = questionForCell.title;
        return cell;
    } else {
        cell.textLabel.text = @"No Questions";
        return cell;
    }
}

@end
