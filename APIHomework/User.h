//
//  User.h
//  APIHomework
//
//  Created by Admin on 12.04.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSURL *imageURLmax;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *sex;
@property (strong, nonatomic) NSString *bdate;
@property (strong, nonatomic) NSString* online;

- (id) initWithServerResponse:(NSDictionary *)responseObject;
- (id) initUserWithServerResponse:(NSDictionary *)responseObject ID:(NSString *)ID;

@end
