@import Firebase;
#import "AppDelegate.h"
#import <Firebase.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <TwitterKit/TwitterKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SignInViewController.h"
#import "SignUpViewController.h"
#import "SWRevealViewController.h"
#import "SplashAndHomeViewController.h"
#import <FLAnimatedImage.h>
#import <FLAnimatedImageView.h>
#import "Request.h"
#import "MBProgressHUD.h"

@interface SplashAndHomeViewController ()<SWRevealViewControllerDelegate>
{
    FBSDKLoginButton *loginButton;
    AppDelegate *app;
}
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *splashImage;
@property (weak, nonatomic) IBOutlet UIButton *SigninWithFacebook;


@end

@implementation SplashAndHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
    //[self.view setUserInteractionEnabled:YES];
    
    app = [UIApplication sharedApplication].delegate;
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user !=nil) {
        // User is logged in, do work such as go to next view controller.
        app.splashOn = NO;
        [self getUserDataAndGo];
        [self hideSplashScreen];
    }else{
        
        
        if (app.splashOn) {
            app.splashOn = NO;
            [NSTimer scheduledTimerWithTimeInterval:17 target:self selector:@selector(hideSplashScreen) userInfo:nil repeats:NO];
            NSURL *url = [[NSBundle mainBundle] URLForResource:@"SplashScreen" withExtension:@"gif"];
            FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:url]];
            
            self.splashImage.animatedImage = image;
            
        }
        else{
            [self hideSplashScreen];
        }
        [self.splashImage setUserInteractionEnabled:YES];
        UITapGestureRecognizer *closeSplashGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSplash:)];
        [self.splashImage addGestureRecognizer:closeSplashGesture];
        
        
        
    }
    
}
-(void)getUserDataAndGo{
    
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user !=nil) {
        
        [self.view setUserInteractionEnabled:NO];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        //get manager data
        app.user.userId = [NSString stringWithFormat:@"%@", user.uid];
        NSString *userID = user.uid;
        FIRDatabaseReference *userInfo = [[[Request dataref] child:@"users"]child: userID];
        //FIRDatabaseReference *ref = [Request dataref];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [userInfo observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                if (snapshot.exists) {
                    app.user = [[UserInfo alloc]init];
                    NSDictionary *dic = snapshot.value;
                    app.user.name = [dic objectForKey:@"name"];
                    app.user.userId = userID;
                    app.user.email = [dic objectForKey:@"email"];
                    app.user.photoURL = [NSURL URLWithString:[dic objectForKey:@"photourl"]];
                    app.user.numberOfComments = [dic objectForKey:@"numberofcomments"];
                    //NSDictionary*userDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"name",name,@"email", email, @"photourl",photoURL, @"numberofcomments", numberOfComments,@"userid", userId, nil];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //go maim workspace
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [self.view setUserInteractionEnabled:YES];
                        // go to main view
                        SWRevealViewController *swRevealViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                        [self presentViewController:swRevealViewController animated:YES completion:nil];
                        
                    });
                    
                }else{
                    [self.view setUserInteractionEnabled:YES];
                    
                    UIAlertController * loginErrorAlert = [UIAlertController
                                                           alertControllerWithTitle:@"Cannot find your info"
                                                           message:@"cannot access your info. please try again."
                                                           preferredStyle:UIAlertControllerStyleAlert];
                    [self presentViewController:loginErrorAlert animated:YES completion:nil];
                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [self.view setUserInteractionEnabled:YES];
                        [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [loginErrorAlert addAction:ok];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [self.view setUserInteractionEnabled:YES];
                }
            } withCancelBlock:^(NSError * _Nonnull error) {
                
                UIAlertController * loginErrorAlert = [UIAlertController
                                                       alertControllerWithTitle:@"Cannot find your info"
                                                       message:error.localizedDescription
                                                       preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:loginErrorAlert animated:YES completion:nil];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    NSError *isError;
                    [[FIRAuth auth] signOut:&isError];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [self.view setUserInteractionEnabled:YES];
                    [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
                }];
                [loginErrorAlert addAction:ok];
                
            }];
        });
        
    }else{
        NSError *error;
        //if you have a wong credencial info(currentuser) the signout would go out from it.
        [[FIRAuth auth] signOut:&error];
        [[[FBSDKLoginManager alloc] init] logOut];
        
        [self.view setUserInteractionEnabled:YES];
        
        UIAlertController * loginErrorAlert = [UIAlertController
                                               alertControllerWithTitle:@"Cannot find your info"
                                               message:@"cannot access your info. please try again."
                                               preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:loginErrorAlert animated:YES completion:nil];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view setUserInteractionEnabled:YES];
            [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        [loginErrorAlert addAction:ok];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view setUserInteractionEnabled:YES];
    }

}

