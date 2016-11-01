//
//  AllDirectionBranchTableViewController.m
//  FengShui
//
//  Created by Theodor Swedenborg on 08/08/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//
@import Firebase;
#import "AppDelegate.h"
#import "AllDirectionBranchTableViewController.h"
#import "SubBranchViewController.h"
#import "SubBranchWebViewController.h"
#import "CommentsViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SWRevealViewController.h"
@interface AllDirectionBranchTableViewController ()<SWRevealViewControllerDelegate>
{
    NSMutableArray* arrSnippetImageName;
    AppDelegate *app;
}

@property (weak, nonatomic) IBOutlet UICollectionView *branchListTable;
@property (weak, nonatomic) IBOutlet UILabel *ButtonBranchName;
@property (weak, nonatomic) IBOutlet UIButton *dropMenu;
@property (weak, nonatomic) IBOutlet UIImageView *imgSnippetBranch;
@property (weak, nonatomic) IBOutlet UIView *viewNavigationBarBack;

@property (retain, nonatomic) FIRDatabaseReference *ref;
@property (nonatomic) Boolean boolImageOrURL;
@property (nonatomic,retain) NSString* BranchDirection;
@property (nonatomic,retain) NSString* BranchName;
@end

@implementation AllDirectionBranchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _boolImageOrURL = true;
    app = [UIApplication sharedApplication].delegate;
    _BranchName = app.strBranchName;
    _BranchDirection = app.BranchDirection;
    _ButtonBranchName.text = _BranchName;
    int numberOfBranch = app.Branch_Count;
    //[_lmgSnippetBranch setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@Back.png"], _BranchDirection]];
    [self.imgSnippetBranch setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_%@Back.png", _BranchDirection, _BranchName]]];
    [self.viewNavigationBarBack setBackgroundColor:app.Branch_Color];
    
//    self.ref = [[FIRDatabase database] reference];
//
//    [[[_ref child:@"CompassURLs"] child:_BranchDirection] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *_Nonnull snapshot){
//        //get user value
//        NSString *user = snapshot.value[@"firstName"];
//        NSString *usermail = snapshot.value[@"email"];
//        NSString *phoneNumber = snapshot.value[@"phoneNumber"];
//        NSString *surName = snapshot.value[@"surName"];
//        NSString *email = snapshot.value[@"email"];
//    } withCancelBlock:^(NSError *_Nonnull error){
//        NSLog(@"%@", error.localizedDescription);
//        
//    }];
    
    arrSnippetImageName = [[NSMutableArray alloc]init];
    for (int index = 1; index<numberOfBranch+1; index++) {
        NSString* tempString = [NSString stringWithFormat:@"%@_%@%d.jpg",_BranchDirection,_BranchName,index];
        [arrSnippetImageName addObject:tempString];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return arrSnippetImageName.count;
}
- (IBAction)BackToTotallMenu:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self playSound:@"backButton"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //AppDelegate *app = [UIApplication sharedApplication].delegate;
    UICollectionViewCell *cell;
    if (_boolImageOrURL) {
        
        static NSString *identifier = @"BranchCell1";
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        UIImageView *imgBranch = (UIImageView *)[cell viewWithTag:101];
        [imgBranch setImage:[UIImage imageNamed:[arrSnippetImageName objectAtIndex:indexPath.row]]];
        UILabel *branch_direction = (UILabel*)[cell viewWithTag:102];
        branch_direction.text = [NSString stringWithFormat:@"%@ - %@",_BranchName , _BranchDirection];
        
    }
    else{
//        static NSString *identifier = @"BranchCell2";
//        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//        UIImageView *imgBranch = (UIImageView *)[cell viewWithTag:103];
//        UILabel *lblURL = (UILabel*)[cell viewWithTag:102];
//        NSDictionary *tempDic = app.dicAllURLs;
//
//        NSArray *BranchURLs = (NSArray*)[tempDic objectForKey:[NSString stringWithFormat:@"%@_%@", _BranchDirection, _BranchName]];
//        lblURL.text = [BranchURLs objectAtIndex:indexPath.row];
//        [imgBranch setImage:[UIImage imageNamed:[arrSnippetImageName objectAtIndex:indexPath.row]]];
    }
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self playSound:@"m3"];
    app.SubBranchIndex = (int)indexPath.row;
    //app.SubBranchWebIndex = (int)indexPath.row + 1;
    if (_boolImageOrURL) {
        SubBranchViewController *DirectionBranchTableScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SubBranchViewController"];
    [self.navigationController pushViewController:DirectionBranchTableScreen animated:YES];
    }
    else{
//        SubBranchWebViewController *DirectionBranchWebScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SubBranchWebViewController"];
//        [self presentViewController:DirectionBranchWebScreen animated:YES completion:nil];
    }


}
- (IBAction)goComment:(UIButton *)sender {
    
    CGRect buttonFrame = [sender convertRect:sender.bounds toView:self.branchListTable];
    int number  =  (int)[self.branchListTable indexPathForItemAtPoint:buttonFrame.origin].row;
    app.SubBranchIndex = number;
    CommentsViewController *DirectionBranchTableScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CommentsViewController"];
    [self.navigationController pushViewController:DirectionBranchTableScreen animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
}

@end


