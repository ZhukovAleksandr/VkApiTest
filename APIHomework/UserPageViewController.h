//
//  UserPageViewController.h
//  APIHomework
//
//  Created by Admin on 12.04.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsViewController.h"
#import "User.h"

@interface UserPageViewController : UITableViewController

@property (weak, nonatomic) FriendsViewController *lastVC;
@property (weak, nonatomic) User *user;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *bdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;

- (IBAction)subsAction:(id)sender;


@end
