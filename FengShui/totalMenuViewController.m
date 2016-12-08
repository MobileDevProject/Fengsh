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
#import "CommentsViewController.h"
#import "AppDelegate.h"
#import "totalMenuViewController.h"
#import "GeoPointCompass.h"
#import <CoreLocation/CoreLocation.h>
#import "SWRevealViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <FLAnimatedImage.h>
#import <FLAnimatedImageView.h>

@interface totalMenuViewController ()<CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{

    CLLocationManager* locationManager;
    GeoPointCompass *geoPointCompass;
    AppDelegate *app;
    CLLocationDirection currentDir;
    BOOL checkphoto;
    NSDictionary *directionButtons;
    NSDictionary *directionAlertImages;
    NSMutableDictionary *directionAlertButton;

}
//direction buttons
@property (weak, nonatomic) IBOutlet UIButton *btnNorthCareer;
@property (weak, nonatomic) IBOutlet UIButton *btnNorthColor;
@property (weak, nonatomic) IBOutlet UIButton *btnNorthWater;

@property (weak, nonatomic) IBOutlet UIButton *btnEastFamily;
@property (weak, nonatomic) IBOutlet UIButton *btnEastColor;
@property (weak, nonatomic) IBOutlet UIButton *btnEastBigWood;

@property (weak, nonatomic) IBOutlet UIButton *btnSouthColor;
@property (weak, nonatomic) IBOutlet UIButton *btnSouthFire;
@property (weak, nonatomic) IBOutlet UIButton *btnSouthRecognition;

@property (weak, nonatomic) IBOutlet UIButton *btnWestDependance;
@property (weak, nonatomic) IBOutlet UIButton *btnWestColor;
@property (weak, nonatomic) IBOutlet UIButton *btnWestSmallMetal;

@property (weak, nonatomic) IBOutlet UIButton *btnNorthEastSmallEarth;
@property (weak, nonatomic) IBOutlet UIButton *btnNorthEastBeige;
@property (weak, nonatomic) IBOutlet UIButton *btnNorthEastEducation;

@property (weak, nonatomic) IBOutlet UIButton *btnSouthEastWealth;
@property (weak, nonatomic) IBOutlet UIButton *btnSouthEastColor;
@property (weak, nonatomic) IBOutlet UIButton *btnSouthEastSmallWood;

@property (weak, nonatomic) IBOutlet UIButton *btnSouthWestMarriage;
@property (weak, nonatomic) IBOutlet UIButton *btnSouthWestColor;
@property (weak, nonatomic) IBOutlet UIButton *btnSouthWestBigEarth;

@property (weak, nonatomic) IBOutlet UIButton *btnNorthWestMentors;
@property (weak, nonatomic) IBOutlet UIButton *btnNorthWestColor;
@property (weak, nonatomic) IBOutlet UIButton *btnNorthWestBigMetal;


//new comments alert images
@property (weak, nonatomic) IBOutlet UIImageView *imgNorthCareer;
@property (weak, nonatomic) IBOutlet UIImageView *imgNorthColor;
@property (weak, nonatomic) IBOutlet UIImageView *imgNorthWater;

@property (weak, nonatomic) IBOutlet UIImageView *imgEastFamily;
@property (weak, nonatomic) IBOutlet UIImageView *imgEastColor;
@property (weak, nonatomic) IBOutlet UIImageView *imgEastBigWood;

@property (weak, nonatomic) IBOutlet UIImageView *imgSouthColor;
@property (weak, nonatomic) IBOutlet UIImageView *imgSouthFire;
@property (weak, nonatomic) IBOutlet UIImageView *imgSouthRecognition;

@property (weak, nonatomic) IBOutlet UIImageView *imgWestDependance;
@property (weak, nonatomic) IBOutlet UIImageView *imgWestColor;
@property (weak, nonatomic) IBOutlet UIImageView *imgWestSmallMetal;

@property (weak, nonatomic) IBOutlet UIImageView *imgNorthEastSmallEarth;
@property (weak, nonatomic) IBOutlet UIImageView *imgNorthEastBeige;
@property (weak, nonatomic) IBOutlet UIImageView *imgNorthEastEducation;

@property (weak, nonatomic) IBOutlet UIImageView *imgSouthEastWealth;
@property (weak, nonatomic) IBOutlet UIImageView *imgSouthEastColor;
@property (weak, nonatomic) IBOutlet UIImageView *imgSouthEastSmallWood;

@property (weak, nonatomic) IBOutlet UIImageView *imgSouthWestMarriage;
@property (weak, nonatomic) IBOutlet UIImageView *imgSouthWestColor;
@property (weak, nonatomic) IBOutlet UIImageView *imgSouthWestBigEarth;

