//
//  AppDelegate.h
//  FengShui
//
//  Created by Theodor Swedenborg on 03/08/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
@import Firebase;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic)BOOL checkPost;
@property (nonatomic, retain)NSDictionary *commentDic;
@property (nonatomic, retain)NSArray *directionNameArray;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) int NumberOfPhotos;
@property (nonatomic) BOOL splashOn;
@property (nonatomic) BOOL logOutOn;
@property (nonatomic, retain)FIRUser* currentUser;
@property (nonatomic, retain)UserInfo* user;

@property (retain, nonatomic) NSString *strBranchName;
@property (nonatomic) int Branch_Count;
@property (nonatomic) int Branch_Image_Number;
@property (nonatomic) NSString *BranchDirection;
@property (nonatomic) UIColor* Branch_Color;
@property (nonatomic) int SubBranchIndex;
@property (nonatomic) int SubBranchWebIndex;
@property (nonatomic,retain) NSDictionary *dicAllURLs;

//north
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
//


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
//

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
//

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
//

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

