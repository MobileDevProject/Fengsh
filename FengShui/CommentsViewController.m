//
//  CommentsViewController.m
//  FengShui
//
//  Created by Theodor Hedin on 10/31/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//
@import Firebase;
#import "SWRevealViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "GCPlaceholderTextView.h"
#import "CommentsViewController.h"

@interface CommentsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSMutableArray* subArrSnippetImageName;
}
@property (weak, nonatomic) IBOutlet UICollectionView *branchListTable;
@property (retain, nonatomic)NSArray *BranchURLs;
@property (nonatomic) CGFloat lastContentOffset;
@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *textView;

@end

@implementation CommentsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSString* BranchName = app.strBranchName;
    NSString*BranchDirection = app.BranchDirection;
    int numberOfBranch = app.Branch_Image_Number;
    int subBranchIndex = app.SubBranchIndex + 1;
    subArrSnippetImageName = [[NSMutableArray alloc]init];
    for (int index = 1; index<numberOfBranch+1; index++) {
        NSString* tempString = [NSString stringWithFormat:@"%@_%@%d_%d.jpg",BranchDirection,BranchName,subBranchIndex,index];
        [subArrSnippetImageName addObject:tempString];
    }
    NSDictionary *tempDic = app.dicAllURLs;
    _BranchURLs = (NSArray*)[tempDic objectForKey:[NSString stringWithFormat:@"%@_%@", BranchDirection, BranchName]];
    
    self.textView.placeholderColor = [UIColor lightGrayColor];
    self.textView.placeholder = NSLocalizedString(@"Add a comment...",);
    
    //lift up
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
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
    static NSString *identifier = @"SubBranchCell2";
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //user name
    UILabel *userName = (UILabel*)[cell viewWithTag:102];
    //user photo
    UIImageView *userPhoto = (UIImageView*)[cell viewWithTag:101];
    [self.view layoutIfNeeded];
    userPhoto.layer.cornerRadius = userPhoto.frame.size.height/2;
    userPhoto.clipsToBounds = YES;
    userPhoto.layer.borderWidth = 3.0f;
    userPhoto.layer.borderColor = [UIColor colorWithRed:87.0f/255.0f green:71.0f/255.0f blue:47.0f/255.0f alpha:1].CGColor;
    // comment content
    UILabel *commentContent = (UILabel *)[cell viewWithTag:103];
    commentContent.text = [self.BranchURLs objectAtIndex:indexPath.row];
    //time ago from posted
    UILabel *agoTime = (UILabel*)[cell viewWithTag:104];
    
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self playSound:@"m3"];
//    AppDelegate *app= [UIApplication sharedApplication].delegate;
//    app.SubBranchWebIndex = (int)indexPath.row ;
//    SubBranchWebViewController *DirectionBranchWebScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SubBranchWebViewController"];
//    [self.navigationController pushViewController:DirectionBranchWebScreen animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
}
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


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.lastContentOffset = scrollView.contentOffset.y;
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if ([scrollView isKindOfClass:[UICollectionView class]]){
        if (self.lastContentOffset < scrollView.contentOffset.y){
            
        //NSLog(@"Scrolling Up");
        }
        else if (self.lastContentOffset > scrollView.contentOffset.y)
        {
        //NSLog(@"Scrolling Down");
            [self.textView resignFirstResponder];
        }
}

}
@end
