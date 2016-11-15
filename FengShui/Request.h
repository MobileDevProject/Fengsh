//
//  Request.h
//  FengShui
//
//  Created by Theodor Hedin on 11/3/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;
#import "AppDelegate.h"
@interface Request : NSObject
//Firebase
+(void)getUser;
+ (NSString*)currentUserUid;
+(void)registerUser:name email:email image:image;
+ (FIRDatabaseReference*)dataref;
+(void)savePhoto:image;
+(void)updateTime:direction updatedTime:updatedTime;
@end
