//
//  ViewController.m
//  APIHomework
//
//  Created by Admin on 11.04.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "FriendsViewController.h"
#import "APIManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "UserPageViewController.h"

@interface FriendsViewController ()

@property   (strong, nonatomic) NSMutableArray *friendsArray;

@end

@implementation FriendsViewController

static int friendsInRequest = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    


    self.friendsArray = [NSMutableArray new];
    
    [self getFriendsFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void) getFriendsFromServer {
    
    [[APIManager sharedManager]
    getFriendsWithOffset:[self.friendsArray count]
    count:friendsInRequest
    success:^(NSArray *friends) {
    [self.friendsArray addObjectsFromArray:friends];
    [self.tableView reloadData];
    }
    failure:^(NSError *error, int statusCode) {
    NSLog(@"error: %@, code: %d", [error localizedDescription], statusCode);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.friendsArray count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    

    cell.imageView.image = nil;
    
    if (indexPath.row == [self.friendsArray count]) {
        cell.textLabel.text = @"LOAD MORE";
        cell.imageView.image = nil;
        
    } else {
        
        User *user = [self.friendsArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:user.imageURL];
        
        __weak UITableViewCell *weakCell = cell;
        
        
        cell.imageView.image = nil;
        
        [cell.imageView setImageWithURLRequest:request
        placeholderImage:[UIImage imageNamed:@"placeholder.png"]
        success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
        {
                weakCell.imageView.image = image;
                [weakCell layoutSubviews];
        }
        failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error)
        {
                                               
        }];
        }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == [self.friendsArray count]) {
        [self getFriendsFromServer];
    } else {
        
        NSLog(@"Friend pressed!");
        
//        [self performSegueWithIdentifier:@"goUserPageViewController" sender:[self.friendsArray objectAtIndex:indexPath.row]];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UserPageViewController *vc = [sb instantiateViewControllerWithIdentifier:@"UserPageViewController"];
        vc.user = [self.friendsArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
//        [self presentViewController:vc animated:YES completion:nil];
    }
    
}

#pragma mark - Navigation

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if ([segue.identifier isEqualToString:@"goUserPageViewController"])  {
//        UserPageViewController *vc = [segue destinationViewController];
//        vc.user = sender;
//    }
//}

@end
