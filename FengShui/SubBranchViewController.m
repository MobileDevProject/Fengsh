//
//  SubBranchViewController.m
//  FengShui
//
//  Created by Theodor Swedenborg on 11/08/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//
@import Firebase;
#import "SubBranchWebViewController.h"
#import "SubBranchViewController.h"
#import "SWRevealViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
@interface SubBranchViewController ()<SWRevealViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *branchListTable;
@property (weak, nonatomic) IBOutlet UILabel *ButtonBranchName;
@property (weak, nonatomic) IBOutlet UIButton *ButtonBranchDirection;

@property (nonatomic) Boolean boolImageOrURL;
@property (retain, nonatomic)NSArray *BranchURLs;
@end
NSMutableArray* subArrSnippetImageName;
@implementation SubBranchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _boolImageOrURL = false;
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSString* BranchName = app.strBranchName;
    NSString*BranchDirection = app.BranchDirection;
    _ButtonBranchName.text = BranchName;
    [_ButtonBranchName setTextColor:app.Branch_Color];
    [_ButtonBranchDirection setTitle:BranchDirection forState:UIControlStateNormal] ;
    [_ButtonBranchDirection setTitleColor:app.Branch_Color forState:UIControlStateNormal];
    int numberOfBranch = app.Branch_Image_Number;
    int subBranchIndex = app.SubBranchIndex + 1;
    subArrSnippetImageName = [[NSMutableArray alloc]init];
    for (int index = 1; index<numberOfBranch+1; index++) {
        NSString* tempString = [NSString stringWithFormat:@"%@_%@%d_%d.jpg",BranchDirection,BranchName,subBranchIndex,index];
        [subArrSnippetImageName addObject:tempString];
    }
    NSDictionary *tempDic = app.dicAllURLs;
    _BranchURLs = (NSArray*)[tempDic objectForKey:[NSString stringWithFormat:@"%@_%@", BranchDirection, BranchName]];

}

//Add Sound on click
-(void)playSound:fileName{
    
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//show the side bar
- (IBAction)goSideMenu:(UIButton *)sender {
    [self.navigationController.revealViewController rightRevealToggle:nil];
    [self playSound:@"forwardButton"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _BranchURLs.count;
}
- (IBAction)BackToTotallMenu:(UIButton *)sender {
    [self playSound:@"backButton"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    if (_boolImageOrURL) {

//        static NSString *identifier = @"SubBranchCell1";
//        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//        UIImageView *imgBranch = (UIImageView *)[cell viewWithTag:101];
//        [imgBranch setImage:[UIImage imageNamed:[subArrSnippetImageName objectAtIndex:indexPath.row]]];
    }
    else{
        static NSString *identifier = @"SubBranchCell2";
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        UITextView *urlBranch = (UITextView *)[cell viewWithTag:102];
        urlBranch.text = [self.BranchURLs objectAtIndex:indexPath.row];
    }
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self playSound:@"m3"];
    AppDelegate *app= [UIApplication sharedApplication].delegate;
    app.SubBranchWebIndex = (int)indexPath.row ;
         SubBranchWebViewController *DirectionBranchWebScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SubBranchWebViewController"];
    [self.navigationController pushViewController:DirectionBranchWebScreen animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
}


@end
