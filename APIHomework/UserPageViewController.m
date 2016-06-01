//
//  UserPageViewController.m
//  APIHomework
//
//  Created by Admin on 12.04.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "UserPageViewController.h"
#import "FriendsViewController.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
#import "SubsViewController.h"


@interface UserPageViewController ()
@property (strong, nonatomic) NSMutableArray *usersArray;
@end

@implementation UserPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usersArray = [NSMutableArray new];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.user.firstName, self.user.lastName];
    
    [self getUserInfoFromServer];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.user = [self.usersArray objectAtIndex:0];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API 

- (void) getUserInfoFromServer {
    
    [[APIManager sharedManager]
    getInfoForUser:self.user success:^(NSArray *users)
    {
    [self.usersArray addObjectsFromArray:users];
        for (id user in self.usersArray) {
            if ([user respondsToSelector:@selector(imageURLmax)]) {
                self.user = user;
                break;
            }
        }
        [self.userImage setImageWithURL:self.user.imageURLmax];
        self.sexLabel.text = self.user.sex;
        self.bdateLabel.text = self.user.bdate;
        self.onlineLabel.text = self.user.online;

    [self.tableView reloadData];
     }
    failure:^(NSError *error)
    {
    NSLog(@"error: %@", [error localizedDescription]);
     }];
}

#pragma mark - Actions

- (IBAction)subsAction:(id)sender {
    
    [[APIManager sharedManager] getSubscriptionsForUser:self.user success:^(NSArray *subs) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SubsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SubsViewController"];
        vc.data = subs;
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"Success");
    } failure:^(NSError *error) {
        NSLog(@"fail %@", [error localizedDescription]);
    }];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

 /*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    switch (indexPath.row) {
        case 1:
            [cell.imageView setImageWithURL:self.user.imageURL200];
            break;
            
        default:
            break;
    }
    return cell;
}
 */

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation


 
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.



@end
