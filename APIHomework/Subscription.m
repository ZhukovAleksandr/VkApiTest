//
//  Subscriptions.m
//  APIHomework
//
//  Created by Admin on 30.04.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "Subscription.h"

@implementation Subscription

- (id)initWithServerResponse:(NSDictionary *)responseDictionary
{
    self = [super init];
    if (self) {
        
        self.type = [responseDictionary objectForKey:@"type"];
        self.photo = [responseDictionary objectForKey:@"photo_50"];
        
        if ([self.type isEqualToString:@"profile"]) {
            
            self.name = [NSString stringWithFormat:@"%@ %@", [responseDictionary objectForKey:@"first_name"], [responseDictionary objectForKey:@"last_name"]];
            self.objectID = [[responseDictionary objectForKey:@"uid"] integerValue];
            
            
        } else if ([self.type isEqualToString:@"page"]) {
            
            self.name = [responseDictionary objectForKey:@"name"];
            self.isClosed = [responseDictionary objectForKey:@"is_closed"];
            self.objectID = [[responseDictionary objectForKey:@"gid"] integerValue];
        }
    }
    return self;
}

@end
