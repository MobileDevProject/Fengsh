//
//  UserInfo.h
//  OnGo
//
//  Created by star on 2/15/16.
//  Copyright © 2016 star. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserInfo : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSURL *photoURL;
@property (nonatomic, copy) NSString * numberOfComments;


- (instancetype) initWithDictionary:(NSDictionary*) dict;
@end
