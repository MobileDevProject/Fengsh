//
//  totalMenuViewController.m
//  FengShui
//
//  Created by Theodor Swedenborg on 06/08/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//
@import Firebase;
#import "Request.h"
#import "AllDirectionBranchTableViewController.h"
#import "AppDelegate.h"
#import "totalMenuViewController.h"
#import "GeoPointCompass.h"
#import <CoreLocation/CoreLocation.h>
#import "SWRevealViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface totalMenuViewController ()<CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{

    CLLocationManager* locationManager;
    GeoPointCompass *geoPointCompass;
    
    CLLocationDirection currentDir;
    BOOL checkphoto;

}


@property (weak, nonatomic) IBOutlet UIButton *btnNorthEastSmallEarth;
@property (weak, nonatomic) IBOutlet UIButton *btnNorthEastBeige;
@property (weak, nonatomic) IBOutlet UIButton *btnNorthEastEducation;

@property (weak, nonatomic) IBOutlet UIButton *btnSouthEastWealth;
@property (weak, nonatomic) IBOutlet UIButton *SouthEastColor;
@property (weak, nonatomic) IBOutlet UIButton *SouthEastSmallWood;


@property (weak, nonatomic) IBOutlet UIButton *SouthWestMarriage;
@property (weak, nonatomic) IBOutlet UIButton *SouthWestColor;
@property (weak, nonatomic) IBOutlet UIButton *SouthWestBigEarth;

@property (weak, nonatomic) IBOutlet UIButton *NorthWestMentors;
@property (weak, nonatomic) IBOutlet UIButton *NorthWestColor;
@property (weak, nonatomic) IBOutlet UIButton *NorthWestBigMetal;


@property (weak, nonatomic) IBOutlet UIView *MenuView;
@property (weak, nonatomic) IBOutlet UIButton *btnPersonPhoto;
@property (strong, nonatomic) IBOutlet UIImageView *imagePhoto;




@property(nonatomic,retain) CLLocationManager *locManager;
//North
@property (nonatomic,retain) NSString* North_Career;
@property (nonatomic) int North_Career_Number_Branch;
@property (nonatomic) int North_Career_Number_Branch_Image;
@property (nonatomic,retain) NSString* North_Water;
@property (nonatomic) int North_Water_Number_Branch;
@property (nonatomic) int North_Water_Number_Branch_Image;
@property (nonatomic,retain) NSString* North_Color;
@property (nonatomic) int North_Color_Number_Branch;
@property (nonatomic) int North_Color_Number_Branch_Image;

@property (nonatomic,retain) UIColor* North_C;
@property (nonatomic,retain) NSString* North_Direction;

//South
@property (nonatomic,retain) NSString* South_Recognition;
@property (nonatomic) int South_Recognition_Number_Branch;
@property (nonatomic) int South_Recognition_Number_Branch_Image;
@property (nonatomic,retain) NSString* South_Fire;
@property (nonatomic) int South_Fire_Number_Branch;
@property (nonatomic) int South_Fire_Number_Branch_Image;
@property (nonatomic,retain) NSString* South_Color;
@property (nonatomic) int South_Color_Number_Branch;
@property (nonatomic) int South_Color_Number_Branch_Image;

@property (nonatomic,retain) UIColor* South_C;
@property (nonatomic,retain) NSString* South_Direction;

//North East
@property (nonatomic,retain) NSString* NorthEast_Education;
@property (nonatomic) int NorthEast_Education_Number_Branch;
@property (nonatomic) int NorthEast_Education_Number_Branch_Image;
@property (nonatomic,retain) NSString* NorthEast_SmallEarth;
@property (nonatomic) int NorthEast_SmallEarth_Number_Branch;
@property (nonatomic) int NorthEast_SmallEarth_Number_Branch_Image;
@property (nonatomic,retain) NSString* NorthEast_Color;
@property (nonatomic) int NorthEast_Color_Number_Branch;
@property (nonatomic) int NorthEast_Color_Number_Branch_Image;

@property (nonatomic,retain) UIColor* NorthEast_C;
@property (nonatomic,retain) NSString* NorthEast_Direction;

