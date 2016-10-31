//
//  SubBranchWebViewController.m
//  FengShui
//
//  Created by Theodor Swedenborg on 11/08/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//
#import "AppDelegate.h"
#import "SWRevealViewController.h"
#import "SubBranchWebViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface SubBranchWebViewController () <SWRevealViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *ButtonBranchName;
@property (weak, nonatomic) IBOutlet UIWebView *BranchWebView;


@property (weak, nonatomic) IBOutlet UIButton *sidebarButton;


@end

@implementation SubBranchWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSString* BranchName = app.strBranchName;
    NSString*BranchDirection = app.BranchDirection;
    _ButtonBranchName.text = BranchName;
    [_ButtonBranchName setTextColor:app.Branch_Color];
    //selected branch number
    int subBranchIndex = app.SubBranchWebIndex;
    NSDictionary *tempDic = app.dicAllURLs;
    NSArray *BranchURLs = (NSArray*)[tempDic objectForKey:[NSString stringWithFormat:@"%@_%@", BranchDirection, BranchName]];
    
    NSString *urlString = [BranchURLs objectAtIndex:subBranchIndex];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [_BranchWebView loadRequest:requestURL];
    
    
    //menu
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    self.revealViewController.draggableBorderWidth = 50.0;
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    //[self.sidebarButton targetForAction:@selector(revealToggle:) withSender:nil];
    //_sidebarButton.target  = self.revealViewController;
    //_sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
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
- (IBAction)goSideMenu:(UIButton *)sender {
    [self.navigationController.revealViewController rightRevealToggle:nil];
    [self playSound:@"forwardButton"];
}

- (IBAction)BackWebView:(UIButton *)sender {
    [_BranchWebView goBack];
    [self playSound:@"backButton"];
}
- (IBAction)ForwardWebView:(UIButton *)sender {
    [_BranchWebView goForward];
    [self playSound:@"forwardButton"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackToSubBranch:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self playSound:@"backButton"];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
}


@end