@property (weak, nonatomic) IBOutlet UIImageView *imgNorthWestMentors;
@property (weak, nonatomic) IBOutlet UIImageView *imgNorthWestColor;
@property (weak, nonatomic) IBOutlet UIImageView *imgNorthWestBigMetal;


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
    directionAlertButton = [[NSMutableDictionary alloc]init];
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
    
    //register all buttons in dictionary
    
    
    
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

    //photo circlization
    [self.view layoutIfNeeded];
    app = [UIApplication sharedApplication].delegate;
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
    self.btnSouthEastColor.transform = CGAffineTransformRotate(self.btnSouthEastColor.transform, -M_PI/4);
    self.btnSouthEastSmallWood.transform = CGAffineTransformRotate(self.btnSouthEastSmallWood.transform, -M_PI/4);
    
    self.btnSouthWestMarriage.transform = CGAffineTransformRotate(self.btnSouthWestMarriage.transform, M_PI/4);
    self.btnSouthWestColor.transform = CGAffineTransformRotate(self.btnSouthWestColor.transform, M_PI/4);
    self.btnSouthWestBigEarth.transform = CGAffineTransformRotate(self.btnSouthWestBigEarth.transform, M_PI/4);
    
    self.btnNorthWestMentors.transform = CGAffineTransformRotate(self.btnNorthWestMentors.transform, -M_PI/4);
    self.btnNorthWestColor.transform = CGAffineTransformRotate(self.btnNorthWestColor.transform, -M_PI/4);
    self.btnNorthWestBigMetal.transform = CGAffineTransformRotate(self.btnNorthWestBigMetal.transform, -M_PI/4);
    
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
        app = [UIApplication sharedApplication].delegate;
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
        [self.imagePhoto sd_setImageWithURL:app.user.photoURL
                           placeholderImage:[UIImage imageNamed:@"Splash.png"]];
        
    }
    
    //alert image init
    //alert image registration
    [self registerAllButtons];
    
    // alert image init hiddenY
    for (UIImageView *image in directionAlertImages.allValues) {
        image.alpha = 1;
        [image setHidden:YES];
        [image setImage:[UIImage imageNamed:@"blink.png"]];
//        [NSTimer scheduledTimerWithTimeInterval:17 target:self selector:@selector(hideSplashScreen) userInfo:nil repeats:YES];
        //[self.view layoutIfNeeded];
        //image.layer.cornerRadius = image.frame.size.height/2;
        //image.clipsToBounds = YES;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            image.alpha = 0;
        } completion:nil  ];
        if (directionAlertButton.count<24) {
        UIButton *coverButton = [[UIButton alloc]initWithFrame:image.frame];
        [coverButton setBounds:CGRectMake(coverButton.frame.origin.x - 10, coverButton.frame.origin.y - 10, coverButton.bounds.size.width+10, coverButton.bounds.size.height+10)];
        [coverButton addTarget:self action:@selector(TapBlinkImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.MenuView addSubview:coverButton];
        [coverButton setHidden: YES];
        
            NSString *key = [directionAlertImages allKeysForObject:image].firstObject;
            [directionAlertButton setValue:coverButton forKey:key];
        }
        
    }
    for (NSString* akey in directionAlertButton.allKeys) {
        UIButton * button = (UIButton*)[directionAlertButton objectForKey:akey];
        [button setHidden: YES];
    }
    
    //it comes from image picker
    checkphoto = true;
    [self checkViewedTime];
    

    
    [geoPointCompass setDicRotationAlertViews:directionAlertImages];
}

-(void)checkViewedTime{
    FIRDatabaseReference *updatedTimeRef = [[Request dataref] child:@"updatedTime"];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [updatedTimeRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (snapshot.exists) {
                    for (NSString* key in snapshot.value) {
                        if(![[NSUserDefaults standardUserDefaults] boolForKey:key]) {
                            //do initialization stuff here...
                            NSString *viewedTime = [[NSUserDefaults standardUserDefaults]
                                                      stringForKey:key];
                            
                            NSString *updatedTime = [snapshot.value objectForKey:key];
                            
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                            NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
                            [dateFormatter setTimeZone:gmt];
                            if (!viewedTime) {
                                viewedTime = [dateFormatter stringFromDate:[NSDate date]];
                                [[NSUserDefaults standardUserDefaults] setObject:viewedTime forKey:key];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                                
                            }
                            
                            //delete branch number from key (for example: SouthWest_Color_1 -> SouthWest_Color)
                            NSInteger location1 = [key rangeOfString:@"_"].location;
                            NSInteger location2 = [key rangeOfString:@"+"].location;
                            NSString *directionS = [key substringToIndex:location1];
                            int brunchNumer= [[key substringFromIndex:location2 + 1] intValue];
                            NSString* BranchS = [key substringWithRange:NSMakeRange(location1+1, location2-location1-1)] ;
                            NSString *filteredKey = [NSString stringWithFormat: @"%@_%@", directionS, BranchS];
                            //[(UIButton*)[directionAlertButton objectForKey:filteredKey] setTag:brunchNumer];
                            //if viewtime < updatedtime
                            if ([filteredKey isEqualToString:@"West_SmallMetal"]) {
                                int d = 1;
                            }
                            if ([[dateFormatter dateFromString:viewedTime] compare:[dateFormatter dateFromString:updatedTime]] == NSOrderedAscending) {
                                
                                
                                UIImageView *image = (UIImageView*)[directionAlertImages objectForKey:filteredKey];
                                [image setHidden: NO];
                                UIButton *coverButton = (UIButton*)[directionAlertButton objectForKey:filteredKey];
                                [coverButton setHidden: NO];
                                [coverButton setTag:brunchNumer];
                            }else{
                                //UIImageView *image = (UIImageView*)[directionAlertImages objectForKey:filteredKey];
                                
                                //[image setHidden: YES];
                                
                            }
                            
                        }
                    }
                }
                
            });
        }];
    });
        


}
-(void)TapBlinkImage:(UIButton*)sender{
    NSString *key = [directionAlertButton allKeysForObject:sender].firstObject;

    NSInteger location1 = [key rangeOfString:@"_"].location;
    NSString *directionS = [key substringToIndex:location1];
    NSString *brunchS = [key substringFromIndex:location1+1];
    int brunchNumber = (int)sender.tag;
    
    [self playSound:@"m3"];
    app.strBranchName = brunchS;
    app.BranchDirection = directionS;
    
    int number  =  brunchNumber;
    app.SubBranchIndex = number;
    CommentsViewController *DirectionBranchTableScreen = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CommentsViewController"];
    [self.navigationController pushViewController:DirectionBranchTableScreen animated:YES];
}

