//
//  Subscriptions.h
//  APIHomework
//
//  Created by Admin on 30.04.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Subscription : NSObject

@property (strong, nonatomic) NSString *type;

@property (assign, nonatomic) BOOL isClosed;
@property (strong , nonatomic) NSString *name;
@property (strong, nonatomic) NSString *photo;
@property (assign, nonatomic) NSInteger objectID;

- (id)initWithServerResponse:(NSDictionary *)responseDictionary;

@end