//East
@property (nonatomic,retain) NSString* East_Family;
@property (nonatomic) int East_Family_Number_Branch;
@property (nonatomic) int East_Family_Number_Branch_Image;
@property (nonatomic,retain) NSString* East_BigWood;
@property (nonatomic) int East_BigWood_Number_Branch;
@property (nonatomic) int East_BigWood_Number_Branch_Image;
@property (nonatomic,retain) NSString* East_Color;
@property (nonatomic) int East_Color_Number_Branch;
@property (nonatomic) int East_Color_Number_Branch_Image;

@property (nonatomic,retain) UIColor* East_C;
@property (nonatomic,retain) NSString* East_Direction;

//South East
@property (nonatomic,retain) NSString* SouthEast_Wealth;
@property (nonatomic) int SouthEast_Wealth_Number_Branch;
@property (nonatomic) int SouthEast_Wealth_Number_Branch_Image;
@property (nonatomic,retain) NSString* SouthEast_SmallWood;
@property (nonatomic) int SouthEast_SmallWood_Number_Branch;
@property (nonatomic) int SouthEast_SmallWood_Number_Branch_Image;
@property (nonatomic,retain) NSString* SouthEast_Color;
@property (nonatomic) int SouthEast_Color_Number_Branch;
@property (nonatomic) int SouthEast_Color_Number_Branch_Image;

@property (nonatomic,retain) UIColor* SouthEast_C;
@property (nonatomic,retain) NSString* SouthEast_Direction;

//South West
@property (nonatomic,retain) NSString* SouthWest_Marriage;
@property (nonatomic) int SouthWest_Marriage_Number_Branch;
@property (nonatomic) int SouthWest_Marriage_Number_Branch_Image;
@property (nonatomic,retain) NSString* SouthWest_BigEarth;
@property (nonatomic) int SouthWest_BigEarth_Number_Branch;
@property (nonatomic) int SouthWest_BigEarth_Number_Branch_Image;
@property (nonatomic,retain) NSString* SouthWest_Color;
@property (nonatomic) int SouthWest_Color_Number_Branch;
@property (nonatomic) int SouthWest_Color_Number_Branch_Image;

@property (nonatomic,retain) UIColor* SouthWest_C;
@property (nonatomic,retain) NSString* SouthWest_Direction;

//West
@property (nonatomic,retain) NSString* West_Dependance;
@property (nonatomic) int West_Dependance_Number_Branch;
@property (nonatomic) int West_Dependance_Number_Branch_Image;
@property (nonatomic,retain) NSString* West_SmallMetal;
@property (nonatomic) int West_SmallMetal_Number_Branch;
@property (nonatomic) int West_SmallMetal_Number_Branch_Image;
@property (nonatomic,retain) NSString* West_Color;
@property (nonatomic) int West_Color_Number_Branch;
@property (nonatomic) int West_Color_Number_Branch_Image;

@property (nonatomic,retain) UIColor* West_C;
@property (nonatomic,retain) NSString* West_Direction;

//North West
@property (nonatomic,retain) NSString* NorthWest_Mentors;
@property (nonatomic) int NorthWest_Mentors_Number_Branch;
@property (nonatomic) int NorthWest_Mentors_Number_Branch_Image;
@property (nonatomic,retain) NSString* NorthWest_BigMetal;
@property (nonatomic) int NorthWest_BigMetal_Number_Branch;
@property (nonatomic) int NorthWest_BigMetal_Number_Branch_Image;
@property (nonatomic,retain) NSString* NorthWest_Color;
@property (nonatomic) int NorthWest_Color_Number_Branch;
@property (nonatomic) int NorthWest_Color_Number_Branch_Image;

@property (nonatomic,retain) UIColor* NorthWest_C;
@property (nonatomic,retain) NSString* NorthWest_Direction;
@end

@implementation totalMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    geoPointCompass = [[GeoPointCompass alloc] init];
    
    // Add the image to be used as the compass on the GUI
    [geoPointCompass setRotateView:_MenuView];
    //permission to use camera
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized)
    {
        
    }
    else if(authStatus == AVAuthorizationStatusNotDetermined)
    {
        NSLog(@"%@", @"Camera access not determined. Ask for permission.");
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted)
         {
             if(granted)
             {
                 NSLog(@"Granted access to %@", AVMediaTypeVideo);
                 
             }
             else
             {
                 NSLog(@"Not granted access to %@", AVMediaTypeVideo);
                 
             }
         }];
    }
    
    
    
    
