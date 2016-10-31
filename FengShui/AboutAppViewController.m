//
//  AboutAppViewController.m
//  FengShui
//
//  Created by Theodor Swedenborg on 23/08/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//
#import "SWRevealViewController.h"
#import "AboutAppViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface AboutAppViewController ()

@end

@implementation AboutAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
//Add Sound on click
-(void)playSound:fileName{
    
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
    
}
- (IBAction)goBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//show the side bar
- (IBAction)goSideMenu:(UIButton *)sender {
    [self.revealViewController rightRevealToggle:nil];
    [self playSound:@"forwardButton"];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
}

@end
