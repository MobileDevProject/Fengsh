//
//  commentContentsViewController.m
//  FengShui
//
//  Created by Theodor Hedin on 11/1/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//
#import "SWRevealViewController.h"
#import "commentContentsViewController.h"

@interface commentContentsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITextView *commnt;

@end

@implementation commentContentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    self.userPhoto.layer.cornerRadius = self.userPhoto.frame.size.height/2;
    self.userPhoto.clipsToBounds = YES;
    self.userPhoto.layer.borderWidth = 3.0f;
    self.userPhoto.layer.borderColor = [UIColor colorWithRed:87.0f/255.0f green:71.0f/255.0f blue:47.0f/255.0f alpha:1].CGColor;
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
@end
