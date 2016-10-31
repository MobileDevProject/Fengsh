//
//  SideMenuViewController.m
//  FengShui
//
//  Created by Theodor Swedenborg on 23/08/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//
@import Firebase;
@import FirebaseAuth;
#import "SWRevealViewController.h"
#import "SideMenuViewController.h"
#import "SignInViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <TwitterKit/TwitterKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface SideMenuViewController ()

@end

@implementation SideMenuViewController
{
    NSArray *menuItems;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return [menuItems count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    return cell;
//}
//
-(void)playSound:fileName{
    
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
    
}
        

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self playSound:@"m3"];
    if (indexPath.row==2) {
        NSString *userName = @"";
        NSString *userPass = @"";
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"preferenceEmail"];
        [[NSUserDefaults standardUserDefaults] setObject:userPass forKey:@"preferencePass"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSError *error;
        [[FIRAuth auth] signOut:&error];
        [[[FBSDKLoginManager alloc] init] logOut];
        
        TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
        NSString *userID = store.session.userID;
        
        [store logOutUserID:userID];
        
        NSLog(@"error: %@", error.localizedDescription);
        UINavigationController *homeViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self presentViewController:homeViewController animated:YES completion:nil];
        
    }

    


    
}

//- (void) goViewControlller {
//
//}

@end
