//
//  ProfileViewController.m
//  FengShui
//
//  Created by Theodor Swedenborg on 23/08/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//


@import Firebase;
#import "AppDelegate.h"
#import "SignInViewController.h"
#import "SWRevealViewController.h"
#import "ProfileViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
@interface ProfileViewController ()//<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UIImageView *imgPersonPhoto;
@end

@implementation ProfileViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    [self.imgPersonPhoto setImage:[UIImage imageNamed:@"person0.jpg"]];
    [self.view layoutIfNeeded];
    self.imgPersonPhoto.layer.cornerRadius = self.imgPersonPhoto.frame.size.height/2;
    self.imgPersonPhoto.clipsToBounds = YES;
    self.imgPersonPhoto.layer.borderWidth = 3.0f;
    self.imgPersonPhoto.layer.borderColor = [UIColor colorWithRed:87.0f/255.0f green:71.0f/255.0f blue:47.0f/255.0f alpha:1].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)playSound:fileName{
    
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
    
}
- (IBAction)goBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)goSideMenu:(UIButton *)sender {
    [self.revealViewController rightRevealToggle:nil];
    [self playSound:@"forwardButton"];
}
- (IBAction)changePhoto:(UIButton *)sender {
    UIActionSheet *objViewActionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Use Gallery",@"Use Camera", nil];
    
    objViewActionSheet.tag = 100;
    [objViewActionSheet showInView:self.view ];
    [self playSound:@"m2"];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag == 100) {
        //btnActionSheetClicked
        
        if (buttonIndex == 0) {
            //            SelectPhotoTableViewController *PhotoScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SelectPhotoTableViewController"];
            //            [self.navigationController pushViewController:PhotoScreen animated:YES];
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:NULL];
            
        }else if (buttonIndex == 1) {
            //check camera
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:@"Device has no camera"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles: nil];
                
                [myAlertView show];
                
            }
            else{
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:picker animated:YES completion:NULL];
            }
            
        }
        //take photo
        
    }
}

#pragma mark - Image Picker Controller delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo{
    
    [self.imgPersonPhoto setImage:image];
    [picker dismissModalViewControllerAnimated:YES];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (IBAction)goSignUp:(id)sender {
    
    [self.view endEditing:YES];
    NSString *strUserEmail = _txtEmail.text;
    NSString *strUserPass = _txtPassword.text;
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
        
        [[FIRAuth auth] signOut:nil];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            // Do something...
            
        [[FIRAuth auth] createUserWithEmail:strUserEmail password:strUserPass completion:^(FIRUser *user, NSError *error)
         {
             [self.view setUserInteractionEnabled:YES];
             dispatch_async(dispatch_get_main_queue(), ^{///////
                 [MBProgressHUD hideHUDForView:self.view animated:YES];/////
                 
             if (error != nil) {
                 UIAlertController * loginErrorAlert = [UIAlertController
                                                        alertControllerWithTitle:@"Signup Failed"
                                                        message:@"Authorization was not granted for the given email and password. Please checke for errors and try again."
                                                        preferredStyle:UIAlertControllerStyleAlert];
                 [self presentViewController:loginErrorAlert animated:YES completion:nil];
                 UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                     [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
                 }];
                 [loginErrorAlert addAction:ok];
                 [self.view setUserInteractionEnabled:YES];
        }
         else{
             [[NSUserDefaults standardUserDefaults] setObject:strUserEmail forKey:@"preferenceUserName"];
             [[NSUserDefaults standardUserDefaults] setObject:strUserEmail forKey:@"preferenceEmail"];
             [[NSUserDefaults standardUserDefaults] setObject:strUserPass forKey:@"preferencePass"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             UIAlertController * loginErrorAlert = [UIAlertController
                                                    alertControllerWithTitle:@"Success!"
                                                    message:@"complete your profile."
                                                    preferredStyle:UIAlertControllerStyleAlert];
             //current photo save
             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
             NSString *documentsDirectory = [paths objectAtIndex:0];
             NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
             NSData *imageData = UIImagePNGRepresentation(self.imgPersonPhoto.image);
             [imageData writeToFile:savedImagePath atomically:NO];
             
             //go sign in
             [self presentViewController:loginErrorAlert animated:YES completion:nil];
             UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                 SignInViewController *logInViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SignInViewController"];
                 [self presentViewController:logInViewController animated:YES completion:nil];
                 [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
                 
             }];
             [loginErrorAlert addAction:ok];
             
             
             
         }
                 [self.view setUserInteractionEnabled:YES];
             });
             //after progress
             }
                            
         
         ];
            });//Add MBProgressBar (dispatch)
        
//        [[FIRAuth auth].currentUser updateEmail:strUserEmail completion:^(NSError * _Nullable error) {
//            if (error != nil) {
//                             // [START_EXCLUDE]
//                             UIAlertController * loginErrorAlert = [UIAlertController
//                                                                    alertControllerWithTitle:@"No Maching Email"
//                                                                    message:@"your email cannot match. Pelase try again"
//                                                                    preferredStyle:UIAlertControllerStyleAlert];
//                             [self presentViewController:loginErrorAlert animated:YES completion:nil];
//                             UIAlertAction *ok = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//                                 //NSLog(@"reset password cancelled.");
//                                 [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
//                             }];
//                             [loginErrorAlert addAction:ok];
//                             // [END_EXCLUDE]
//            }
//            else{
//                             UIAlertController * loginErrorAlert = [UIAlertController
//                                                                    alertControllerWithTitle:@"Success!"
//                                                                    message:@"Update your profile."
//                                                                    preferredStyle:UIAlertControllerStyleAlert];
//                             [self presentViewController:loginErrorAlert animated:YES completion:nil];
//                             UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//                                 LogInViewController *logInViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"LogInViewController"];
//                                 [self presentViewController:logInViewController animated:YES completion:nil];
//                                 [loginErrorAlert dismissViewControllerAnimated:YES completion:nil];
//                             }];
//                             [loginErrorAlert addAction:ok];
//            }
//        }];
        
    }

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // do whatever you have to do
    
    [textField resignFirstResponder];
    return YES;
}

// Called when the UIKeyboardWillHideNotification is sent

- (void)keyboardWasShown:(NSNotification *)aNotification {
    NSDictionary *info = aNotification.userInfo;
    CGSize kbSize = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGPoint viewOrigin = self.view.frame.origin;
    
    CGSize viewSize = self.view.frame.size;
    viewOrigin.y = [UIScreen mainScreen].bounds.size.height - viewSize.height - kbSize.height;
    [self.view setFrame:CGRectMake(viewOrigin.x, viewOrigin.y, viewSize.width, viewSize.height)];
}
- (void)keyboardBeHidden:(NSNotification *)aNotification {
    NSDictionary *info = aNotification.userInfo;
    CGSize kbSize = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGPoint viewOrigin = self.view.frame.origin;
    
    CGSize viewSize = self.view.frame.size;
    viewOrigin.y = viewOrigin.y + kbSize.height;
    
    [self.view setFrame:CGRectMake(viewOrigin.x, viewOrigin.y, viewSize.width, viewSize.height)];
}
@end