//        ref = [[FIRDatabase database] reference];
//    
//        [[[[[ref child:@"CompassURLs"] child:@"North"] child:@"Career"] child:@"Career1"]observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *_Nonnull snapshot){
//            //get user value
//            NSMutableArray *NorthCareer1URLAs = [[NSMutableArray alloc]init];
//            for (int index = 0; snapshot.childrenCount<index; index++) {
//                [NorthCareer1URLAs addObject:snapshot.value[[NSString stringWithFormat:@"Career%d",index]]];
//            }
//            NSString *user = snapshot.value[@"URL1"];
//            NSString *usermail = snapshot.value[@"URL2"];
//            NSString *phoneNumber = snapshot.value[@"URL3"];
//            NSString *surName = snapshot.value[@"URL4"];
//            NSString *email = snapshot.value[@"URL4"];
//        } withCancelBlock:^(NSError *_Nonnull error){
//            NSLog(@"%@", error.localizedDescription);
//            
//        }];

    [self.view layoutIfNeeded];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    self.imagePhoto.layer.cornerRadius = self.imagePhoto.frame.size.height/2;
    self.imagePhoto.clipsToBounds = YES;
    self.imagePhoto.layer.borderWidth = 3.0f;
    self.imagePhoto.layer.borderColor = [UIColor colorWithRed:87.0f/255.0f green:71.0f/255.0f blue:47.0f/255.0f alpha:1].CGColor;
    //North
    _North_C = app.North_C;
    _North_Career = app.North_Career;
    _North_Career_Number_Branch = app.North_Career_Number_Branch;
    _North_Career_Number_Branch_Image = app.North_Career_Number_Branch_Image;
    _North_Water = app.North_Water;
    _North_Water_Number_Branch = app.North_Water_Number_Branch;
    _North_Water_Number_Branch_Image = app.North_Water_Number_Branch_Image;
    _North_Color = app.North_Color;
    _North_Color_Number_Branch = app.North_Color_Number_Branch;
    _North_Color_Number_Branch_Image = app.North_Color_Number_Branch_Image;
    _North_Direction = app.North_Direction;
    
    //South
    _South_C = app.South_C;
    _South_Recognition = app.South_Recognition;
    _South_Recognition_Number_Branch = app.South_Recognition_Number_Branch;
    _South_Recognition_Number_Branch_Image = app.South_Recognition_Number_Branch_Image;
    _South_Fire = app.South_Fire;
    _South_Fire_Number_Branch = app.South_Fire_Number_Branch;
    _South_Fire_Number_Branch_Image = app.South_Fire_Number_Branch_Image;
    _South_Color = app.South_Color;
    _South_Color_Number_Branch = app.South_Color_Number_Branch;
    _South_Color_Number_Branch_Image = app.South_Color_Number_Branch_Image;
    _South_Direction = app.South_Direction;
    
    
    //East
    _East_C = app.East_C;
    _East_Family = app.East_Family;
    _East_Family_Number_Branch = app.East_Family_Number_Branch;
    _East_Family_Number_Branch_Image = app.East_Family_Number_Branch_Image;
    _East_BigWood = app.East_BigWood;
    _East_BigWood_Number_Branch = app.East_BigWood_Number_Branch;
    _East_BigWood_Number_Branch_Image = app.East_BigWood_Number_Branch_Image;
    _East_Color = app.East_Color;
    _East_Color_Number_Branch = app.East_Color_Number_Branch;
    _East_Color_Number_Branch_Image = app.East_Color_Number_Branch_Image;
    _East_Direction = app.East_Direction;
    
    //West
    _West_C = app.West_C;
    _West_Dependance = app.West_Dependance;
    _West_Dependance_Number_Branch = app.West_Dependance_Number_Branch;
    _West_Dependance_Number_Branch_Image = app.West_Dependance_Number_Branch_Image;
    _West_SmallMetal = app.West_SmallMetal;
    _West_SmallMetal_Number_Branch = app.West_SmallMetal_Number_Branch;
    _West_SmallMetal_Number_Branch_Image = app.West_SmallMetal_Number_Branch_Image;
    _West_Color = app.West_Color;
    _West_Color_Number_Branch = app.West_Color_Number_Branch;
    _West_Color_Number_Branch_Image = app.West_Color_Number_Branch_Image;
    _West_Direction = app.West_Direction;

    //North East
    _NorthEast_C = app.NorthEast_C;
    _NorthEast_Education_Number_Branch = app.NorthEast_Education_Number_Branch;
    _NorthEast_Education_Number_Branch_Image = app.NorthEast_Education_Number_Branch_Image;
    _NorthEast_Education = app.NorthEast_Education;
    _NorthEast_SmallEarth = app.NorthEast_SmallEarth;
    _NorthEast_SmallEarth_Number_Branch = app.NorthEast_SmallEarth_Number_Branch;
    _NorthEast_SmallEarth_Number_Branch_Image = app.NorthEast_SmallEarth_Number_Branch_Image;
    _NorthEast_Color = app.NorthEast_Color;
    _NorthEast_Color_Number_Branch = app.NorthEast_Color_Number_Branch;
    _NorthEast_Color_Number_Branch_Image = app.NorthEast_Color_Number_Branch_Image;
    _NorthEast_Direction = app.NorthEast_Direction;
    

    //South East
    _SouthEast_C = app.SouthEast_C;
    _SouthEast_Wealth_Number_Branch = app.SouthEast_Wealth_Number_Branch;
    _SouthEast_Wealth_Number_Branch_Image = app.SouthEast_Wealth_Number_Branch_Image;
    _SouthEast_Wealth = app.SouthEast_Wealth;
    _SouthEast_SmallWood = app.SouthEast_SmallWood;
    _SouthEast_SmallWood_Number_Branch = app.SouthEast_SmallWood_Number_Branch;
    _SouthEast_SmallWood_Number_Branch_Image = app.SouthEast_SmallWood_Number_Branch_Image;
    _SouthEast_Color = app.SouthEast_Color;
    _SouthEast_Color_Number_Branch = app.SouthEast_Color_Number_Branch;
    _SouthEast_Color_Number_Branch_Image = app.SouthEast_Color_Number_Branch_Image;
    _SouthEast_Direction = app.SouthEast_Direction;
    
    //South West
    _SouthWest_C = app.SouthWest_C;
    _SouthWest_Marriage = app.SouthWest_Marriage;
    _SouthWest_Marriage_Number_Branch = app.SouthWest_Marriage_Number_Branch;
    _SouthWest_Marriage_Number_Branch_Image = app.SouthWest_Marriage_Number_Branch_Image;
    _SouthWest_BigEarth = app.SouthWest_BigEarth;
    _SouthWest_BigEarth_Number_Branch = app.SouthWest_BigEarth_Number_Branch;
    _SouthWest_BigEarth_Number_Branch_Image = app.SouthWest_BigEarth_Number_Branch_Image;
    _SouthWest_Color = app.SouthWest_Color;
    _SouthWest_Color_Number_Branch = app.SouthWest_Color_Number_Branch;
    _SouthWest_Color_Number_Branch_Image = app.SouthWest_Color_Number_Branch_Image;
    _SouthWest_Direction = app.SouthWest_Direction;
    
    //North West
    _NorthWest_C = app.NorthWest_C;
    _NorthWest_Mentors = app.NorthWest_Mentors;
    _NorthWest_Mentors_Number_Branch = app.NorthWest_Mentors_Number_Branch;
    _NorthWest_Mentors_Number_Branch_Image = app.NorthWest_Mentors_Number_Branch_Image;
    _NorthWest_BigMetal = app.NorthWest_BigMetal;
    _NorthWest_BigMetal_Number_Branch = app.NorthWest_BigMetal_Number_Branch;
    _NorthWest_BigMetal_Number_Branch_Image = app.NorthWest_BigMetal_Number_Branch_Image;
    _NorthWest_Color = app.NorthWest_Color;
    _NorthWest_Color_Number_Branch = app.NorthWest_Color_Number_Branch;
    _NorthWest_Color_Number_Branch_Image = app.NorthWest_Color_Number_Branch_Image;
    _NorthWest_Direction = app.NorthWest_Direction;
    

    self.btnNorthEastSmallEarth.transform = CGAffineTransformRotate(self.btnNorthEastSmallEarth.transform, M_PI/4);
    self.btnNorthEastEducation.transform = CGAffineTransformRotate(self.btnNorthEastEducation.transform, M_PI/4);
    self.btnNorthEastBeige.transform = CGAffineTransformRotate(self.btnNorthEastBeige.transform, M_PI/4);
    
    
    self.btnSouthEastWealth.transform = CGAffineTransformRotate(self.btnSouthEastWealth.transform, -M_PI/4);
    self.SouthEastColor.transform = CGAffineTransformRotate(self.SouthEastColor.transform, -M_PI/4);
    self.SouthEastSmallWood.transform = CGAffineTransformRotate(self.SouthEastSmallWood.transform, -M_PI/4);
    
    self.SouthWestMarriage.transform = CGAffineTransformRotate(self.SouthWestMarriage.transform, M_PI/4);
    self.SouthWestColor.transform = CGAffineTransformRotate(self.SouthWestColor.transform, M_PI/4);
    self.SouthWestBigEarth.transform = CGAffineTransformRotate(self.SouthWestBigEarth.transform, M_PI/4);
    
    self.NorthWestMentors.transform = CGAffineTransformRotate(self.NorthWestMentors.transform, -M_PI/4);
    self.NorthWestColor.transform = CGAffineTransformRotate(self.NorthWestColor.transform, -M_PI/4);
    self.NorthWestBigMetal.transform = CGAffineTransformRotate(self.NorthWestBigMetal.transform, -M_PI/4);
    
    //[self.btnNorthColor layer].anchorPoint = CGPointMake(50/2, 50/2);
    checkphoto = true;
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
//show the side bar
- (IBAction)goSideMenu:(UIButton *)sender {
    [self.navigationController.revealViewController rightRevealToggle:nil];
    [self playSound:@"forwardButton"];
}

