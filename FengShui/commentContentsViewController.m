//
//  commentContentsViewController.m
//  FengShui
//
//  Created by Theodor Hedin on 11/1/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//
@import Firebase;
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "SWRevealViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "commentContentsViewController.h"

@interface commentContentsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITextView *commnt;

@end

@implementation commentContentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [self.view layoutIfNeeded];
    self.userPhoto.layer.cornerRadius = self.userPhoto.frame.size.height/2;
    self.userPhoto.clipsToBounds = YES;
    self.userPhoto.layer.borderWidth = 3.0f;
    self.userPhoto.layer.borderColor = [UIColor colorWithRed:87.0f/255.0f green:71.0f/255.0f blue:47.0f/255.0f alpha:1].CGColor;
    self.userName.text = [app.commentDic objectForKey:@"name"];
    self.commnt.text = [app.commentDic objectForKey:@"comment"];
    [self.userPhoto sd_setImageWithURL:[app.commentDic objectForKey:@"photoURL"] placeholderImage:[UIImage imageNamed:@"person0.jpg"]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
}
//Add Sound on click
-(void)playSound:fileName{
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
    
}
//show the side bar
- (IBAction)goSideMenu:(UIButton *)sender {
    [self.navigationController.revealViewController rightRevealToggle:nil];
    [self playSound:@"forwardButton"];
}

- (IBAction)BackTo:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self playSound:@"backButton"];
}
@end
