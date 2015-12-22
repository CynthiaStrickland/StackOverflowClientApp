//
//  BurgerMenuViewController.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/7/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

#import "BurgerMenuViewController.h"
#import "MenuTableViewController.h"
#import "MainContentViewController.h"
#import "MyQuestionsViewController.h"
#import "SearchViewController.h"

CGFloat const kburgerOpenScreenDivider = 3.0;
CGFloat const kburgerOpenScreenMultiplier = 2.0;
CGFloat const kburgerButtonWidth = 50.0;
CGFloat const kburgerButtonHeight = 50.0;
NSTimeInterval const ktimeToSlideMenuOpen = 0.2;

@interface BurgerMenuViewController ()<UITableViewDelegate>

@property (strong,nonatomic) MenuTableViewController *menuTableViewController;
@property (strong,nonatomic) MainContentViewController *topViewController;
@property (strong, nonatomic) MyQuestionsViewController *myQuestionsViewController;
//@property (strong, nonatomic) ProfileViewController *profileViewController;
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
    [self setupMenuTableViewController];
    [self setupSearchViewController];
    [self setupAdditonalMenuViewControllers];
    
}

-(BOOL)prefersStatusBarHidden{
    return true;
}

-(void)setupMenuTableViewController{
    MenuTableViewController *menuTableVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuTableViewController"];
    menuTableVC.tableView.delegate = self;
    [self addChildViewController:menuTableVC];
    menuTableVC.view.frame = self.view.frame;
    [self.view addSubview:menuTableVC.view];
    [menuTableVC didMoveToParentViewController:self];
    self.menuTableViewController = menuTableVC;
}

-(void)setupSearchViewController{
    SearchViewController *searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
//    searchVC.tableView.delegate = self;
    [self addChildViewController:searchVC];
    searchVC.view.frame = self.view.frame;
    
    [self.view addSubview:searchVC.view];
    [searchVC didMoveToParentViewController:self];
    self.SearchViewController = searchVC;
}

-(void)setupAdditonalMenuViewControllers{
    MyQuestionsViewController *myQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuestionsVC"];
    self.myQuestionsViewController = myQuestionsVC;
}

//- (void)setUpProfileViewController {
//    ProfileViewController *profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
//    self.profileViewController = profileVC;
//}

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

