- (IBAction)changeVPhoto:(UIButton *)sender {
    UIActionSheet *objViewActionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Use Gallery",@"Use Camera", nil];
    [self playSound:@"m2"];
    objViewActionSheet.tag = 100;
    [objViewActionSheet showInView:self.view ];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag == 100) {
        //btnActionSheetClicked
        
        if (buttonIndex == 0) {
//            SelectPhotoTableViewController *PhotoScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SelectPhotoTableViewController"];
//            [self.navigationController pushViewController:PhotoScreen animated:YES];
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:NULL];
            
        }else if (buttonIndex == 1) {
            //check camera
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:@"Device has no camera"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles: nil];
                
                [myAlertView show];
                
            }
            else{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:NULL];
            }

          }
        //take photo
        
    }
}

#pragma mark - Image Picker Controller delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo{
    
    [Request savePhoto:image];
    [self.imagePhoto setImage:image];
    checkphoto = false;
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
//    NSData *imageData = UIImagePNGRepresentation(image);
//    [imageData writeToFile:savedImagePath atomically:NO];
    [picker dismissModalViewControllerAnimated:YES];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

//Add Sound on click
-(void)playSound:fileName{
    
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
 
}


- (IBAction)goNorthCareer:(UIButton *)sender {

    [self goToBranchDirection:_North_Career Branch_count:_North_Career_Number_Branch Branch_ImageNumber:_North_Career_Number_Branch_Image Branch_Direction:_North_Direction Branch_Color:_North_C];
    [self playSound:@"m3"];
    
    //[highlightedImage setImage:<#(UIImage * _Nullable)#>]
}

