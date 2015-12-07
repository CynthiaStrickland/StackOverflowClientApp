//
//  MenuContainerViewController.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/7/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "MenuContainerViewController.h"
#import "MenuTableViewController.h"
#import "SearchQuestionsViewcontroller.h"
#import "MyQuestionsViewController.h"

CGFloat const kBurgerOpenScreenDivider = 3.0;
CGFloat const kBurgerOpenScreenMultiplier = 2.0;
CGFloat const kbuergerButtonWidth = 50.0;
CGFloat const kburgerButtonHeight = 50.0;

NSTimeInterval const kTimeToSlideMenuOpen = 0.2;


@interface MenuContainerViewController () <UITableViewDelegate>

@property (strong, nonatomic) MenuTableViewController *leftMenuVC;
@property (strong, nonatomic) SearchQuestionsViewController *searchVC;
@property (strong, nonatomic) MyQuestionsViewController *myQuestionsVC;

@property (strong, nonatomic) UIButton *burgerButton;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@property (strong, nonatomic) NSArray *viewControllers;

@end

@implementation MenuContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllViewControllers];
    [self setupMainContentViewController];
    [self setupAdditonalViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupAllViewControllers {
    
}

- (void)setupMenuViewController {
    
    MenuTableViewController *leftMenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenuVC"];
    leftMenuVC.tableView.delegate = self;
    [self addChildViewController:leftMenuVC];
    leftMenuVC.view.frame = self.view.frame;
    
    [self.view addSubview:leftMenuVC.view];
    [leftMenuVC didMoveToParentViewController:self];
    self.leftMenuVC = leftMenuVC;
    
}

- (void)setupMainContentViewController {
    
    SearchQuestionsViewController *searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    [self addChildViewController:searchVC];
    searchVC.view.frame = self.view.frame;
    
    [self.view addSubview:searchVC.view];
    [searchVC didMoveToParentViewController:self];
    self.searchVC = searchVC;
    
}

- (void)setupAdditionalViewController {
    
    MyQuestionsViewController *myQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuestionsVC"];
    [self addChildViewController:myQuestionsVC];
    myQuestionsVC.view.frame = self.view.frame;
    
    [self.view addSubview:myQuestionsVC.view];
    [myQuestionsVC didMoveToParentViewController:self];
    self.myQuestionsVC = myQuestionsVC;
    
}
@end

















