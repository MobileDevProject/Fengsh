//
//  SplashAndHomeViewController.m
//  FengShui
//
//  Created by Theodor Swedenborg on 19/08/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//
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
#import "MBProgressHUD.h"

@interface SplashAndHomeViewController ()<SWRevealViewControllerDelegate>
{
    FBSDKLoginButton *loginButton;
    TWTRLogInButton *logInTwitterButton;
    
}
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *splashImage;
@property (weak, nonatomic) IBOutlet UIButton *SigninWithFacebook;


@end

@implementation SplashAndHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user !=nil) {
        // User is logged in, do work such as go to next view controller.
        app.splashOn = NO;
        SWRevealViewController *swRevealViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [self presentViewController:swRevealViewController animated:YES completion:nil];
        NSLog(@"name : %@, mail: %@, useruid: %@", user.displayName, user.email, user.uid);

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
    loginButton = [[FBSDKLoginButton alloc] init];
    [loginButton setHidden:YES];
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    //signin with Twitter
    logInTwitterButton.loginMethods = TWTRLoginMethodWebBased;
    [logInTwitterButton setHidden:YES];
    [self.view addSubview:logInTwitterButton];
//
//    // TODO: Change where the log in button is positioned in your view
//    logInButton.center = self.view.center;
//    [self.view addSubview:logInButton];
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

- (IBAction)SignInTwitter:(UIButton *)sender {
    

    
    [self playSound:@"m3"];
    [self.view setUserInteractionEnabled:NO];
    [[Twitter sharedInstance] logInWithMethods:TWTRLoginMethodWebBased completion:^(TWTRSession * _Nullable session, NSError * _Nullable error) {
        if (session) {


                if (error==nil) {
                    NSLog(@"logged in user with id %@", session.userName);
                    //add MBprogressBar
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                        // Do something...
                        FIRAuthCredential *credential = [FIRTwitterAuthProvider credentialWithToken:session.authToken secret:session.authTokenSecret ];
                        [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser * user, NSError * error) {
                            //after progress
                            dispatch_async(dispatch_get_main_queue(), ^{///////
                                [MBProgressHUD hideHUDForView:self.view animated:YES];/////
                                [self.view setUserInteractionEnabled:YES];
                                SWRevealViewController *swRevealViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                                [self presentViewController:swRevealViewController animated:YES completion:nil];
                            });
                            //after progress
                    }];
                    });//Add MBProgressBar (dispatch)
                    }
//
//            
            }else{


                
                [self.view setUserInteractionEnabled:YES];
            }
    }];

}




- (IBAction)SignInFacebook:(UIButton *)sender {
    [self playSound:@"m3"];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [self.view setUserInteractionEnabled:NO];
        SWRevealViewController *swRevealViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [self presentViewController:swRevealViewController animated:YES completion:nil];
    }else{
    [self.view setUserInteractionEnabled:NO];
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithReadPermissions:@[@"email"]
                        fromViewController:self
                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                       
                                       if (!result.isCancelled) {
                                           //add MBprogressBar
                                           [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                           dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                                               // Do something...
                                               
                                               [self.view setUserInteractionEnabled:NO];
                                               FIRAuthCredential *credential = [FIRFacebookAuthProvider credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
                                               [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser * user, NSError * error) {
                                                   
                                                   //after progress
                                                       dispatch_async(dispatch_get_main_queue(), ^{///////
                                                           [MBProgressHUD hideHUDForView:self.view animated:YES];/////
                                                           
                                                           
                                                           if (error==nil) {
                                                               [self.view setUserInteractionEnabled:YES];
                                                               SWRevealViewController *swRevealViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                                                               [self presentViewController:swRevealViewController animated:YES completion:nil];
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
                                                   }];
                                           });//Add MBProgressBar (dispatch)
                                       }//result is cancelled.
                                           
                                   }];//Login progress
        
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
    [self playSound:@"m3"];
    NSString *strUserEmail = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"preferenceEmail"];
    NSString *strUserPass = [[NSUserDefaults standardUserDefaults]
                      stringForKey:@"preferencePass"];
    if (!([strUserEmail isEqualToString:@""] || [strUserPass isEqualToString:@"" ] || (strUserPass==nil || strUserEmail == nil))) {
        [self.view setUserInteractionEnabled:NO];
        [[FIRAuth auth] signInWithEmail:strUserEmail
                               password:strUserPass
                             completion:^(FIRUser *user, NSError *error) {
                                 // [START_EXCLUDE]
                                 if (error != nil) {
                                     [self.view setUserInteractionEnabled:YES];
                                     SignInViewController *signInViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignInViewController"];
                                     [self.navigationController pushViewController:signInViewController animated:YES];
                                 }
                                 else
                                 {
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
                                 
                                 
                                 // [END_EXCLUDE]
                             }];

    }
    else{
        SignInViewController *signInViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignInViewController"];
        [self.navigationController pushViewController:signInViewController animated:YES];
    }
}
- (IBAction)SignUp:(UIButton *)sender {
    [self playSound:@"m3"];
    SignUpViewController *signUpViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self.navigationController pushViewController:signUpViewController animated:YES];
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
