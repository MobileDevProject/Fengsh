//
//  SelectPhotoTableViewController.m
//  FengShui
//
//  Created by AK on 8/13/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//
#import "AppDelegate.h"
#import "SelectPhotoTableViewController.h"
#import "SWRevealViewController.h"
@interface SelectPhotoTableViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *PhotosListTable;
@end
NSMutableArray* PhotoArrSnippetImageName;
@implementation SelectPhotoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    int numberOfPhotos = app.NumberOfPhotos;
    PhotoArrSnippetImageName = [[NSMutableArray alloc]init];
    for (int index = 1; index<numberOfPhotos+1; index++) {
        NSString* tempString = [NSString stringWithFormat:@"person%d.jpg", index];
        [PhotoArrSnippetImageName addObject:tempString];
    }
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
- (IBAction)goBack:(UIButton *)sender {
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
//show the side bar
- (IBAction)goSideMenu:(UIButton *)sender {
    [self.navigationController.revealViewController rightRevealToggle:nil];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return PhotoArrSnippetImageName.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    
        static NSString *identifier = @"PhotoCell";
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        UIImageView *imgBranch = (UIImageView *)[cell viewWithTag:101];
        [imgBranch setImage:[UIImage imageNamed:[PhotoArrSnippetImageName objectAtIndex:indexPath.row]]];
 
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AppDelegate *app= [UIApplication sharedApplication].delegate;
    NSString *strSelectedPhoto = [NSString stringWithFormat: @"person%d.jpg", (int)indexPath.row+1];
    app.strSelectedPhoto = strSelectedPhoto;
    [[NSUserDefaults standardUserDefaults] setObject:strSelectedPhoto forKey:@"userPhoto"];
    //app.SubBranchWebIndex = (int)indexPath.row + 1;
    [self.navigationController popViewControllerAnimated:YES];

    
}


@end