-(void)registerAllButtons{
    
    directionButtons = [[NSDictionary alloc]initWithObjectsAndKeys:
                        self.btnNorthWater,app.directionNameArray[0],
                        self.btnNorthColor,app.directionNameArray[1],
                        self.btnNorthCareer,app.directionNameArray[2],
                        self.btnSouthFire,app.directionNameArray[3],
                        self.btnSouthColor,app.directionNameArray[4],
                        self.btnSouthRecognition,app.directionNameArray[5],
                        self.btnEastColor,app.directionNameArray[6],
                        self.btnEastFamily,app.directionNameArray[7],
                        self.btnEastBigWood,app.directionNameArray[8],
                        self.btnWestColor,app.directionNameArray[9],
                        self.btnWestDependance,app.directionNameArray[10],
                        self.btnWestSmallMetal,app.directionNameArray[11],
                        self.btnNorthEastBeige,app.directionNameArray[12],
                        self.btnNorthEastEducation,app.directionNameArray[13],
                        self.btnNorthEastSmallEarth,app.directionNameArray[14],
                        self.btnSouthEastColor,app.directionNameArray[15],
                        self.btnSouthEastWealth,app.directionNameArray[16],
                        self.btnSouthEastSmallWood,app.directionNameArray[17],
                        self.btnSouthWestColor,app.directionNameArray[18],
                        self.btnSouthWestBigEarth,app.directionNameArray[19],
                        self.btnSouthWestMarriage,app.directionNameArray[20],
                        self.btnNorthWestColor,app.directionNameArray[21],
                        self.btnNorthWestMentors,app.directionNameArray[22],
                        self.btnNorthWestBigMetal,app.directionNameArray[23],
                        nil];
    
    directionAlertImages = [[NSDictionary alloc]initWithObjectsAndKeys:
                        self.imgNorthWater,app.directionNameArray[0],
                        self.imgNorthColor,app.directionNameArray[1],
                        self.imgNorthCareer,app.directionNameArray[2],
                        self.imgSouthFire,app.directionNameArray[3],
                        self.imgSouthColor,app.directionNameArray[4],
                        self.imgSouthRecognition,app.directionNameArray[5],
                        self.imgEastColor,app.directionNameArray[6],
                        self.imgEastFamily,app.directionNameArray[7],
                        self.imgEastBigWood,app.directionNameArray[8],
                        self.imgWestColor,app.directionNameArray[9],
                        self.imgWestDependance,app.directionNameArray[10],
                        self.imgWestSmallMetal,app.directionNameArray[11],
                        self.imgNorthEastBeige,app.directionNameArray[12],
                        self.imgNorthEastEducation,app.directionNameArray[13],
                        self.imgNorthEastSmallEarth,app.directionNameArray[14],
                        self.imgSouthEastColor,app.directionNameArray[15],
                        self.imgSouthEastWealth,app.directionNameArray[16],
                        self.imgSouthEastSmallWood,app.directionNameArray[17],
                        self.imgSouthWestColor,app.directionNameArray[18],
                        self.imgSouthWestBigEarth,app.directionNameArray[19],
                        self.imgSouthWestMarriage,app.directionNameArray[20],
                        self.imgNorthWestColor,app.directionNameArray[21],
                        self.imgNorthWestMentors,app.directionNameArray[22],
                        self.imgNorthWestBigMetal,app.directionNameArray[23],
                        nil];
}
@end
