//
//  Details.h
//  RosterApp
//
//  Created by Chris Meehan on 1/13/14.
//  Copyright (c) 2014 Chris Meehan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"

@interface DetailsVC : UIViewController<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *uIIVPhoto;
@property (weak, nonatomic) IBOutlet UILabel *gitLabel;
@property (weak, nonatomic) IBOutlet UILabel *twitLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (weak, nonatomic) IBOutlet UISlider *slider3;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet Student *currentStudent;
@property (weak, nonatomic) IBOutlet UITextField *twitterTextField;
@property (weak, nonatomic) IBOutlet UITextField *githubTextField;
@property (weak, nonatomic) IBOutlet UILabel *nameHoldingLabel;
@property (strong, nonatomic) NSString* someString;
@property (nonatomic) UIImagePickerController *imagePickerController2; //This is the controller that will take the picture.
@property (strong, nonatomic) CALayer* myViewsLayer;
@property(strong,nonatomic) UIScrollView* scrollView ;
- (IBAction)cameraOptionWasHit:(id)sender;
- (IBAction)sliderRedMoved:(id)sender;
- (IBAction)sliderBlueMoved:(id)sender;
- (IBAction)sliderGreenMoved:(id)sender;
- (IBAction)saveAll:(id)sender;

@end
