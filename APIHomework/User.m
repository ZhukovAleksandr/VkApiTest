//
//  User.m
//  APIHomework
//
//  Created by Admin on 12.04.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "User.h"

@implementation User

- (id) initWithServerResponse:(NSDictionary *)responseObject
{
    self = [super init];
    if (self) {
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        self.userID = [responseObject objectForKey:@"user_id"];
        NSString *image50 = [responseObject objectForKey:@"photo_50"];
     
        NSURL *url = [[NSURL alloc] initWithString:image50];
        self.imageURL = url;
        }
    
    return self;
}



- (id) initUserWithServerResponse:(NSDictionary *)responseObject ID:(NSString *)ID
{
    self = [super init];
    if (self) {
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        self.userID = ID;
        if ((int)[responseObject objectForKey:@"sex"] == 1) {
            self.sex = @"Female";
        } else if ((int)[responseObject objectForKey:@"sex"] == 2) {
            self.sex = @"Male";
        } else {
            self.sex = @"Not indicated";
        }
        self.bdate = [responseObject objectForKey:@"bdate"] ;
        if ((BOOL)[responseObject objectForKey:@"online"] == 1) {
            self.online = @"Online";
        } else {
            self.online = @"Offline";
        }
        NSString *imageMax = [responseObject objectForKey:@"photo_max"];
        NSURL *url = [[NSURL alloc] initWithString:imageMax];
        self.imageURLmax = url;

    }
    
    return self;
}



@end
