//
//  SignInViewController.m
//  FengShui
//
//  Created by Theodor Swedenborg on 20/08/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//
#import "SignUpViewController.h"
#import "SWRevealViewController.h"
#import "SignInViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"

@import Firebase;

@interface SignInViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end

@implementation SignInViewController

- (void)viewDidLoad {

        [super viewDidLoad];
    _txtUserName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"preferenceEmail"];
    
    _txtPassword.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"preferencePass"];
    
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnSignIn:(id)sender {
    //[[FIRAuth auth] signOut:(NSError *error, _Nullable *nullvaue )];
    [self playSound:@"m3"];
    NSString *strUserEmail = _txtUserName.text;
    NSString *strUserPass = _txtPassword.text;

    // [START headless_email_auth]
    
    if ([strUserEmail isEqual:@""] && [strUserPass isEqual:@""]) {
        UIAlertController * loginErrorAlert = [UIAlertController
                                               alertControllerWithTitle:@"Invalid name and password"
                                               message:@"Please enter the UserName and Password."
                                               preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:loginErrorAlert animated:YES completion:nil];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            NSLog(@"reset password cancelled.");
            [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        [loginErrorAlert addAction:ok];
        
    } else if ([strUserEmail isEqual:@""]) {
        
        UIAlertController * loginErrorAlert = [UIAlertController
                                               alertControllerWithTitle:@"Invalid username or email"
                                               message:@"Please enter the UserName."
                                               preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:loginErrorAlert animated:YES completion:nil];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        [loginErrorAlert addAction:ok];
        
    } else if([strUserPass isEqual:@""]) {
        
        UIAlertController * loginErrorAlert = [UIAlertController
                                               alertControllerWithTitle:@"Invalid password"
                                               message:@"Please enter the Password."
                                               preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:loginErrorAlert animated:YES completion:nil];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        [loginErrorAlert addAction:ok];
    } else{
    // [START headless_email_auth]
        [self.view setUserInteractionEnabled:NO];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            // Do something...
            
    [[FIRAuth auth] signInWithEmail:strUserEmail
                           password:strUserPass
                         completion:^(FIRUser *user, NSError *error) {
                             

                             // [START_EXCLUDE]
                             if (error != nil) {
                                 UIAlertController * loginErrorAlert = [UIAlertController
                                                                        alertControllerWithTitle:@"Login Failed"
                                                                        message:@"Authorization was not granted for the given email and password. Please checke for errors and try again."
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

                                 FIRAuthCredential *credential = [FIREmailPasswordAuthProvider credentialWithEmail:strUserEmail password:strUserPass];
                                 [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser * user, NSError * error) {
                                     dispatch_async(dispatch_get_main_queue(), ^{///////
                                         [MBProgressHUD hideHUDForView:self.view animated:YES];/////
                                     if (error==nil) {
                                         SWRevealViewController *swRevealViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                                         [self presentViewController:swRevealViewController animated:YES completion:nil];
                                         NSString *userName = _txtUserName.text;
                                         NSString *userPass = _txtPassword.text;
                                         [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"preferenceEmail"];
                                         [[NSUserDefaults standardUserDefaults] setObject:userPass forKey:@"preferencePass"];
                                         [[NSUserDefaults standardUserDefaults] synchronize];
                                     }
                                     });
                                     //after progress
                                 }];
                                 
                                 //NSLog(@"succeed login");
                             }
                         

                             // [END_EXCLUDE]
                         }];
        });//Add MBProgressBar (dispatch)
    
    // [END headless_email_auth]
    }

}

-(void)playSound:fileName{
    
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
    
}
- (IBAction)goForgotPassword:(UIButton *)sender {
    [self playSound:@"m3"];
    UIAlertController *requestResetPass = [UIAlertController
                                           alertControllerWithTitle:@"Reset Password"
                                           message:@"are you sure want to reset your password?"
                                           preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *prompt = [UIAlertAction actionWithTitle:@"reset" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        UITextField *emailTextField = requestResetPass.textFields.firstObject;
        NSString* email = emailTextField.text;
        if ([email isEqualToString:@""]) {
            [requestResetPass dismissViewControllerAnimated:YES completion:nil];
        }
        [[FIRAuth auth] sendPasswordResetWithEmail:(email) completion:^(NSError *error){
            if (error) {
                UIAlertController * loginErrorAlert = [UIAlertController
                                                       alertControllerWithTitle:@"Password reset failed."
                                                       message:@"Your pasword reset was unsuccessfull. Please try again."
                                                       preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:loginErrorAlert animated:YES completion:nil];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
                }];
                [loginErrorAlert addAction:ok];
                
            }
            else
            {
                UIAlertController * loginErrorAlert = [UIAlertController
                                                       alertControllerWithTitle:@"Resent Your Password"
                                                       message:@"You have successfully reset the password for your account."
                                                       preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:loginErrorAlert animated:YES completion:nil];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
                }];
                [loginErrorAlert addAction:ok];

            }
        }];
        [requestResetPass dismissViewControllerAnimated:YES completion:nil];
        
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"reset password cancelled.");
        [requestResetPass dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [requestResetPass addAction:prompt];
    [requestResetPass addAction:cancel];
    [requestResetPass addTextFieldWithConfigurationHandler:^(UITextField *emailText){
        emailText.placeholder = NSLocalizedString(@"email", "Address");
    }];
    
    [self presentViewController:requestResetPass animated:YES completion:nil];
}
- (IBAction)goBack:(UIButton *)sender {
    [self playSound:@"backButton"];
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UINavigationController *homeViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self presentViewController:homeViewController animated:YES completion:nil];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // do whatever you have to do
    
    [textField resignFirstResponder];
    return YES;
}



@end