- (IBAction)goNorthColor:(id)sender {
    [self goToBranchDirection:_North_Color Branch_count:_North_Color_Number_Branch Branch_ImageNumber:_North_Color_Number_Branch_Image Branch_Direction:_North_Direction Branch_Color:_North_C];
    [self playSound:@"m3"];
}

- (IBAction)goNorthWater:(UIButton *)sender {
        [self goToBranchDirection:_North_Water Branch_count:_North_Water_Number_Branch Branch_ImageNumber:_North_Water_Number_Branch_Image Branch_Direction:_North_Direction Branch_Color:_North_C];
    [self playSound:@"m3"];
}
- (IBAction)goSouthFire:(UIButton *)sender {
        [self goToBranchDirection:_South_Fire Branch_count:_South_Fire_Number_Branch Branch_ImageNumber:_South_Fire_Number_Branch_Image Branch_Direction:_South_Direction Branch_Color:_South_C];
    [self playSound:@"m3"];
}
- (IBAction)goSouthColor:(UIButton *)sender {
        [self goToBranchDirection:_South_Color Branch_count:_South_Color_Number_Branch Branch_ImageNumber:_South_Color_Number_Branch_Image Branch_Direction:_South_Direction Branch_Color:_South_C];
    [self playSound:@"m3"];
}
- (IBAction)goSouthRecognition:(UIButton *)sender {
        [self goToBranchDirection:_South_Recognition Branch_count:_South_Recognition_Number_Branch Branch_ImageNumber:_South_Recognition_Number_Branch_Image Branch_Direction:_South_Direction Branch_Color:_South_C];
    [self playSound:@"m3"];
}
- (IBAction)goNorthEastSmallEarth:(UIButton *)sender {
            [self goToBranchDirection:_NorthEast_SmallEarth Branch_count:_NorthEast_SmallEarth_Number_Branch Branch_ImageNumber:_NorthEast_SmallEarth_Number_Branch_Image Branch_Direction:_NorthEast_Direction Branch_Color:_NorthEast_C];
    [self playSound:@"m3"];
}
- (IBAction)goNorthEastColor:(UIButton *)sender {
            [self goToBranchDirection:_NorthEast_Color Branch_count:_NorthEast_Color_Number_Branch Branch_ImageNumber:_NorthEast_Color_Number_Branch_Image Branch_Direction:_NorthEast_Direction Branch_Color:_NorthEast_C];
    [self playSound:@"m3"];
}
- (IBAction)goNorthEastEducation:(UIButton *)sender {
            [self goToBranchDirection:_NorthEast_Education Branch_count:_NorthEast_Education_Number_Branch Branch_ImageNumber:_NorthEast_Education_Number_Branch_Image Branch_Direction:_NorthEast_Direction Branch_Color:_NorthEast_C];
    [self playSound:@"m3"];
}

