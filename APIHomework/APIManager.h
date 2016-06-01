//
//  APIManager.h
//  APIHomework
//
//  Created by Admin on 11.04.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface APIManager : NSObject



+ (APIManager *) sharedManager;
- (void) getFriendsWithOffset:(NSInteger)offset
                        count:(NSInteger)count
                      success:(void(^)(NSArray *friends))success
                      failure:(void(^)(NSError *error, int statusCode))failure;

- (void) getInfoForUser:(User *)user
                success:(void(^)(NSArray *users))success
                failure:(void(^)(NSError *error))failure;

- (void) getSubscriptionsForUser:(User *)user
                         success:(void(^)(NSArray *friends))success
                         failure:(void(^)(NSError *error))failure;

@end