-(void)closeSplash:(UITapGestureRecognizer*)TapGestureRecogniger{
    [self hideSplashScreen];
}

-(void)playSound:fileName{
    
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
    
}

- (void)hideSplashScreen
{
    
    [_splashImage setHidden:YES];
    [_splashImage removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)SignInFacebook:(UIButton *)sender {
    [self playSound:@"m3"];
    [self.view setUserInteractionEnabled:NO];
    if ([FBSDKAccessToken currentAccessToken]) {
        [self.view setUserInteractionEnabled:YES];
        [self getUserDataAndGo];
    }else{
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logInWithReadPermissions:@[@"email"]
                            fromViewController:self
                                       handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                           
                                           if (!result.isCancelled) {
                                               //add MBprogressBar
                                               [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                               dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                                                   // Do something...
                                                   
                                                   //[self.view setUserInteractionEnabled:NO];
                                                   FIRAuthCredential *credential = [FIRFacebookAuthProvider credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
                                                   [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser * user, NSError * error) {
                                                       
                                                       dispatch_async(dispatch_get_global_queue(0,0), ^{
                                                           NSData * data = [[NSData alloc] initWithContentsOfURL: user.photoURL];
                                                           if ( data == nil )
                                                               return;
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               
                                                               [Request registerUser:user.displayName email:user.email image:[UIImage imageWithData: data]];
                                                               
                                                               
                                                               
                                                               //after progress
                                                               dispatch_async(dispatch_get_main_queue(), ^{///////
                                                                   [MBProgressHUD hideHUDForView:self.view animated:YES];/////
                                                                   
                                                                   
                                                                   if (error==nil) {
                                                                       
                                                                       
                                                                     
                                                                       
                                                                       {
                                                                       app.user = [[UserInfo alloc]init];
                                                                       app.user.name = user.displayName;
                                                                       app.user.userId = user.uid;
                                                                       app.user.email = user.email;
                                                                       app.user.photoURL = user.photoURL;
                                                                       app.user.numberOfComments = @"0";
                                                                           [self getUserDataAndGo];
                                                                           //go maim workspace
                                                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                                           [self.view setUserInteractionEnabled:YES];
                                                                           // go to main view
                                                                           SWRevealViewController *swRevealViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                                                                           [self presentViewController:swRevealViewController animated:YES completion:nil];
                                                                       }
                                                                       
                                                                       
                                                                   }else{
                                                                       UIAlertController * loginErrorAlert = [UIAlertController
                                                                                                              alertControllerWithTitle:@"Login Failed"
                                                                                                              message:error.localizedDescription
                                                                                                              preferredStyle:UIAlertControllerStyleAlert];
                                                                       [self presentViewController:loginErrorAlert animated:YES completion:nil];
                                                                       UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                                           [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
                                                                       }];
                                                                       [loginErrorAlert addAction:ok];
                                                                       [self.view setUserInteractionEnabled:YES];
                                                                   }
                                                               });
                                                               //after progress
                                                           });
                                                           
                                                       });
                                                   }];
                                               });//Add MBProgressBar (dispatch)
                                           }//result is cancelled.
                                           
                                       }];//Login progress
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.view setUserInteractionEnabled:YES];
    }
    
}


- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error {
    [self.view setUserInteractionEnabled:NO];
    if (error == nil) {
        if (!result.isCancelled) {
            FIRAuthCredential *credential = [FIRFacebookAuthProvider credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
            if ([FBSDKAccessToken currentAccessToken]) {
                [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser * user, NSError * error) {
                    if (error==nil) {
                        [self.view setUserInteractionEnabled:YES];
                        SWRevealViewController *swRevealViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                        [self presentViewController:swRevealViewController animated:YES completion:nil];
                    }
                }];
            }
            else{
                UIAlertController * loginErrorAlert = [UIAlertController
                                                       alertControllerWithTitle:@"Login Failed"
                                                       message:@"Authorization was not granted for the given email and password. Please checke for errors and try again."
                                                       preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:loginErrorAlert animated:YES completion:nil];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
                }];
                [loginErrorAlert addAction:ok];
                [self.view setUserInteractionEnabled:YES];
            }
            
        }
        
    }
}





