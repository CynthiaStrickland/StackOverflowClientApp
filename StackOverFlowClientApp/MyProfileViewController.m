//
//  MyProfileViewController.m
//  StackOverFlowClientApp
//
//  Created by Cynthia Whitlatch on 12/10/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//


#import "MyProfileViewController.h"
#import "MyProfileService.h"
#import "Error.h"
#import "User.h"
#import "ProfileJSONParser.h"
#import "ImageFetchService.h"


@interface MyProfileViewController ()

@property (strong, nonatomic) User *User;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIDLabel;

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MyProfileService getMyProfileWithCompletion:^(NSDictionary *dictionary, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            [ProfileJSONParser myProfileFromDictionary:dictionary completion:^(User *user, NSError *error) {
                _displayNameLabel.text = [NSString stringWithFormat:@"Name: %@", user.displayName];
                _userIDLabel.text = [NSString stringWithFormat:@"User ID: %i", user.userID];
                [ImageFetchService getImageWithURL:user.profileImageURL completion:^(UIImage *data, NSError *error) {
                    _imageView.image = data;
                }];
            }];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
