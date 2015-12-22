//
//  MyProfileViewController.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/10/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//


#import "MyProfileViewController.h"
#import "User.h"

@interface MyProfileViewController ()

@property (strong, nonatomic) User *User;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *reputationLabel;

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
//    [self loadUser];
}

- (void)setUser:(User *)User {
    User = User;
    self.nameLabel.text = User.displayName;
    self.reputationLabel.text = [NSString stringWithFormat:@"Reputation: %i", User.reputation];
    [self downloadProfileImage:User];
}

//- (void)loadUser {
//    [StackOverflowMyUserProfileAPIService fetchMyProfileInfoWithCompletion:^(NSDictionary *dictionary, NSError *error) {
//        if (error) {
//            NSLog(@"%@", error.localizedDescription);
//            return;
//        }
//        if (dictionary) {
//            [StackOverflowJSONParseMyUserService parseMyUserFromDictionary:dictionary completion:^(MyUser *myUser, NSError *error) {
//                if (error) {
//                    NSLog(@"%@", error.localizedDescription);
//                    return;
//                }
//                if (myUser) {
//                    [self setMyUser:myUser];
//                }
//            }];
//        }
//    }];
//}

- (void)downloadProfileImage:(User *)User {
    dispatch_queue_t imageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(imageQueue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:User.profileImageURL];
        UIImage *profileImage = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.User.profileImage = profileImage;
            self.profileImageView.image = profileImage;
        });
    });
}

@end