////
////  BurgerMenuViewController.m
////  StackExchangeClient
////
////  Created by Miles Ranisavljevic on 12/7/15.
////  Copyright © 2015 creeperspeak. All rights reserved.
////
//
//#import "BurgerMenuViewController.h"
//#import "MenuTableViewController.h"
//#import "SearchViewController.h"
//#import "MyQuestionsViewController.h"
//#import "ProfileViewController.h"
//#import "NSObject+UIColorExtension.h"
//
//CGFloat const kBurgerMenuOpenScreenDivider = 3.0;
//CGFloat const kBurgerMenuOpenScreenMultiplier = 2.7;
//CGFloat const kBurgerButtonWidth = 40.0;
//CGFloat const kBurgerButtonHeight = 40.0;
//NSTimeInterval const kBurgerMenuAnimationTime = 1.0;
//
//@interface BurgerMenuViewController () <UITableViewDelegate>
//
//@property (strong, nonatomic) MenuTableViewController *menuViewController;
//@property (strong, nonatomic) SearchViewController *searchViewController;
//@property (strong, nonatomic) MyQuestionsViewController *questionsViewController;
//@property (strong, nonatomic) ProfileViewController *profileViewController;
//@property (strong, nonatomic) UIViewController *topViewController;
//@property (strong, nonatomic) UIButton *burgerMenuButton;
//@property (strong, nonatomic) UIPanGestureRecognizer *panRecognizer;
//@property (strong, nonatomic) NSArray *viewControllers;
//
//@end
//
//@implementation BurgerMenuViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [self setUpViewControllers];
//    
//    [self setUpMenuButton];
//    [self setUpPanGestureRecognizer];}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}
//
//- (void)setUpViewControllers {
//    [self setUpMenuViewController];
//    [self setUpSearchViewController];
//    [self setUpMyQuestionsViewController];
//    [self setUpProfileViewController];
//    self.topViewController = self.searchViewController;
//    self.viewControllers = @[self.searchViewController, self.questionsViewController, self.profileViewController];
//    
//}
//
//- (void)setUpMenuViewController {
//    MenuTableViewController *menuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuTableViewController"];
//    menuVC.tableView.delegate = self;
//    [self addChildViewController:menuVC];
//    menuVC.view.frame = self.view.frame;
//    [self.view addSubview:menuVC.view];
//    [menuVC didMoveToParentViewController:self];
//    self.menuViewController = menuVC;
//}
//
//- (void)setUpSearchViewController {
//    SearchViewController *searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
//    [self addChildViewController:searchVC];
//    searchVC.view.frame = self.view.frame;
//    [self.view addSubview:searchVC.view];
//    [searchVC didMoveToParentViewController:self];
//    self.searchViewController = searchVC;
//}
//
//- (void)setUpMyQuestionsViewController {
//    MyQuestionsViewController *myQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuestionsViewController"];
//    self.questionsViewController = myQuestionsVC;
//}
//
//- (void)setUpProfileViewController {
//    ProfileViewController *profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
//    self.profileViewController = profileVC;
//}
//
//- (void)setUpMenuButton {
//    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0, 30.0, kBurgerButtonWidth, kBurgerButtonHeight)];
//    menuButton.backgroundColor = [UIColor pastelYellowColor];
//    [menuButton.imageView setClipsToBounds:YES];
//    [menuButton setImage:[UIImage imageNamed:@"guy.png"] forState:UIControlStateNormal];
//    menuButton.layer.cornerRadius = 5.0;
//    menuButton.contentMode = UIViewContentModeScaleAspectFit;
//    [self.topViewController.view addSubview:menuButton];
//    [menuButton addTarget:self action:@selector(burgerMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    self.burgerMenuButton = menuButton;
//    
//}
//
//- (void)burgerMenuButtonPressed:(UIButton *)sender {
//    [UIView animateWithDuration:kBurgerMenuAnimationTime delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.topViewController.view.center = CGPointMake(self.view.center.x * kBurgerMenuOpenScreenMultiplier, self.view.center.y);
//    } completion:^(BOOL finished) {
//        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu:)];
//        [self.topViewController.view addGestureRecognizer:tapRecognizer];
//        sender.userInteractionEnabled = NO;
//    }];
//}
//
//- (void)tapToCloseMenu:(UITapGestureRecognizer *)sender {
//    [self.topViewController.view removeGestureRecognizer:sender];
//    [UIView animateWithDuration:kBurgerMenuAnimationTime delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.topViewController.view.center = self.view.center;
//    } completion:^(BOOL finished) {
//        self.burgerMenuButton.userInteractionEnabled = YES;
//    }];
//}
//
//- (void)setUpPanGestureRecognizer {
//    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pannedScreen:)];
//    [self.topViewController.view addGestureRecognizer:self.panRecognizer];
//}
//
//- (void)pannedScreen:(UIPanGestureRecognizer *)sender {
//    CGPoint velocity = [sender velocityInView:self.topViewController.view];
//    CGPoint translation = [sender translationInView:self.topViewController.view];
//    
//    if (sender.state == UIGestureRecognizerStateChanged) {
//        if (velocity.x > 0) {
//            self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translation.x, self.topViewController.view.center.y);
//            [sender setTranslation:CGPointZero inView:self.topViewController.view];
//        }
//    }
//    if (sender.state == UIGestureRecognizerStateEnded) {
//        if (self.topViewController.view.frame.origin.x > self.topViewController.view.frame.size.width / kBurgerMenuOpenScreenDivider) {
//            [UIView animateWithDuration:kBurgerMenuAnimationTime delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                self.topViewController.view.center = CGPointMake(self.view.center.x * kBurgerMenuOpenScreenMultiplier, self.view.center.y);
//            } completion:^(BOOL finished) {
//                UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu:)];
//                [self.topViewController.view addGestureRecognizer:tapRecognizer];
//                self.burgerMenuButton.userInteractionEnabled = NO;
//            }];
//        } else {
//            [UIView animateWithDuration:kBurgerMenuAnimationTime delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
//                self.topViewController.view.center = self.view.center;
//            } completion:^(BOOL finished) {
//                //
//            }];
//        }
//    }
//}
//
//- (void)switchToViewController:(UIViewController *)viewController {
//    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.topViewController.view.frame = CGRectMake(self.view.frame.size.width, self.view.frame.origin.y, self.topViewController.view.frame.size.width, self.topViewController.view.frame.size.height);
//    } completion:^(BOOL finished) {
//        CGRect oldFrame = self.topViewController.view.frame;
//        [self.topViewController.view removeFromSuperview];
//        [self.topViewController removeFromParentViewController];
//        
//        viewController.view.frame = oldFrame;
//        [self addChildViewController:viewController];
//        [self.view addSubview:viewController.view];
//        [viewController didMoveToParentViewController:self];
//        
//        [self.burgerMenuButton removeFromSuperview];
//        [viewController.view addSubview:self.burgerMenuButton];
//        self.topViewController = viewController;
//        
//        [UIView animateWithDuration:kBurgerMenuAnimationTime delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            viewController.view.center = self.view.center;
//            self.burgerMenuButton.userInteractionEnabled = YES;
//        } completion:^(BOOL finished) {
//            [viewController.view addGestureRecognizer:self.panRecognizer];
//        }];
//        
//    }];
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UIViewController *viewController = self.viewControllers[indexPath.row];
//    if (![self.topViewController isEqual:viewController]) {
//        [self switchToViewController:viewController];
//    }
//}
//
//@end
