- (IBAction)goEastFamily:(UIButton *)sender {
                [self goToBranchDirection:_East_Family Branch_count:_East_Family_Number_Branch Branch_ImageNumber:_East_Family_Number_Branch_Image Branch_Direction:_East_Direction Branch_Color:_East_C];
    [self playSound:@"m3"];
    
}
- (IBAction)goEastColor:(UIButton *)sender {
                [self goToBranchDirection:_East_Color Branch_count:_East_Color_Number_Branch Branch_ImageNumber:_East_Color_Number_Branch_Image Branch_Direction:_East_Direction Branch_Color:_East_C];
    [self playSound:@"m3"];
}

- (IBAction)goEastBigWood:(id)sender {
                [self goToBranchDirection:_East_BigWood Branch_count:_East_BigWood_Number_Branch Branch_ImageNumber:_East_BigWood_Number_Branch_Image Branch_Direction:_East_Direction Branch_Color:_East_C];
    [self playSound:@"m3"];
}
- (IBAction)goSouthEastWealth:(id)sender {
                [self goToBranchDirection:_SouthEast_Wealth Branch_count:_SouthEast_Wealth_Number_Branch Branch_ImageNumber:_SouthEast_Wealth_Number_Branch_Image Branch_Direction:_SouthEast_Direction Branch_Color:_SouthEast_C];
    [self playSound:@"m3"];
}

