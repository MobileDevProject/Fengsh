//
//  UserInfo.m
//  OnGo
//
//  Created by star on 2/15/16.
//  Copyright © 2016 star. All rights reserved.
//

//#define CONFIG_KEY_USER_INFO        @"UserInfo"


#import "UserInfo.h"


@implementation UserInfo

- (instancetype) initWithDictionary:(NSDictionary*) dict {

    self = [super init];
    
    if (self) {
        self.userId = dict[@"id"];
        self.email = dict[@"email"];
        self.name = dict[@"name"];
        self.photoURL = dict[@"photourl"];
        self.numberOfComments = dict[@"numberofcomments"];
    }
    
    return self;
}



@end
