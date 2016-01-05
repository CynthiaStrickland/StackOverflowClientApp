//
//  SearchViewController.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/9/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchAPIService.h"
#import "SearchJSONParser.h"
#import "Question.h"
#import "SearchTableViewCell.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearchBar];
    [self setupTableView];
}

#pragma mark - Set up UISearchBar and UITableView

- (void)setupSearchBar {
    self.searchBar.delegate = self;
    [self.searchBar becomeFirstResponder];
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"SearchTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}


#pragma mark - UISearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [SearchAPIService searchTerms:self.searchBar.text pageNumber:1 completion:^(NSDictionary *data, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            [SearchJSONParser questionsArrayFromDictionary:data completion:^(NSArray *data, NSError *error) {
                if (error) {
                    NSLog(@"%@", error);
                }
                if (data.count > 0) {
                    [self setDataSource:data];
                }
            }];
        }
    }];
    [self.searchBar resignFirstResponder];
}


#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchTableViewCell *cell = (SearchTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.question = self.dataSource[indexPath.row];
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end

