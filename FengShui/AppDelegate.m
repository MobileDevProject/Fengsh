//
//  AppDelegate.m
//  FengShui
//
//  Created by Theodor Swedenborg on 03/08/16.
//  Copyright © 2016 Theodor Swedenborg. All rights reserved.
//

#import "AppDelegate.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>


@interface AppDelegate ()

//@property (retain, nonatomic)

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    [Fabric with:@[[Twitter class]]];
    _NumberOfPhotos = 6;
    _strBranchName = @"";
    _BranchDirection = @"";
    _Branch_Color = [UIColor colorWithHue:1 saturation:1 brightness:1 alpha:1];
    //number of North Career Branch
    _Branch_Count = 0;
    //number of images in North Career Branch
    _Branch_Image_Number = 0;
    //SubBranchName
    _SubBranchIndex= 0;
    //subsub web index
    _SubBranchWebIndex = 0;
    _splashOn = YES;
    self.logOutOn = NO;
    //    NSString *userName = @"";
//    NSString *userPass = @"";
//    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"preferenceName"];
//    [[NSUserDefaults standardUserDefaults] setObject:userPass forKey:@"preferencePass"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    //North URL init 3-Branch number:totalMenuViewContoller - static int North_Career_Number_Branch = 5;
    {
        _North_C = [UIColor colorWithRed:148.0f/255.0f green:205.0f/255.0f blue:221.0f/255.0f alpha:0.5f];
        _North_Career = @"Career";
        _North_Career_Number_Branch = 3;
        _North_Career_Number_Branch_Image = 10;
        _North_Water = @"Water";
        _North_Water_Number_Branch = 3;
        _North_Water_Number_Branch_Image = 10;
        _North_Color = @"Color";
        _North_Color_Number_Branch = 3;
        _North_Color_Number_Branch_Image = 10;
        _North_Direction = @"North";
    }
    
    //South URL init 3-Branch number:totalMenuViewContoller - static int North_Career_Number_Branch = 5;
    {
        _South_C = [UIColor colorWithRed:255.0f/255.0f green:12.0f/255.0f blue:12.0f/255.0f alpha:0.5f];
        _South_Recognition = @"Recognition";
        _South_Recognition_Number_Branch = 3;
        _South_Recognition_Number_Branch_Image = 10;
        _South_Fire = @"Fire";
        _South_Fire_Number_Branch = 3;
        _South_Fire_Number_Branch_Image = 10;
        _South_Color = @"Color";
        _South_Color_Number_Branch = 2;
        _South_Color_Number_Branch_Image = 10;
        _South_Direction = @"South";
    }

    //East URL init 3-Branch number:totalMenuViewContoller - static int North_Career_Number_Branch = 5;
    {
        _East_C = [UIColor colorWithRed:251.0f/255.0f green:91.0f/255.0f blue:32.0f/255.0f alpha:0.5f];
        _East_Family = @"Family";
        _East_Family_Number_Branch = 3;
        _East_Family_Number_Branch_Image = 10;
        _East_BigWood = @"BigWood";
        _East_BigWood_Number_Branch = 3;
        _East_BigWood_Number_Branch_Image = 10;
        _East_Color = @"Color";
        _East_Color_Number_Branch = 2;
        _East_Color_Number_Branch_Image = 10;
        _East_Direction = @"East";
    }
    
    //West URL init 3-Branch number:totalMenuViewContoller - static int North_Career_Number_Branch = 5;
    {
        _West_C = [UIColor colorWithRed:247.0f/255.0f green:209.0f/255.0f blue:67.0f/255.0f alpha:0.6f];
        _West_Dependance = @"Dependance";
        _West_Dependance_Number_Branch = 3;
        _West_Dependance_Number_Branch_Image = 10;
        _West_SmallMetal = @"SmallMetal";
        _West_SmallMetal_Number_Branch = 3;
        _West_SmallMetal_Number_Branch_Image = 10;
        _West_Color = @"Color";
        _West_Color_Number_Branch = 2;
        _West_Color_Number_Branch_Image = 10;
        _West_Direction = @"West";
    }
    

    ///North East URL init 3-Branch number:totalMenuViewContoller - static int North_Career_Number_Branch = 5;
    {
        _NorthEast_C = [UIColor colorWithRed:250.0f/255.0f green:179.0f/255.0f blue:144.0f/255.0f alpha:0.5f];
        _NorthEast_Education = @"Education";
        _NorthEast_Education_Number_Branch = 3;
        _NorthEast_Education_Number_Branch_Image = 10;
        _NorthEast_SmallEarth = @"SmallEarth";
        _NorthEast_SmallEarth_Number_Branch = 3;
        _NorthEast_SmallEarth_Number_Branch_Image = 10;
        _NorthEast_Color = @"Color";
        _NorthEast_Color_Number_Branch = 2;
        _NorthEast_Color_Number_Branch_Image = 10;
        _NorthEast_Direction = @"NorthEast";
    }
    
    ///South East URL init 3-Branch number:totalMenuViewContoller - static int North_Career_Number_Branch = 5;
    {
        _SouthEast_C = [UIColor colorWithRed:57.0f/255.0f green:194.0f/255.0f blue:111.0f/255.0f alpha:0.5f];
        _SouthEast_Wealth = @"Wealth";
        _SouthEast_Wealth_Number_Branch = 3;
        _SouthEast_Wealth_Number_Branch_Image = 10;
        _SouthEast_SmallWood = @"SmallWood";
        _SouthEast_SmallWood_Number_Branch = 3;
        _SouthEast_SmallWood_Number_Branch_Image = 10;
        _SouthEast_Color = @"Color";
        _SouthEast_Color_Number_Branch = 2;
        _SouthEast_Color_Number_Branch_Image = 10;
        _SouthEast_Direction = @"SouthEast";
    }
    
    ///South West URL init 3-Branch number:totalMenuViewContoller - static int North_Career_Number_Branch = 5;
    {
        _SouthWest_C = [UIColor colorWithRed:225.0f/255.0f green:225.0f/255.0f blue:105.0f/255.0f alpha:0.5f];
        _SouthWest_Marriage = @"Marriage";
        _SouthWest_Marriage_Number_Branch = 3;
        _SouthWest_Marriage_Number_Branch_Image = 10;
        _SouthWest_BigEarth = @"BigEarth";
        _SouthWest_BigEarth_Number_Branch = 3;
        _SouthWest_BigEarth_Number_Branch_Image = 10;
        _SouthWest_Color = @"Color";
        _SouthWest_Color_Number_Branch = 2;
        _SouthWest_Color_Number_Branch_Image = 10;
        _SouthWest_Direction = @"SouthWest";
    }

    ///North West URL init 3-Branch number:totalMenuViewContoller - static int North_Career_Number_Branch = 5;
    {
        _NorthWest_C = [UIColor colorWithRed:213.0f/255.0f green:211.0f/255.0f blue:211.0f/255.0f alpha:0.5f];
        _NorthWest_Mentors = @"Mentors";
        _NorthWest_Mentors_Number_Branch= 3;
        _NorthWest_Mentors_Number_Branch_Image = 10;
        _NorthWest_BigMetal = @"BigMetal";
        _NorthWest_BigMetal_Number_Branch = 3;
        _NorthWest_BigMetal_Number_Branch_Image = 10;
        _NorthWest_Color = @"Color";
        _NorthWest_Color_Number_Branch = 2;
        _NorthWest_Color_Number_Branch_Image = 10;
        _NorthWest_Direction = @"NorthWest";
    }
    
    //define direction name array
    self.directionNameArray = [[NSArray alloc]initWithObjects:
                               [NSString stringWithFormat:@"%@_%@",_North_Direction, _North_Water],
                               [NSString stringWithFormat:@"%@_%@",_North_Direction, _North_Color],
                               [NSString stringWithFormat:@"%@_%@",_North_Direction, _North_Career],
                               [NSString stringWithFormat:@"%@_%@",_South_Direction, _South_Fire],
                               [NSString stringWithFormat:@"%@_%@",_South_Direction, _South_Color],
                               [NSString stringWithFormat:@"%@_%@",_South_Direction, _South_Recognition],
                               [NSString stringWithFormat:@"%@_%@",_East_Direction, _East_Color],
                               [NSString stringWithFormat:@"%@_%@",_East_Direction, _East_Family],
                               [NSString stringWithFormat:@"%@_%@",_East_Direction, _East_BigWood],
                               [NSString stringWithFormat:@"%@_%@",_West_Direction, _West_Color],
                               [NSString stringWithFormat:@"%@_%@",_West_Direction, _West_Dependance],
                               [NSString stringWithFormat:@"%@_%@",_West_Direction, _West_SmallMetal],
                               [NSString stringWithFormat:@"%@_%@",_NorthEast_Direction, _NorthEast_Color],
                               [NSString stringWithFormat:@"%@_%@",_NorthEast_Direction, _NorthEast_Education],
                               [NSString stringWithFormat:@"%@_%@",_NorthEast_Direction, _NorthEast_SmallEarth],
                               [NSString stringWithFormat:@"%@_%@",_SouthEast_Direction, _SouthEast_Color],
                               [NSString stringWithFormat:@"%@_%@",_SouthEast_Direction, _SouthEast_Wealth],
                               [NSString stringWithFormat:@"%@_%@",_SouthEast_Direction, _SouthEast_SmallWood],
                               [NSString stringWithFormat:@"%@_%@",_SouthWest_Direction, _SouthWest_Color],
                               [NSString stringWithFormat:@"%@_%@",_SouthWest_Direction, _SouthWest_BigEarth],
                               [NSString stringWithFormat:@"%@_%@",_SouthWest_Direction, _SouthWest_Marriage],
                               [NSString stringWithFormat:@"%@_%@",_NorthWest_Direction, _NorthWest_Color],
                               [NSString stringWithFormat:@"%@_%@",_NorthWest_Direction, _NorthWest_Mentors],
                               [NSString stringWithFormat:@"%@_%@",_NorthWest_Direction, _NorthWest_BigMetal],
                               nil];
    
    
    NSArray *NorthCareerURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/careerandbusinessfaq/f/Feng-Shui-Tips-Attract-Career-Success.htm"], [NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/feng-shui-career-success-tips/"], [NSString stringWithFormat:@"%@", @"http://www.sheknows.com/home-and-gardening/articles/1038825/boost-your-career-success-by-decorating-with-black"] , [NSString stringWithFormat:@"%@", @"https://www.linkedin.com/pulse/11-feng-shui-tips-help-you-advance-your-career-make-more-keith-weber"],[NSString stringWithFormat:@"%@", @"http://feng-shui.lovetoknow.com/How_to_Feng_Shui_the_Bedroom_Career_Money"],[NSString stringWithFormat:@"%@", @"https://www.msfengshui.com/feng-shui-bagua/career-business-life-path"],[NSString stringWithFormat:@"%@", @"http://www.care2.com/greenliving/6-feng-shui-enhancements-for-your-career.html"],[NSString stringWithFormat:@"%@", @"http://redlotusletter.com/feng-shui-first-aid-for-your-career-14-ideas-to-enhance-your-home-and-office-for-greater-job-security/"],[NSString stringWithFormat:@"%@", @"http://www.thedeliciousday.com/minimalism-2/feng-shui-for-career-job/"],[NSString stringWithFormat:@"%@", @"http://www.karenrauchcarter.com/feng-shui-101/feng-shui-and-your-career/"],[NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/feng-shui-career.html"], [NSString stringWithFormat:@"%@", @"http://schoolworkhelper.net/feng-shui-purpose-influence/"], nil];
    
    NSArray *NorthColorURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/meaning-of-blue.html"], [NSString stringWithFormat:@"%@", @"http://redlotusletter.com/the-color-blue-starting-the-flow-of-wealth/"], [NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/meaning-of-black.html"] , [NSString stringWithFormat:@"%@", @"http://feng-shui.lovetoknow.com/feng-shui-home/how-best-use-black-paint-feng-shui-decorating"], [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuiuseofcolors/qt/fengshuiblack.htm"], [NSString stringWithFormat:@"%@", @"http://redlotusletter.com/fengshui-black-color/"] , [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuiuseofcolors/qt/fengshuiblue.htm"], [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/Feng-Shui-Color-Tips/ss/Feng-Shui-Color-Black-House-Decorating.htm"], [NSString stringWithFormat:@"%@", @"http://www.fengshuidana.com/2012/07/12/confidence-communication-the-color-blue/"] , nil];
    
    NSArray *NorthWaterURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuicures/ss/Water-Feng-Shui-Element-Decorating.htm"], [NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/water-feng-shui-element-decorating/"], [NSString stringWithFormat:@"%@", @"http://openspacesfengshui.com/feng-shui-tips/2014/12/water-element-feng-shui-shapes-colors-part-5/"] , [NSString stringWithFormat:@"%@", @"http://feng-shui.lovetoknow.com/Feng_Shui_Elements"], [NSString stringWithFormat:@"%@", @"http://efengshui.org/articles/interiors/water-features-in-the-bedroom-1543.html"], [NSString stringWithFormat:@"%@", @"http://www.fengshui-tips.org/feng-shui-water-fountain.html"] , [NSString stringWithFormat:@"%@", @"http://westernschooloffengshui.com/tag/water-element/"], [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuiforhome/ig/Feng-Shui-Birth-Element-Decor/Water-Feng-Shui-Birth-Element.htm"], [NSString stringWithFormat:@"%@", @"http://www.fengshui-tips.org/feng-shui-elements.html"] , [NSString stringWithFormat:@"%@", @"http://www.holisticspaces.com/podcast/2016/episode-017-feng-shui-and-the-water-element"], [NSString stringWithFormat:@"%@", @"http://www.holisticspaces.com/podcast/2016/episode-017-feng-shui-and-the-water-element"], [NSString stringWithFormat:@"%@", @"http://psychiclibrary.com/beyondBooks/feng-shui/"] , nil];
    
    NSArray *SouthFireURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/feng-shui-decorating-fire-element/"], [NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/feng-shui-decorating-fire-element/"], [NSString stringWithFormat:@"%@", @"http://westernschooloffengshui.com/tag/fire-element/"] , [NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/feng-shui-decorating-fire-element/"], [NSString stringWithFormat:@"%@", @"http://openspacesfengshui.com/feng-shui-tips/2014/10/feng-shui-shapes-colors-part-2-fire-element/"], [NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/fire-element.html"] ,[NSString stringWithFormat:@"%@", @"http://www.fengshui-doctrine.com/index.php?q=feng-shui-fire-element.html"], [NSString stringWithFormat:@"%@", @"http://www.feng-shui-vibes.com/feng-shui-fire-element.html"], [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuiforhome/ig/Feng-Shui-Birth-Element-Decor/Fire-Feng-Shui-Birth-Element.htm"] ,[NSString stringWithFormat:@"%@", @"http://www.hgtv.com/design/decorating/design-101/the-elements-of-feng-shui"], [NSString stringWithFormat:@"%@", @"http://www.homedit.com/guide-to-using-feng-shui-colors-in-decorating/"], nil];
    
    NSArray *SouthColorURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuicures/qt/colorred.htm"], [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/Feng-Shui-Color-Tips/ss/Feng-Shui-Color-Tips-Red-Decorating.htm"], [NSString stringWithFormat:@"%@", @"http://redlotusletter.com/the-importance-of-the-color-of-red-9-ways-to-use-it-to-improve-your-feng-shui/"] ,[NSString stringWithFormat:@"%@", @"http://fengshuiforreallife.com/Detailed/210.html"], [NSString stringWithFormat:@"%@", @"http://openspacesfengshui.com/feng-shui-tips/2013/03/feng-shui-color-tips-red/"], [NSString stringWithFormat:@"%@", @"https://www.pinterest.com/uniquefengshui/red-color-palette-feng-shui-color-ideas/"] ,[NSString stringWithFormat:@"%@", @"https://fivestarfengshui.wordpress.com/2010/04/12/colors-what-does-red-mean-feng-shui-color-theory/"], [NSString stringWithFormat:@"%@", @"http://tjk-musings.blogspot.com/2013/01/the-use-of-colours-in-feng-shui.html"], [NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/your-best-personal-feng-shui-colors/"] , nil];
    NSArray *SouthRecognitionURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"https://www.msfengshui.com/feng-shui-bagua/fame-reputation"], [NSString stringWithFormat:@"%@", @"http://www.care2.com/greenliving/feng-shui-to-enhance-your-fame-and-reputation.html"], [NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/feng-shui-fame.html"] , [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/allfengshuibaguatips/qt/Feng-Shui-Bagua-Tips-South-Area.htm"], [NSString stringWithFormat:@"%@", @"http://www.sunnyray.org/Good-feng-shui-to-improve-fame-and-reputation.htm"], nil];
    
    
    NSArray *EastFamilyURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/allfengshuibaguatips/qt/Feng-Shui-Home-Bagua-Health-Tips.htm"], [NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/feng-shui-family-harmony-tips/"],[NSString stringWithFormat:@"%@", @"http://www.feng-shui-vibes.com/feng-shui-bagua-health.html"], [NSString stringWithFormat:@"%@", @"http://redlotusletter.com/is-your-house-healthy-these-8-questions-help-you-find-out/"] , [NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/feng-shui-family.html"],[NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/feng-shui-health-tips/"],[NSString stringWithFormat:@"%@", @"http://www.lexiyoga.com/feng-shui-for-health"],[NSString stringWithFormat:@"%@", @"http://bodyecology.com/articles/feng-shui-tips.php"],[NSString stringWithFormat:@"%@", @"http://freshome.com/2013/11/20/feng-shui-can-improve-health/"],[NSString stringWithFormat:@"%@", @"http://www.mindbodygreen.com/0-489/6-Feng-Shui-Tips-to-Improve-Your-Health-Happiness-and-Vitality.html"],[NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/childrenfamily/qt/familyharmony.htm"], nil];
    
    NSArray *EastColorURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://www.mindbodygreen.com/0-10945/what-each-color-means-in-feng-shui.html"], [NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/feng-shui-colors.html"], [NSString stringWithFormat:@"%@", @"http://lifestyle.allwomenstalk.com/colors-and-their-meanings-in-feng-shui"] , [NSString stringWithFormat:@"%@", @"http://www.fengshui-tips.org/feng-shui-color.html"],[NSString stringWithFormat:@"%@", @"http://www.housebeautiful.com/room-decorating/colors/tips/g3043/feng-shui-guide-to-color/"],[NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/meaning-of-green.html"],[NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/meaning-of-brown.html"],[NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/bedroom-colors-feng-shui-color-scheme/"],[NSString stringWithFormat:@"%@", @"http://feng-shui.lovetoknow.com/Feng_Shui_Color_Chart"], nil];
    
    NSArray *EastBigWoodURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://redlotusletter.com/the-five-elements-feng-shuis-building-blocks/"], [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuiforhome/ig/Feng-Shui-Birth-Element-Decor/Wood-Feng-Shui-Birth-Element.htm"], [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuicures/ss/Feng-Shui-Wood-Element-Decorating-Tips-for-Home.htm"] , [NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/feng-shui-decorating-wood-element/"],[NSString stringWithFormat:@"%@", @"http://openspacesfengshui.com/feng-shui-tips/2014/10/feng-shui-shapes-colors-wood-element/"],[NSString stringWithFormat:@"%@", @"http://www.feng-shui-vibes.com/feng-shui-wood-element.html"],[NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/wood-element.html"],[NSString stringWithFormat:@"%@", @"http://ifsguild.org/internationalfengshuiguildblog/wood-feng-shui-element/"],[NSString stringWithFormat:@"%@", @"http://susanlevitt.com/about/writers-resume/the-five-taoist-elements-fire-earth-metal-water-and-wood/"], [NSString stringWithFormat:@"%@", @"http://www.thespiritualfengshui.com/wood.php"], nil];
    
    NSArray *WestDependanceURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuiforchildren/qt/feng-shui-children-rooms.htm"], [NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/feng-shui-for-children/"], [NSString stringWithFormat:@"%@", @"https://www.msfengshui.com/feng-shui-bagua/creativity-children-fertility"] , [NSString stringWithFormat:@"%@", @"http://www.sheknows.com/home-and-gardening/articles/1055291/feng-shui-tips-for-kids-rooms"], [NSString stringWithFormat:@"%@", @"http://redlotusletter.com/children-and-chi-the-7-feng-shui-fundamentals-for-childrens-rooms/"], [NSString stringWithFormat:@"%@", @"http://www.fengshuidiva.com/llc.kids.html"] ,[NSString stringWithFormat:@"%@", @"http://www.care2.com/greenliving/is-your-child-not-sleeping-in-their-bedroom-practical-feng-shui-solutions-for-childrens-bedrooms.html"], [NSString stringWithFormat:@"%@", @"https://www.qi-journal.com/FengShui.asp?Name=Feng%20Shui%20for%20Kids%20Rooms&-token.D=Article"], [NSString stringWithFormat:@"%@", @"http://www.huffingtonpost.com/ellen-whitehurst/feng-shui-kids_b_858038.html"] ,[NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/feng-shui-creativity.html"], [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/allfengshuibaguatips/qt/Feng-Shui-Home-Bagua-Tips-Children-Creativity.htm"], nil];
    
    NSArray *WestColorURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/meaning-of-white.html"], [NSString stringWithFormat:@"%@", @"http://openspacesfengshui.com/feng-shui-tips/2013/05/feng-shui-color-tips-gold/"], [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuiuseofcolors/qt/fengshuiwhite.htm"] , [NSString stringWithFormat:@"%@", @"http://www.fengshuisociety.org.uk/psychology-of-colour/"], [NSString stringWithFormat:@"%@", @"http://www.wofs.com/index.php/colors-regularfeatures-41/116-energy-zones-a-the-value-of-colors-in-feng-shui"], nil];
    
    NSArray *WestSmallMetalURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://fengshui.happyhomezone.com/fengshui/fengshuimetalelement.php"], [NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/metal-feng-shui-element-decorating/"], [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuicures/ss/Feng-Shui-Decorating-Metal-Element-Tips.htm"] , [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuiforhome/ig/Feng-Shui-Birth-Element-Decor/Metal-Feng-Shui-Birth-Element.htm"], [NSString stringWithFormat:@"%@", @"http://openspacesfengshui.com/feng-shui-tips/2014/11/metal-element-feng-shui-shapes-colors-part-4/"], [NSString stringWithFormat:@"%@", @"http://redlotusletter.com/feng-shui-metal-element/"] ,[NSString stringWithFormat:@"%@", @"http://westernschooloffengshui.com/tag/metal-element/"], [NSString stringWithFormat:@"%@", @"http://www.fengshuipundit.com/feng-shui-colors/"], [NSString stringWithFormat:@"%@", @"http://www.feng-shui-vibes.com/feng-shui-metal-element.html"] ,nil];
    
    NSArray *NorthEastEducationURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://hubpages.com/religion-philosophy/Six-Feng-Shui-Symbols-for-Education-Luck"], [NSString stringWithFormat:@"%@", @"http://www.wofs.com/index.php/education-mainmenu-31/817-using-feng-shui-to-improve-study-luck"], [NSString stringWithFormat:@"%@", @"https://sanaakosirickylee.wordpress.com/2012/07/13/feng-shui-tips-to-enhance-scholastic-or-education-luck/"] , [NSString stringWithFormat:@"%@", @"http://apersonalorganizer.com/feng-shui-tips-for-good-fortune/"], [NSString stringWithFormat:@"%@", @"http://www.fengshuigiftsideas.com/educationcareerbusiness/feng-shui-tips-for-career-and-education"], [NSString stringWithFormat:@"%@", @"http://www.astrospeak.com/slides/18-feng-shui-tips-for-academic-excellence"] , [NSString stringWithFormat:@"%@", @"http://buy-fengshui.com/feng-shui-education/"], [NSString stringWithFormat:@"%@", @"https://www.msfengshui.com/feng-shui-bagua/skills-knowledge-wisdom"], [NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/skills-and-knowledge.html"] , [NSString stringWithFormat:@"%@", @"http://www.fengshuivermont.com/pubart/thirty.html"], [NSString stringWithFormat:@"%@", @"http://circle-of-light.com/fengshui/fs-knowledge.html"], [NSString stringWithFormat:@"%@", @"http://www.karenrauchcarter.com/feng-shui-101/feng-shui-and-skills-knowledge-and-self-cultivation/"] , [NSString stringWithFormat:@"%@", @"http://www.fengshui-doctrine.com/index.php?q=wisdom-selfknowledge-calm-feng-shui.html"], [NSString stringWithFormat:@"%@", @"http://www.uniquefengshui.com/knowledge-education/"] , nil];
    
    NSArray *NorthEastColorURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://www.ochreandocre.com/ochres.php"], [NSString stringWithFormat:@"%@", @"http://www.wofs.com/index.php/colors-regularfeatures-41/112-driving-colors"], [NSString stringWithFormat:@"%@", @"https://homethatwebuilt.wordpress.com/2014/02/07/2014-feng-shui-recommendations/"] , [NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/feng-shui-colors-for-rooms.html"] , nil];
    
    NSArray *NorthEastSmallEarthURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuicures/ss/Feng-Shui-Earth-Element-Decorating-Tips.htm"], [NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/earth-feng-shui-element-decorating/"], [NSString stringWithFormat:@"%@", @"http://openspacesfengshui.com/feng-shui-tips/2014/10/feng-shui-shapes-colors-part-3-earth-element/"] ,[NSString stringWithFormat:@"%@", @"http://westernschooloffengshui.com/tag/earth-element/"], [NSString stringWithFormat:@"%@", @"https://www.pinterest.com/pin/545005992380248435/"], [NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/earth-element.html"] , [NSString stringWithFormat:@"%@", @"http://www.fengshui-doctrine.com/index.php?q=feng-shui-earth-element.html"], [NSString stringWithFormat:@"%@", @"http://fengshui.happyhomezone.com/fengshui/fengshuiearthelement.php"], [NSString stringWithFormat:@"%@", @"http://www.crystalvaults.com/earth-energy"] , [NSString stringWithFormat:@"%@", @"http://fengshui4today.com/earth-element/"], [NSString stringWithFormat:@"%@", @"https://sandiegofengshuiblog.wordpress.com/tag/feng-shui-earth-element/"], [NSString stringWithFormat:@"%@", @"http://www.holisticspaces.com/podcast/2016/episode-015-feng-shui-and-the-earth-element"] , nil];
    
    NSArray *SouthEastWealthURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/wealthcareer/ss/Feng-Shui-Money-Tips-Attract-Wealth.htm"], [NSString stringWithFormat:@"%@", @"http://www.fengshuipundit.com/feng-shui-wealth/"], [NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/feng-shui-money-wealth-tips/"] , [NSString stringWithFormat:@"%@", @"http://www.consciouslifestylemag.com/feng-shui-money-and-wealth-home-guide/"],[NSString stringWithFormat:@"%@", @"https://www.msfengshui.com/feng-shui-bagua/prosperity-wealth-money"],[NSString stringWithFormat:@"%@", @"http://www.fengshui-tips.org/feng-shui-wealth.html"],[NSString stringWithFormat:@"%@", @"http://www.care2.com/greenliving/9-feng-shui-ways-to-enhance-your-wealth.html"],[NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/feng-shui-wealth.html"],[NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/abundance-and-prosperity.html"],[NSString stringWithFormat:@"%@", @"http://dragonfengshui.blogspot.com/2010/03/feng-shui-to-attract-money-and-wealth.html"],[NSString stringWithFormat:@"%@", @"http://www.thedeliciousday.com/job/feng-shui-for-wealth/"],[NSString stringWithFormat:@"%@", @"https://www.learnvest.com/2012/01/feng-shui-fix-the-flow-of-wealth-in-your-home-and-office/"], nil];
    
    NSArray *SouthEastColorURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://redlotusletter.com/green-feng-shuis-color-of-health-wealth-and-growth/"], [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuiuseofcolors/qt/fengshuigreen.htm"], [NSString stringWithFormat:@"%@", @"http://www.mindbodygreen.com/0-10945/what-each-color-means-in-feng-shui.html"] , [NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/meaning-of-green.html"], [NSString stringWithFormat:@"%@", @"http://openspacesfengshui.com/feng-shui-tips/2013/05/feng-shui-color-tips-turquoise/"], [NSString stringWithFormat:@"%@", @"http://www.fengshuinatural.com/en/fengshuicolours.html"] ,[NSString stringWithFormat:@"%@", @"http://www.gmanetwork.com/news/story/440911/lifestyle/artandculture/wear-green-be-clean-and-6-other-feng-shui-tips-for-good-fortune-on-chinese-new-year-s-day"], [NSString stringWithFormat:@"%@", @"http://fengshuiforreallife.com/Detailed/426.html"], [NSString stringWithFormat:@"%@", @"http://www.colormatters.com/the-meanings-of-colors/green"] , nil];
    
    NSArray *SouthEastSmallWoodURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://www.fengshui-doctrine.com/index.php?q=feng-shui-wood-element.html"], [NSString stringWithFormat:@"%@", @"http://www.kenlauher.com/feng-shui-tips/bid/53871/Feng-Shui-Element-of-Wood-What-It-Means"], [NSString stringWithFormat:@"%@", @"https://www.pinterest.com/pin/415246028119841401/"] , [NSString stringWithFormat:@"%@", @"http://fengshuistudies.com/feng-shui-the-wood-element-and-welcoming-spring/"], [NSString stringWithFormat:@"%@", @"http://www.macrobiotics.co.uk/articles/fiveelementstheory.htm"], [NSString stringWithFormat:@"%@", @"http://in5d.com/feng-shui-five-elements-how-to-use-the-feng-shui-five-elements-with-colors/"] ,[NSString stringWithFormat:@"%@", @"http://www.crystalvaults.com/wood-energy"], [NSString stringWithFormat:@"%@", @"http://westernschooloffengshui.com/tag/wood-element/"], [NSString stringWithFormat:@"%@", @"http://fengshui4today.com/wood-element/"] , [NSString stringWithFormat:@"%@", @"http://www.fengshuivermont.com/pubart/fortyfour.html"], [NSString stringWithFormat:@"%@", @"http://www.fengshuilasvegas.com/wood/"], [NSString stringWithFormat:@"%@", @"http://www.buzzle.com/articles/feng-shui-to-decorate-with-wood-elements.html"] ,nil];
    
    NSArray *SouthWestMarriageURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"https://www.msfengshui.com/feng-shui-bagua/relationships-love-marriage"], [NSString stringWithFormat:@"%@", @"http://www.thedeliciousday.com/minimalism-2/feng-shui-love/"], [NSString stringWithFormat:@"%@", @"http://www.dailytransformations.com/feng-shui-tips-for-attracting-and-enhancing-love/"] , [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/love/qt/Feng-Shui-Home-Bagua-Tips-For-Love-Area.htm"], [NSString stringWithFormat:@"%@", @"https://sanaakosirickylee.wordpress.com/2012/01/31/feng-shui-tips-to-enhance-love-and-marriage-luck/"], [NSString stringWithFormat:@"%@", @"http://fengshuibeginner.com/learn-tips-to-feng-shui-for-love-and-marriage-luck/"] , [NSString stringWithFormat:@"%@", @"http://www.spiritofmaat.com/archive/apr1/fengshui.htm"], [NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/feng-shui-relationship.html"], [NSString stringWithFormat:@"%@", @"http://www.fengshui-doctrine.com/index.php?q=general-marriage-advice.html"] , [NSString stringWithFormat:@"%@", @"http://www.mauihealingretreat.com/feng-shui-for-your-marriage-or-relationship/"], [NSString stringWithFormat:@"%@", @""], nil];
    
    NSArray *SouthWestColorURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuicures/qt/coloryellow.htm"], [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/Feng-Shui-Color-Tips/ss/Feng-Shui-Colors-Decorate-House-Yellow-Gold.htm"], [NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/meaning-of-yellow.html"] , [NSString stringWithFormat:@"%@", @"https://fawnachang.wordpress.com/2011/07/04/yellow-the-hardest-color-to-get-right/"], [NSString stringWithFormat:@"%@", @"http://www.fengshuidana.com/2012/03/16/feng-shui-color-the-year-round-sunshine-of-yellow/"], [NSString stringWithFormat:@"%@", @"http://redlotusletter.com/feng-shui-and-the-color-yellow/"] ,[NSString stringWithFormat:@"%@", @"http://openspacesfengshui.com/feng-shui-tips/2013/03/feng-shui-color-tips-yellow/"], [NSString stringWithFormat:@"%@", @"http://www.kenlauher.com/feng-shui-tips/bid/48203/The-Feng-Shui-Color-Yellow-Can-Cause-Tension"], [NSString stringWithFormat:@"%@", @"http://www.elledaniel.com/feng-shui-and-yellow-gold-lamp-shades/"] ,[NSString stringWithFormat:@"%@", @"http://thecoloryellow.eu/feng-shui/"], nil];
    
    NSArray *SouthWestBigEarthURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuicures/ss/Feng-Shui-Earth-Element-Decorating-Tips.htm"], [NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/earth-feng-shui-element-decorating/"], [NSString stringWithFormat:@"%@", @"http://openspacesfengshui.com/feng-shui-tips/2014/10/feng-shui-shapes-colors-part-3-earth-element/"] , [NSString stringWithFormat:@"%@", @"http://westernschooloffengshui.com/tag/earth-element/"], [NSString stringWithFormat:@"%@", @"https://www.pinterest.com/pin/545005992380248435/"], [NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/earth-element.html"] ,[NSString stringWithFormat:@"%@", @"http://www.fengshui-doctrine.com/index.php?q=feng-shui-earth-element.html"], [NSString stringWithFormat:@"%@", @"http://fengshui.happyhomezone.com/fengshui/fengshuiearthelement.php"], [NSString stringWithFormat:@"%@", @"http://www.crystalvaults.com/earth-energy"] ,[NSString stringWithFormat:@"%@", @"http://fengshui4today.com/earth-element/"], [NSString stringWithFormat:@"%@", @"https://sandiegofengshuiblog.wordpress.com/tag/feng-shui-earth-element/"], [NSString stringWithFormat:@"%@", @"http://www.holisticspaces.com/podcast/2016/episode-015-feng-shui-and-the-earth-element"] ,nil];
    
    
    NSArray *NorthWestMentorsURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://www.uniquefengshui.com/mentors-and-helpful-people/"], [NSString stringWithFormat:@"%@", @"https://sanaakosirickylee.wordpress.com/2012/02/29/feng-shui-tips-to-activate-mentors-luck/"], [NSString stringWithFormat:@"%@", @"http://www.skillon.com/Bazi_FengShui.cfm/topic/Feng_Shui_Networking_Tips__the_untold_secret_in_Feng_Shui"] , [NSString stringWithFormat:@"%@", @"http://www.wdrb.com/story/32257406/successful-business-networking-today-on-illuminating-feng-shui-june-22nd"], [NSString stringWithFormat:@"%@", @"http://fengshui-simplecures.blogspot.com/2012/12/get-right-mentor-feng-shui-support-by.html"], [NSString stringWithFormat:@"%@", @"http://www.fengshuisandiego.com/Activating_Mentors_for_Support.shtml"] , nil];
    
    NSArray *NorthWestColorURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://www.feng-shui-and-beyond.com/meaning-of-white.html"], [NSString stringWithFormat:@"%@", @"http://openspacesfengshui.com/feng-shui-tips/2013/05/feng-shui-color-tips-gold/"], [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuiuseofcolors/qt/fengshuiwhite.htm"] , [NSString stringWithFormat:@"%@", @"http://www.fengshuisociety.org.uk/psychology-of-colour/"], [NSString stringWithFormat:@"%@", @"http://www.wofs.com/index.php/colors-regularfeatures-41/116-energy-zones-a-the-value-of-colors-in-feng-shui"] , nil];
    
    NSArray *NorthWestBigMetalURLAs = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%@", @"http://fengshui.happyhomezone.com/fengshui/fengshuimetalelement.php"], [NSString stringWithFormat:@"%@", @"http://www.knowfengshui.com/metal-feng-shui-element-decorating/"], [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuicures/ss/Feng-Shui-Decorating-Metal-Element-Tips.htm"] , [NSString stringWithFormat:@"%@", @"http://fengshui.about.com/od/fengshuiforhome/ig/Feng-Shui-Birth-Element-Decor/Metal-Feng-Shui-Birth-Element.htm"], [NSString stringWithFormat:@"%@", @"http://openspacesfengshui.com/feng-shui-tips/2014/11/metal-element-feng-shui-shapes-colors-part-4/"], [NSString stringWithFormat:@"%@", @"http://redlotusletter.com/feng-shui-metal-element/"] , [NSString stringWithFormat:@"%@", @"http://westernschooloffengshui.com/tag/metal-element/"], [NSString stringWithFormat:@"%@", @"http://www.fengshuipundit.com/feng-shui-colors/"], [NSString stringWithFormat:@"%@", @"http://www.feng-shui-vibes.com/feng-shui-metal-element.html"] , nil];
    
    
    _dicAllURLs = [[NSDictionary alloc] initWithObjectsAndKeys:NorthCareerURLAs,@"North_Career",NorthColorURLAs,@"North_Color",NorthWaterURLAs, @"North_Water",SouthFireURLAs, @"South_Fire", SouthColorURLAs, @"South_Color", SouthRecognitionURLAs, @"South_Recognition",
                   EastBigWoodURLAs, @"East_BigWood", EastColorURLAs, @"East_Color", EastFamilyURLAs, @"East_Family",
                   WestSmallMetalURLAs, @"West_SmallMetal", WestColorURLAs, @"West_Color", WestDependanceURLAs, @"West_Dependance",
                   NorthEastSmallEarthURLAs, @"NorthEast_SmallEarth", NorthEastColorURLAs, @"NorthEast_Color", NorthEastEducationURLAs, @"NorthEast_Education",
                   SouthEastSmallWoodURLAs, @"SouthEast_SmallWood", SouthEastColorURLAs, @"SouthEast_Color", SouthEastWealthURLAs, @"SouthEast_Wealth",
                   SouthWestBigEarthURLAs, @"SouthWest_BigEarth", SouthWestColorURLAs, @"SouthWest_Color", SouthWestMarriageURLAs, @"SouthWest_Marriage",
                   NorthWestBigMetalURLAs, @"NorthWest_BigMetal", NorthWestColorURLAs, @"NorthWest_Color", NorthWestMentorsURLAs, @"NorthWest_Mentors",nil];
    return YES;
}

//part for facebook sdk extention
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
