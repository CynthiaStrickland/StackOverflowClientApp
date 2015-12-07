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
CGFloat const kburgerButtonWidth = 50.0;
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
    [self setupAdditionalViewController];
    [self setupPanGesture];
    [self setupBurgerButton];
    
    self.viewControllers = @[self.searchVC, self.myQuestionsVC];
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
    
    self.myQuestionsVC = myQuestionsVC;
    
}

- (void)setupBurgerButton {
    UIButton *burgerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kburgerButtonWidth, kburgerButtonHeight)];
    
    [burgerButton setImage:@"emptyStar" forState:UIControlStateNormal];
    
    [self.searchVC.view addSubview:burgerButton];
    
    [burgerButton addTarget:self action:@selector(burgerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)burgerButtonPressed:(UIButton *)sender {
    
    [UIView animateWithDuration:kTimeToSlideMenuOpen animations:^ {
        self.searchVC.view.center = CGPointMake(self.view.center.x *kBurgerOpenScreenMultiplier, self.searchVC.view.center.y);
    } completion:^(BOOL finished) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToCloseMenu)];
        sender.userInteractionEnabled = NO;
        
    }];
}

- (void)setupPanGesture {
    self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(topViewControllerPanned:)];
}

- (void)tapToCloseMenu:(UITapGestureRecognizer *)tap {
    [self.searchVC.view removeGestureRecognizer:tap];
    [UIView animateWithDuration:kTimeToSlideMenuOpen animations:^ {
        self.searchVC.view.center = self.view.center;
    } completion:^(BOOL finished) {
        self.burgerButton.userInteractionEnabled = YES;
    }];
}

- (void)topViewControllerPanned:(UIPanGestureRecognizer *)sender {
    CGPoint velocity = [sender velocityInView:self.searchVC.view];
    CGPoint translation = [sender translationInView:self.searchVC.view];
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        if (velocity.x > 0) {
            self.searchVC.view.center = CGPointMake(self.searchVC.view.center.x + translation.x, self.searchVC.view.center.y);
            [sender setTranslation:CGPointZero inView:self.searchVC.view];
        }
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.searchVC.view.frame.origin.x > self.searchVC.view.frame.size.width / kBurgerOpenScreenDivider) {
            [UIView animateWithDuration:kTimeToSlideMenuOpen animations:^{
                self.searchVC.view.center = CGPointMake(self.view.center.x * kBurgerOpenScreenMultiplier, self.searchVC.view.center.y);
                
        } completion:^(BOOL finished) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToCloseMenu:)];
            [self.searchVC.view addGestureRecognizer:tap];
            self.burgerButton.userInteractionEnabled = NO;
        }];
            
        }
    } else {
        [UIView animateWithDuration:kTimeToSlideMenuOpen animations:^{
            self.searchVC.view.center = CGPointMake(self.view.center.x, self.searchVC.view.center.y);
        } completion:nil];
    }
}

- (void)switchToViewController:(UIViewController *)ViewController {
    [UIView animateWithDuration:kTimeToSlideMenuOpen animations:^{
        self.searchVC.view.frame = CGRectMake(self.view.frame.size.width, self.searchVC.view.frame.origin.y, self.searchVC.view.frame.size.width, self.searchVC.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        CGRect oldFrame = self.searchVC.view.frame;
        [self.searchVC willMoveToParentViewController:nil];
        [self.searchVC.view removeFromSuperview];
        [self.searchVC removeFromParentViewController];
        
        [self addChildViewController:_searchVC];
        ViewController.view.frame = oldFrame;
        [self.view addSubview:ViewController.view];
        [ViewController didMoveToParentViewController:self];
        self.searchVC = ViewController;
        
        [self.burgerButton removeFromSuperview];
        [self.searchVC.view addSubview:self.burgerButton];
        
        [UIView animateWithDuration:kTimeToSlideMenuOpen animations:^{
            self.searchVC.view.center = self.view.center;
        } completion:^(BOOL finished) {
            [self.searchVC.view addGestureRecognizer:self.panGesture];
            self.burgerButton.userInteractionEnabled = true;
        
        }];
    }];
}



@end
    
