- (IBAction)SignInMail:(UIButton *)sender {
        SignInViewController *signInViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignInViewController"];
    [self.navigationController pushViewController:signInViewController animated:YES];
    //    }
}
- (IBAction)SignUp:(UIButton *)sender {
    [self playSound:@"m3"];
    SignUpViewController *signUpViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self.navigationController pushViewController:signUpViewController animated:YES];
}
#pragma mark - Login Skipe
- (IBAction)skipLogin:(UIButton *)sender {
    // go to main view
    [self playSound:@"m3"];
    [self.view setUserInteractionEnabled:NO];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
    [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRUser  * _Nullable user, NSError  * _Nullable error) {
        
        // [START_EXCLUDE]
        if (error != nil) {
            UIAlertController * loginErrorAlert = [UIAlertController
                                                   alertControllerWithTitle:@"Login Failed"
                                                   message:error.localizedDescription
                                                   preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:loginErrorAlert animated:YES completion:nil];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
            }];
            [loginErrorAlert addAction:ok];
            [MBProgressHUD hideHUDForView:self.view animated:YES];/////
            [self.view setUserInteractionEnabled:YES];
        }
        else
        {

                dispatch_async(dispatch_get_main_queue(), ^{///////
                    
                    if (error==nil) {
                        {
                            
                            //current photo save
                            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
                            NSString *documentsDirectory = [paths objectAtIndex:0];
                            NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
                            NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"person0.jpg"]);
                            [imageData writeToFile:savedImagePath atomically:NO];
                            //register user
                            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                                // Do something...
                                
                                
                                FIRUser *user = [FIRAuth auth].currentUser;
                                FIRUserProfileChangeRequest *changeRequest = [user profileChangeRequest];
                                NSString *userId = user.uid;
                                FIRStorage *storage = [FIRStorage storage];
                                FIRStorageReference *storageRef = [storage reference];
                                app = [UIApplication sharedApplication].delegate;
                                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                                    FIRStorageReference *photoImagesRef = [storageRef child:[NSString stringWithFormat:@"users photo/%@/photo.jpg", [Request currentUserUid]] ];
                                    NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"person0.jpg"]);
                                    
                                    
                                    //image compress until size < 1 MB
                                    int count = 0;
                                    while ([imageData length] > 1000000) {
                                        imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"person0.jpg"], powf(0.9, count));
                                        count++;
                                        NSLog(@"just shrunk it once.");
                                    }
                                    
                                    // Upload the file to the path "images/userID.PNG"f
                                    
                                    [photoImagesRef putData:imageData metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
                                        if (error != nil) {
                                            // Uh-oh, an error occurred!
                                            [self.view setUserInteractionEnabled:YES];
                                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        } else {
                                            // Metadata contains file metadata such as size, content-type, and download URL.
                                            changeRequest.displayName = user.email;
                                            changeRequest.photoURL = metadata.downloadURL;
                                            [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    if (error) {
                                                        // An error happened.
                                                        NSLog(@"%@", error.description);
                                                    } else {
                                                        // Profile updated.
                                                        
                                                        NSDictionary *userData = @{@"name":user.displayName?user.displayName:@"",
                                                                                   @"email":user.email?user.email:@" ",
                                                                                   @"photourl":[metadata.downloadURL absoluteString]?[metadata.downloadURL absoluteString]:@" ",                                                   @"userid":userId?userId:@" ",
                                                                                   @"numberofcomments":@"0"
                                                                                   };
                                                        [[[[[FIRDatabase database] reference] child:@"users"] child:userId]setValue:userData];
                                                        //after progress
                                                        dispatch_async(dispatch_get_main_queue(), ^{///////
                                                            
                                                                [self getUserDataAndGo];
                                                                [self.view setUserInteractionEnabled:YES];
                                                                [MBProgressHUD hideHUDForView:self.view animated:YES];

                                                        });
                                                        
                                                    }
                                                    
                                                });
                                            }];
                                            
                                        }
                                    }];
                                    
                                });
                                
                                
                                
                                
                                
                                
                                //go sign in
                                
                            });
                            
                            
                        }
                    }else{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];/////
                        [self.view setUserInteractionEnabled:YES];
                        UIAlertController * loginErrorAlert = [UIAlertController
                                                               alertControllerWithTitle:@"Login Failed"
                                                               message:error.localizedDescription
                                                               preferredStyle:UIAlertControllerStyleAlert];
                        [self presentViewController:loginErrorAlert animated:YES completion:nil];
                        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                            [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
                        }];
                        [loginErrorAlert addAction:ok];
                    }
                });

            
            //NSLog(@"succeed login");
        }
            }];
    });//Add MBProgressBar (dispatch)
}

/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
