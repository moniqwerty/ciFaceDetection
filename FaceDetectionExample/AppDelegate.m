//
//  AppDelegate.m
//  FaceDetectionExample
//
//  Created by Johann Dowa on 11-11-01.
//  Copyright (c) 2011 ManiacDev.Com All rights reserved.
//
//  "Monster Face" Image by Tobyotter on Flickr


#import <CoreImage/CoreImage.h>
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>   


#import "AppDelegate.h"

#import "ViewController.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

-(void)markFaces:(UIImageView *)facePicture
{
    //wait so we can see drawing
    sleep(1);
    // draw a CI image with the previously loaded face detection picture
    CIImage* image = [CIImage imageWithCGImage:facePicture.image.CGImage];
    
    // create a face detector - since speed is not an issue we'll use a high accuracy
    // detector
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace 
                                              context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];
    
    // create an array containing all the detected faces from the detector    
    NSArray* features = [detector featuresInImage:image];
    
    // iteracija niz site lica
    for(CIFaceFeature* faceFeature in features)
    {
        
        CGFloat faceWidth = faceFeature.bounds.size.width;
    
        UIView* faceView = [[UIView alloc] initWithFrame:faceFeature.bounds];
        
        // frame okolu liceto
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];
        
        [self.window addSubview:faceView];
        
        if(faceFeature.hasLeftEyePosition)
        {
            //krug okolu levo oko
            UIView* leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.leftEyePosition.x-faceWidth*0.15, faceFeature.leftEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            
            [leftEyeView setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            
            [leftEyeView setCenter:faceFeature.leftEyePosition];
            
            leftEyeView.layer.cornerRadius = faceWidth*0.15;
            
            [self.window addSubview:leftEyeView];
        }
        
        if(faceFeature.hasRightEyePosition)
        {
            //kruuug
            UIView* leftEye = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.rightEyePosition.x-faceWidth*0.15, faceFeature.rightEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            
            [leftEye setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            [leftEye setCenter:faceFeature.rightEyePosition];
            leftEye.layer.cornerRadius = faceWidth*0.15;
            [self.window addSubview:leftEye];
        }
        
        if(faceFeature.hasMouthPosition)
        {
            // krug okolu mouth
            UIView* mouth = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.mouthPosition.x-faceWidth*0.2, faceFeature.mouthPosition.y-faceWidth*0.2, faceWidth*0.4, faceWidth*0.4)];
            [mouth setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.3]];
            [mouth setCenter:faceFeature.mouthPosition];
            mouth.layer.cornerRadius = faceWidth*0.2;
            [self.window addSubview:mouth];
        }
    }
}

-(void)faceDetector
{
    // Load image
    UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facedetectionpic.jpg"]];
    [self.window addSubview:image];
    
    [self performSelectorInBackground:@selector(markFaces:) withObject:image];
    
    //effin cg graphics
    [image setTransform:CGAffineTransformMakeScale(1, -1)];
    [self.window setTransform:CGAffineTransformMakeScale(1, -1)];
    
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    [self faceDetector]; // execute the faceDetector code
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
