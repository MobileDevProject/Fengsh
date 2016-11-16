//
//  CommentsViewController.m
//  FengShui
//
//  Created by Theodor Hedin on 10/31/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//
@import Firebase;
#import "SWRevealViewController.h"
#import "commentContentsViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "GCPlaceholderTextView.h"
#import "CommentsViewController.h"
#import "Request.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CommentsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate>
{
    NSMutableArray* subArrSnippetImageName;
    AppDelegate *app;
    NSDictionary* dicComments;
    NSMutableArray *arrCommentsDic;
}
@property (weak, nonatomic) IBOutlet UICollectionView *branchListTable;
@property (retain, nonatomic)NSArray *BranchURLs;
@property (nonatomic) CGFloat lastContentOffset;
@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpaceOfTopBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;



@end

@implementation CommentsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    app = [UIApplication sharedApplication].delegate;
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
    //test part
    [self loadComments];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
    [self.view addGestureRecognizer:panGesture];
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
    
    return arrCommentsDic.count;
}
- (IBAction)BackToTotallMenu:(UIButton *)sender {
    [self playSound:@"backButton"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    
    NSDictionary *currentComment = [arrCommentsDic objectAtIndex:indexPath.row];
    static NSString *identifier = @"SubBranchCell2";
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    FIRDatabaseReference *ref = [[[Request dataref] child:@"users"]child:[currentComment  objectForKey:@"userid"]];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            dispatch_async(dispatch_get_main_queue(), ^{

    //user photo
    UIImageView *userPhoto = (UIImageView*)[cell viewWithTag:101];
    //user name
    UILabel *userName = (UILabel*)[cell viewWithTag:102];
    // comment content
    UILabel *commentContent = (UILabel *)[cell viewWithTag:103];
    commentContent.text = [currentComment objectForKey:@"contents"];
    //time ago from posted
    UILabel *agoTime = (UILabel*)[cell viewWithTag:104];
    agoTime.text = [self getUTCFormateDate:[currentComment objectForKey:@"date"]];
    
    
            userName.text = [snapshot.value objectForKey:@"name"];
            //user photo
            [self.view layoutIfNeeded];
            userPhoto.layer.cornerRadius = userPhoto.frame.size.height/2;
            userPhoto.clipsToBounds = YES;
            userPhoto.layer.borderWidth = 3.0f;
            userPhoto.layer.borderColor = [UIColor colorWithRed:87.0f/255.0f green:71.0f/255.0f blue:47.0f/255.0f alpha:1].CGColor;
            [userPhoto sd_setImageWithURL:[NSURL URLWithString:[snapshot.value  objectForKey:@"photourl"]]
                         placeholderImage:[UIImage imageNamed:@"person0.jpg"]];
                
                
        });
     }];
    });
    
    return cell;
    
    
}
-(NSString *)getUTCFormateDate:(NSString *)registerDate
{
    NSString *agoTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *nowGMTDate = [dateFormatter dateFromString:timeStamp];
    NSDate *registeredDate = [dateFormatter dateFromString:registerDate];
    NSTimeInterval timeInterval = [nowGMTDate timeIntervalSinceDate:registeredDate];
    int numberOfDays = round(timeInterval / 86400);
    int numberOfHours = round(timeInterval / 3600);
    int numberOfMinutes = round(timeInterval / 60);
    int numberOfSeconds = round(timeInterval);
    int numberOfMonths = round(timeInterval / (86400 * 30));
    int numberOfYears = round(timeInterval / (86400 * 30 * 365));
    if (numberOfYears>0) {
        agoTime = [NSString stringWithFormat:@"%dy", numberOfYears];
    }else if (numberOfMonths>0){
        agoTime = [NSString stringWithFormat:@"%dM", numberOfMonths];
    }else if (numberOfDays>0){
        agoTime = [NSString stringWithFormat:@"%dd", numberOfDays];
    }else if (numberOfHours>0){
        agoTime = [NSString stringWithFormat:@"%dh", numberOfHours];
    }else if (numberOfMinutes>0){
        agoTime = [NSString stringWithFormat:@"%dm", numberOfMinutes];
    }else if (numberOfSeconds>0){
        agoTime = [NSString stringWithFormat:@"%ds", numberOfSeconds];
    }
    return agoTime;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *currentComment = [arrCommentsDic objectAtIndex:indexPath.row];
    FIRDatabaseReference *ref = [[[Request dataref] child:@"users"]child:[currentComment  objectForKey:@"userid"]];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
    NSString *name = [snapshot.value objectForKey:@"name"];
                NSURL *photoURL = [NSURL URLWithString:[snapshot.value  objectForKey:@"photourl"]];
    NSDictionary *currentComment = [arrCommentsDic objectAtIndex:indexPath.row];
    NSString* comment = [currentComment objectForKey:@"contents"] ? [currentComment objectForKey:@"contents"] : @" ";
    app.commentDic = @{
                       @"name":name,
                       @"photoURL":photoURL,
                       @"comment":comment
                       };

    [self playSound:@"m3"];
    app.SubBranchWebIndex = (int)indexPath.row ;
    
    commentContentsViewController *CommentContentsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"commentContentsViewController"];
    [self.navigationController pushViewController:CommentContentsViewController animated:YES];
            });
        }];
        });
    
}
-(void)collectionView:(UICollectionView*)collectionView willDisplayCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if ([indexPath row]==((NSIndexPath*)[[collectionView indexPathsForVisibleItems] lastObject]).row) {
        
        [self goToLastCell];
        [self.view setUserInteractionEnabled:YES];
    }
}
-(void)loadComments{
    [self.view setUserInteractionEnabled:NO];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        arrCommentsDic = [[NSMutableArray alloc]init];
        //get all comments
        NSString* commentPath = [NSString stringWithFormat:@"%@_%@_%d", app.strBranchName,app.BranchDirection, app.SubBranchIndex];
        FIRDatabaseReference* ref = [[[[FIRDatabase database] reference] child:@"comments"]child:commentPath];
        [ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            [self.view layoutIfNeeded];
            if (snapshot.exists) {
                NSDictionary*dic = snapshot.value;
                NSArray *keys;
                
                    keys = dic.allKeys;
                    for (NSString *tempKey in keys) {
                        [arrCommentsDic addObject:[dic objectForKey:tempKey]];
                    }
                
                    NSSortDescriptor* descriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
                    arrCommentsDic = [[NSMutableArray alloc]initWithArray:[arrCommentsDic sortedArrayUsingDescriptors:@[descriptor]]];
                [self.branchListTable reloadData];
            }
            
        }];
    

    });
}
-(void)goToLastCell{
    [self.view layoutIfNeeded];
    NSInteger section = 0;
    NSInteger item = arrCommentsDic.count - 1;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
    [self.branchListTable scrollToItemAtIndexPath:lastIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    
}

- (void)keyboardWasShown:(NSNotification *)aNotification {
    NSDictionary *info = aNotification.userInfo;
    CGSize kbSize = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.bottomSpace.constant = kbSize.height;
    [self goToLastCell];
}
- (void)keyboardBeHidden:(NSNotification *)aNotification {
    NSDictionary *info = aNotification.userInfo;
    CGSize kbSize = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.bottomSpace.constant = 0;
    [self goToLastCell];
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, 60);
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

- (void)panRecognized:(UIPanGestureRecognizer *)rec
{
    
    
    CGPoint point = [rec locationInView:self.view];
    
    if (rec.state == UIGestureRecognizerStateEnded)
    {
        // user dragged towards the right
        if (point.y>self.lastContentOffset) {
            [self.textView resignFirstResponder];
        }
    }
    else if(rec.state == UIGestureRecognizerStateBegan)
    {
        // user dragged towards the left
        self.lastContentOffset = point.y;
    }
    
}
- (IBAction)writeComment:(UIButton *)sender {

        //post comment
    if (![self.textView.text isEqualToString:@""]) {
        

        NSString* commentPath = [NSString stringWithFormat:@"%@_%@_%d", app.strBranchName,app.BranchDirection, app.SubBranchIndex];
        FIRDatabaseReference* ref = [[[[[FIRDatabase database] reference] child:@"comments"]child:commentPath]child:[NSString stringWithFormat:@"%@%@",app.user.userId,app.user.numberOfComments]];
    //register date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDictionary* commentDict  = @{
                                   @"date":timeStamp,
                                   @"userid":app.user.userId,
                                   @"contents":self.textView.text
                                   };
    //write
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    [ref updateChildValues:commentDict withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        dispatch_async(dispatch_get_main_queue(), ^{
        [NSString stringWithFormat:@"%d", [app.user.numberOfComments intValue] + 1];
        FIRDatabaseReference *userNumberOfComments = [[[[FIRDatabase database] reference] child:@"users"]child:app.user.userId];
            [userNumberOfComments updateChildValues:@{@"numberofcomments":[NSString stringWithFormat:@"%d", ([app.user.numberOfComments intValue] + 1)]}];
        [arrCommentsDic addObject:commentDict];
        [self.branchListTable reloadData];
            
            //go to last cell
            NSInteger section = 0;
            
            NSInteger item = [self collectionView:self.branchListTable numberOfItemsInSection:section] - 1;
            if (item>=0) {
                NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
                [self.branchListTable scrollToItemAtIndexPath:lastIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
            }
            
            self.textView.text= @"";
            //set update time
            [Request updateTime:[NSString stringWithFormat:@"%@_%@",app.BranchDirection, app.strBranchName] updatedTime:timeStamp];
        });
    }];
    });
    }
}
-(void)viewWillAppear:(BOOL)animated{
    self.textView.text= @"";

}

-(void)viewWillDisappear:(BOOL)animated{
    [self.textView resignFirstResponder];
}

@end