- (IBAction)goSouthEastColor:(UIButton *)sender {
                [self goToBranchDirection:_SouthEast_Color Branch_count:_SouthEast_Color_Number_Branch Branch_ImageNumber:_SouthEast_Color_Number_Branch_Image Branch_Direction:_SouthEast_Direction Branch_Color:_SouthEast_C];
    [self playSound:@"m3"];
}
- (IBAction)goSouthEastSmallWood:(UIButton *)sender {
                [self goToBranchDirection:_SouthEast_SmallWood Branch_count:_SouthEast_SmallWood_Number_Branch Branch_ImageNumber:_SouthEast_SmallWood_Number_Branch_Image Branch_Direction:_SouthEast_Direction Branch_Color:_SouthEast_C];
    [self playSound:@"m3"];
}
- (IBAction)goSouthWestMarriage:(UIButton *)sender {
                    [self goToBranchDirection:_SouthWest_Marriage Branch_count:_SouthWest_Marriage_Number_Branch Branch_ImageNumber:_SouthWest_Marriage_Number_Branch_Image Branch_Direction:_SouthWest_Direction Branch_Color:_SouthWest_C];
    [self playSound:@"m3"];
}
- (IBAction)goSouthWestColor:(UIButton *)sender {
                    [self goToBranchDirection:_SouthWest_Color Branch_count:_SouthWest_Color_Number_Branch Branch_ImageNumber:_SouthWest_Color_Number_Branch_Image Branch_Direction:_SouthWest_Direction Branch_Color:_SouthWest_C];
    [self playSound:@"m3"];
}
- (IBAction)goSouthWestBigEarth:(UIButton *)sender {
                    [self goToBranchDirection:_SouthWest_BigEarth Branch_count:_SouthWest_BigEarth_Number_Branch Branch_ImageNumber:_SouthWest_BigEarth_Number_Branch_Image Branch_Direction:_SouthWest_Direction Branch_Color:_SouthWest_C];
    [self playSound:@"m3"];
}
- (IBAction)goWestDependance:(UIButton *)sender {
                    [self goToBranchDirection:_West_Dependance Branch_count:_West_Dependance_Number_Branch Branch_ImageNumber:_West_Dependance_Number_Branch_Image Branch_Direction:_West_Direction Branch_Color:_West_C];
    [self playSound:@"m3"];
}
- (IBAction)goWestColor:(UIButton *)sender {
                    [self goToBranchDirection:_West_Color Branch_count:_West_Color_Number_Branch Branch_ImageNumber:_West_Color_Number_Branch_Image Branch_Direction:_West_Direction Branch_Color:_West_C];
    [self playSound:@"m3"];
}
- (IBAction)goWestBigMetal:(UIButton *)sender {
                    [self goToBranchDirection:_West_SmallMetal Branch_count:_West_SmallMetal_Number_Branch Branch_ImageNumber:_West_SmallMetal_Number_Branch_Image Branch_Direction:_West_Direction Branch_Color:_West_C];
    [self playSound:@"m3"];
}
- (IBAction)goNorthWestMentors:(UIButton *)sender {
                    [self goToBranchDirection:_NorthWest_Mentors Branch_count:_NorthWest_Mentors_Number_Branch Branch_ImageNumber:_NorthWest_Mentors_Number_Branch_Image Branch_Direction:_NorthWest_Direction Branch_Color:_NorthWest_C];
    [self playSound:@"m3"];
    
}
- (IBAction)goNorthWestColor:(UIButton *)sender {
                    [self goToBranchDirection:_NorthWest_Color Branch_count:_NorthWest_Color_Number_Branch Branch_ImageNumber:_NorthWest_Color_Number_Branch_Image Branch_Direction:_NorthWest_Direction Branch_Color:_NorthWest_C];
    [self playSound:@"m3"];
}
- (IBAction)goNorthWestBigMetal:(UIButton *)sender {
    [self goToBranchDirection:_NorthWest_BigMetal Branch_count:_NorthWest_BigMetal_Number_Branch Branch_ImageNumber:_NorthWest_BigMetal_Number_Branch_Image Branch_Direction:_NorthWest_Direction Branch_Color:_NorthWest_C];
    [self playSound:@"m3"];
}

-(void)goToBranchDirection:(NSString*)BranchName Branch_count:(int)branchCount Branch_ImageNumber:(int)BranchImageNumber Branch_Direction:(NSString*)Branch_Direction Branch_Color:(UIColor*)Branch_Color{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.strBranchName = BranchName;
    app.Branch_Count = branchCount;
    app.Branch_Image_Number = BranchImageNumber;
    app.BranchDirection = Branch_Direction;
    app.Branch_Color = Branch_Color;
    AllDirectionBranchTableViewController *DirectionBranchTableScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AllDirectionBranchTableViewController"];
    [self.navigationController pushViewController:DirectionBranchTableScreen animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    if (checkphoto) {
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
        [self.imagePhoto sd_setImageWithURL:app.user.photoURL
                           placeholderImage:[UIImage imageNamed:@"Splash.png"]];
        
    }
    //it comes from image picker
    checkphoto = true;


}



@end
