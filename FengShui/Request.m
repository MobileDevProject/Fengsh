//
//  Request.m
//  FengShui
//
//  Created by Theodor Hedin on 11/3/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//

#import "Request.h"

@implementation Request
//firebase
    //get user
+(void)getUser{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.currentUser = [[FIRAuth auth]currentUser];
}
+ (NSString*)currentUserUid{
    return [FIRAuth auth].currentUser.uid;
}
+(void)registerUser:name email:email image:image{
    
    FIRUser *user = [FIRAuth auth].currentUser;
    FIRUserProfileChangeRequest *changeRequest = [user profileChangeRequest];
    NSString *userId = user.uid;
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *storageRef = [storage reference];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    FIRStorageReference *photoImagesRef = [storageRef child:[NSString stringWithFormat:@"users photo/%@/photo.jpg", [Request currentUserUid]] ];
    NSData *imageData = UIImagePNGRepresentation(image);
    //register email
    
//    [[FIRAuth auth] sendPasswordResetWithEmail:email
//                                    completion:^(NSError *_Nullable error) {
//                                        if (error) {
//                                            // An error happened.
//                                        } else {
//                                            // Password reset email sent.
//                                        }
//                                    }];
    
    //image compress until size < 1 MB
    int count = 0;
    while ([imageData length] > 1000000) {
        imageData = UIImageJPEGRepresentation(image, powf(0.9, count));
        count++;
        NSLog(@"just shrunk it once.");
    }
    
    // Upload the file to the path "images/userID.PNG"f
    
    [photoImagesRef putData:imageData metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
        if (error != nil) {
            // Uh-oh, an error occurred!
        } else {
            // Metadata contains file metadata such as size, content-type, and download URL.
                changeRequest.displayName = name;
                changeRequest.photoURL = metadata.downloadURL;
                [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                    if (error) {
                    // An error happened.
                        NSLog(@"%@", error.description);
                    } else {
                    // Profile updated.
                        
                        NSDictionary *userData = @{@"name":name,
                                                   @"email":email,
                                                   @"photourl":[metadata.downloadURL absoluteString],
                                                   @"userid":userId,
                                                   @"numberofcomments":@"0"
                                                   };
                        [[[[[FIRDatabase database] reference] child:@"users"] child:[self currentUserUid]]setValue:userData];
                        
                    }
                        
                    });
                }];
            
            }
        }];
        
    });
    
    
}
+ (FIRDatabaseReference*)dataref{
    return [[FIRDatabase database] reference];
}
@end
