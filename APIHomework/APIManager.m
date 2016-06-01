//
//  APIManager.m
//  APIHomework
//
//  Created by Admin on 11.04.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking.h"
#import "User.h"
#import "Subscription.h"

@interface APIManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation APIManager

+ (APIManager *) sharedManager {
    
    
    static APIManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[APIManager alloc] init];
    });
    
    return manager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURL *url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    return self;
}

- (void) getFriendsWithOffset:(NSInteger)offset
                        count:(NSInteger)count
                      success:(void(^)(NSArray *friends))success
                      failure:(void(^)(NSError *error))failure {
    
    
    NSDictionary *params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @"6026177", @"user_id",
//     @"name", @"order",
     @(count), @"count",
     @(offset), @"offset",
     @"photo_50", @"fields",
     @"nom", @"name_case", nil];
    

    [self.sessionManager GET:@"friends.get" parameters:params
    progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSArray *friendsArray = [responseObject objectForKey:@"response"];
        
        NSMutableArray* objectsArray = [NSMutableArray new];
        
        for (NSDictionary *dict in friendsArray) {
            User *user = [[User alloc] initWithServerResponse:dict];
            [objectsArray addObject:user];
        }
        
        if (success) {
            success(objectsArray);
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", [error localizedDescription]);
        
        if (failure) {
            failure(error);
        }
    }];
}

- (void) getInfoForUser:(User *)user
                success:(void(^)(NSArray *users))success
                failure:(void(^)(NSError *error))failure {
    
    
    NSDictionary *params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     user.userID, @"user_ids",
     @"photo_max, home_town, contacs, followers_count, sex, bdate, about, lists, interests, music, city, online", @"fields",
     @"nom", @"name_case", nil];
    
    
    [self.sessionManager GET:@"users.get" parameters:params
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        NSLog(@"JSON: %@", responseObject);
                        
                        NSArray *usersArray = [responseObject objectForKey:@"response"];
                        
                        NSMutableArray* objectsArray = [NSMutableArray new];
                        
                        for (NSDictionary *dict in usersArray) {
                            User *user1 = [[User alloc] initUserWithServerResponse:dict ID:user.userID];
                            [objectsArray addObject:user1];
                        }
                        
                        if (success) {
                            success(objectsArray);
                        }
                        
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSLog(@"error: %@", [error localizedDescription]);
                        
                        if (failure) {
                            failure(error);
                        }
                    }];
}

- (void) getSubscriptionsForUser:(User *)user
                         success:(void(^)(NSArray *friends))success
                         failure:(void(^)(NSError *error))failure {
    
    long ID = [user.userID integerValue];
    
    NSDictionary *params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @(ID), @"user_id",
     @(YES), @"extended",
     @"photo_50", @"fields", nil];
    
    NSLog(@"ID: %ld", ID);
    
    [self.sessionManager GET:@"users.getSubscriptions" parameters:params
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        NSLog(@"getSubscriptions: %@", responseObject);
                        
                        NSArray *subsArray = [responseObject objectForKey:@"response"];
                        
                        NSMutableArray* objectsArray = [NSMutableArray new];
                        
                        for (NSDictionary *dict in subsArray) {
                            Subscription *sub = [[Subscription alloc] initWithServerResponse:dict];
                            [objectsArray addObject:sub];
                        }
                        
                        if (success) {
                            success(objectsArray);
                        }
                        
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSLog(@"error: %@", [error localizedDescription]);
                        
                        if (failure) {
                            failure(error);
                        }
                    }];
}



@end
