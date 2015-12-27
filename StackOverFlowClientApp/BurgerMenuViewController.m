//
//  BurgerMenuViewController.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/7/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "MenuTableViewController.h"
#import "BurgerMenuViewController.h"
#import "MyQuestionsViewController.h"
#import "SearchViewController.h"
#import "MyProfileViewController.h"

CGFloat const kburgerOpenScreenDivider = 3.0;
CGFloat const kburgerOpenScreenMultiplier = 2.0;
CGFloat const kburgerButtonWidth = 50.0;
CGFloat const kburgerButtonHeight = 50.0;
NSTimeInterval const ktimeToSlideMenuOpen = 0.2;

@interface BurgerMenuViewController ()<UITableViewDelegate>

@property (strong, nonatomic) MenuTableViewController *menuViewController;
@property (strong,nonatomic) UIViewController *topViewController;
@property (strong, nonatomic) MyQuestionsViewController *myQuestionsViewController;
@property (strong, nonatomic) MyProfileViewController *myProfileViewController;
@property (strong, nonatomic) SearchViewController *searchViewController;
@property(strong, nonatomic) UIButton *burgerButton;
@property(strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property (strong,nonatomic) NSArray *viewControllers;

@end

@implementation BurgerMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAllViewControllers];
    [self setupPanGesture];
    [self setupBurgerButton];
    
}

-(void)setupAllViewControllers{
    [self setupMenuViewController];
    [self setupTopViewController];
    [self setupContentViewControllers];
    self.viewControllers = @[self.searchViewController, self.myQuestionsViewController, self.myProfileViewController];

    
}

//-(BOOL)prefersStatusBarHidden{
//    return true;
//}

- (void)setupMenuViewController {
    MenuTableViewController *menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuTableViewController"];
    menuViewController.tableView.delegate = self;
    [self addChildViewController:menuViewController];
    menuViewController.view.frame = self.view.frame;
    [self.view addSubview:menuViewController.view];
    [menuViewController didMoveToParentViewController:self];
    self.menuViewController = menuViewController;
}

- (void)setupTopViewController {
    SearchViewController *searchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    [self addChildViewController:searchViewController];
    searchViewController.view.frame = self.view.frame;
    [self.view addSubview:searchViewController.view];
    [searchViewController didMoveToParentViewController:self];
    self.topViewController = searchViewController;
}

-(void)setupContentViewControllers{
    SearchViewController *searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    self.searchViewController = searchVC;
    
//    searchVC.tableView.delegate = self;
//    [self addChildViewController:searchVC];
//    searchVC.view.frame = self.view.frame;
//    [self.view addSubview:searchVC.view];
//    [searchVC didMoveToParentViewController:self];
//    self.searchViewController = searchVC;
    
    MyQuestionsViewController *myQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuestionsViewController"];
    self.myQuestionsViewController = myQuestionsVC;
    MyProfileViewController *profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
    self.myProfileViewController = profileVC;
}

#pragma BUTTONS & GESTURES
-(void)setupBurgerButton{
    UIButton *burgerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kburgerButtonWidth, kburgerButtonHeight)];
    [burgerButton setImage:[UIImage imageNamed:@"emptyStar"] forState:UIControlStateNormal];
    [self.topViewController.view addSubview:burgerButton];
    [burgerButton addTarget:self action:@selector(burgerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.burgerButton = burgerButton;
}

-(void)burgerButtonPressed:(UIButton *)sender {
    [UIView animateWithDuration:ktimeToSlideMenuOpen animations:^{
        self.topViewController.view.center = CGPointMake(self.view.center.x * kburgerOpenScreenMultiplier, self.topViewController.view.center.y);
    } completion:^(BOOL finished) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu:)];
        [self.topViewController.view addGestureRecognizer:tap];
        sender.userInteractionEnabled = false;
        
    }];
}

-(void)setupPanGesture{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(topViewControllerPanned:)];
    [self.topViewController.view addGestureRecognizer:pan];
    self.panGesture = pan;
}

-(void)tapToCloseMenu:(UITapGestureRecognizer *)tap {
    [self.topViewController.view removeGestureRecognizer:tap];
    [UIView animateWithDuration:0.3 animations:^{
        self.topViewController.view.center = self.view.center;
    } completion:^(BOOL finished) {
        
        self.burgerButton.userInteractionEnabled = true;
        
    }];
}

-(void)topViewControllerPanned:(UIPanGestureRecognizer *)sender {    
    CGPoint velocity = [sender velocityInView:self.topViewController.view];
    CGPoint translation = [sender translationInView:self.topViewController.view];
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        if (velocity.x > 0) {
            self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translation.x, self.topViewController.view.center.y);
            [sender setTranslation:CGPointZero inView:self.topViewController.view];
        }
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.topViewController.view.frame.origin.x > self.topViewController.view.frame.size.width / kburgerOpenScreenDivider) {
            NSLog(@"user is opening menu");
            
            [UIView animateWithDuration:ktimeToSlideMenuOpen animations:^{
                self.topViewController.view.center = CGPointMake(self.view.center.x * kburgerOpenScreenMultiplier, self.topViewController.view.center.y);
            } completion:^(BOOL finished) {
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu:)];
                [self.topViewController.view addGestureRecognizer:tap];
                self.burgerButton.userInteractionEnabled = false;
                
            }];
        } else {
            [UIView animateWithDuration:ktimeToSlideMenuOpen animations:^{
                self.topViewController.view.center = CGPointMake(self.view.center.x, self.topViewController.view.center.y);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

-(void)switchToViewController:(UIViewController *)viewController{
    [UIView animateWithDuration:ktimeToSlideMenuOpen animations:^{
        
        self.topViewController.view.frame = CGRectMake(self.view.frame.size.width,self.topViewController.view.frame.origin.y,self.topViewController.view.frame.size.width, self.topViewController.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        CGRect oldFrame = self.topViewController.view.frame;
        [self.topViewController willMoveToParentViewController:nil];
        [self.topViewController.view removeFromSuperview];
        [self.topViewController removeFromParentViewController];
        
        [self addChildViewController:viewController];
        viewController.view.frame = oldFrame;
        [self.view addSubview:viewController.view];
        [viewController didMoveToParentViewController:self];
        self.topViewController = viewController;
        
        [self.burgerButton removeFromSuperview];
        [self.topViewController.view addSubview:self.burgerButton];
        
        
        [UIView animateWithDuration:ktimeToSlideMenuOpen animations:^{
            self.topViewController.view.center = self.view.center;
        } completion:^(BOOL finished) {
            [self.topViewController.view addGestureRecognizer:self.panGesture];
            self.burgerButton.userInteractionEnabled = true;
        }];
    }];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected Menu Item:%ld",(long)indexPath.row);
    
    UIViewController *viewController = self.viewControllers[indexPath.row];
    if (![viewController isEqual:self.topViewController]) {
        [self switchToViewController:viewController];
    }
}

@end
