//
//  Details.m
//  RosterApp
//
//  Created by Chris Meehan on 1/13/14.
//  Copyright (c) 2014 Chris Meehan. All rights reserved.
//

#import "DetailsVC.h"
#import <AssetsLibrary/AssetsLibrary.h>


@implementation DetailsVC
@synthesize nameHoldingLabel = _nameHoldingLabel;
@synthesize someString = _someString;
@synthesize twitterTextField;
@synthesize githubTextField;
@synthesize twitLabel;
@synthesize gitLabel;
@synthesize currentStudent=_currentStudent;
@synthesize myViewsLayer= _myViewsLayer;
@synthesize slider1=_slider1;
@synthesize slider2=_slider2;
@synthesize slider3=_slider3;
@synthesize label1=_label1;
@synthesize label2=_label2;
@synthesize label3=_label3;
@synthesize scrollView;
@synthesize uIIVPhoto;


- (IBAction)saveAll:(id)sender{
    [self.currentStudent setRed:self.slider1.value abdBlue:self.slider2.value andGreen:self.slider3.value];
}

- (IBAction)sliderRedMoved:(id)sender{
    self.label1.text = [NSString stringWithFormat:@"%f",self.slider1.value];
    UIColor* tempColor =  [[UIColor alloc]initWithRed:self.slider1.value green:self.slider2.value blue:self.slider3.value alpha:1.0];
    [self.view setBackgroundColor:tempColor];
}

- (IBAction)sliderGreenMoved:(id)sender{
    self.label2.text = [NSString stringWithFormat:@"%f",self.slider2.value];
    [self.view setBackgroundColor:[UIColor blueColor]];
    UIColor* tempColor =  [[UIColor alloc]initWithRed:self.slider1.value green:self.slider2.value blue:self.slider3.value alpha:1.0];
    [self.view setBackgroundColor:tempColor];
}

- (IBAction)sliderBlueMoved:(id)sender{
    self.label3.text = [NSString stringWithFormat:@"%f",self.slider3.value];
    UIColor* tempColor =  [[UIColor alloc]initWithRed:self.slider1.value green:self.slider2.value blue:self.slider3.value alpha:1.0];
    [self.view setBackgroundColor:tempColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.slider1.value = [self.currentStudent getRed];
    self.slider2.value = [self.currentStudent getBlue];
    self.slider3.value = [self.currentStudent getGreen];
    UIColor* aColor = [[UIColor alloc]initWithRed:self.slider1.value green:self.slider2.value blue:self.slider3.value alpha:1.0];
    [self.view setBackgroundColor:aColor];
    self.label1.text = [NSString stringWithFormat:@"%f",self.slider1.value];
    self.label2.text = [NSString stringWithFormat:@"%f",self.slider2.value];
    self.label3.text = [NSString stringWithFormat:@"%f",self.slider3.value];
    self.nameHoldingLabel.text = self.someString;
    self.twitterTextField.delegate = self;
    self.githubTextField.delegate = self;
    self.myViewsLayer = [[CALayer alloc] init];
    [self.myViewsLayer setFrame:CGRectMake(70, 170, 180, 180)];
    self.myViewsLayer.cornerRadius = 20.0;
    [self.myViewsLayer setMasksToBounds:YES];
    // If the student has a uiImage in him.
    if(self.currentStudent.uII){
        NSLog(@"im getting called");
        [uIIVPhoto setImage:self.currentStudent.uII];
        uIIVPhoto.layer.cornerRadius = 9.0;
        uIIVPhoto.layer.masksToBounds = YES;
    }
    // Then he has no uIImage stored in him.
    else{
        NSLog(@"no i am");
        [uIIVPhoto setImage:[UIImage imageNamed:@"NoPhotoIcon.jpeg"]];
    }
}

- (IBAction)cameraOptionWasHit:(id)sender{
    NSLog(@"camera was hit");
    UIActionSheet *mySheet; // This UIActionSheet will display some options to the user on how to get the pic.
    //As long as the device has a camera, this first "if" will only be called
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        mySheet = [[UIActionSheet alloc] initWithTitle:@"Pick Photo"
                                              delegate:self
                                     cancelButtonTitle:@"cancel"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@"Camera", @"Photo Library", nil];
        
        // If there is no camera (ipad 1) then just display options to pull a pic from the photo library
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        mySheet = [[UIActionSheet alloc] initWithTitle:@"Warning! There is no camera."
                                              delegate:self
                                     cancelButtonTitle:@"cancel"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@"Photo Library", nil];
        
    } else {
        return; //I'll be damned, what kind of device is this anyways?
    }
    //Now that the UIActionSheet is created, let's display it on top of our other view, so the user can pick where to get the pic.
    [mySheet showFromBarButtonItem:sender animated:YES];
}



//This gets called once the user hits a button (choosing camera, or photo library)
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //Lets get a UIImagePickerController ready because we are going to display it, whether its a camera or photo library.
    UIImagePickerController *myPicker = [[UIImagePickerController alloc] init];
    myPicker.delegate = self; // It will talk back to this controller to let it know what pic it selected.
    myPicker.allowsEditing = YES;
    // If the user hit "camera"
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Camera"]) {
        myPicker.sourceType = UIImagePickerControllerSourceTypeCamera;// Tell the UIImagePickerController that it will take a picture.
        // If the user hit "photo library"
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Photo Library"]) {
        myPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;// Tell the UIImagePickerController that it will use the library.
        // This wont get called, because the user either selected "camera" or "photo library"
    } else {
        return;
    }
    if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied || [ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusRestricted) {
        UIAlertView* message=[[UIAlertView alloc] initWithTitle:@"You need permission to access photos."
                                                message:@"Click the HOME BUTTON then click on SETTINGS. Scroll down to pick PRIVACY, then click on PHOTOS. You will see a switch to enable this app for the photo library." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [message show];
    }
    [self presentViewController:myPicker animated:YES completion:nil];// Lets change to the next controller, whether its a camera or library.
    NSLog(@"is this real?");

    
}


// This method gets called from the UIImagePickerController back to us once we hit "use photo". Because this class is it's delegate.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // This says "close the UIImagePickerController" because it chose a photo, so we dont need it no more.
    [self dismissViewControllerAnimated:YES completion:^{
        //Once it closes, then this huge completeion block gets called:
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerOriginalImage];// Create a uiimage to hold this pic the user wants.
        self.currentStudent.uII = editedImage; // Set the student's image to the image returned.
        [self saveCurrentStudentsUIImage:editedImage];
        // This saves the user's pic to a document directory
        [self saveCurrentStudentsUIImage:self.currentStudent.uII];
        // Tell the calayer that shows the pic, that it needs to load this pic now!
        [self.uIIVPhoto setImage:self.currentStudent.uII];
        self.myViewsLayer.contents = self.currentStudent.uII;
            ALAssetsLibrary *assetsLibrary = [ALAssetsLibrary new]; // This provides access to the videos and photos that are under the control of the Photos application. We need it to authorize us to save the pic to our photo album.
        // If ALAssetsLibrary says i am restricted from accessing the library, then we cant save this pic to the library, so abort.
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied || [ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusRestricted) {
            return;
            // Otherwise, the ALAssetsLibrary isn't specifically restricting us from viewing the pics.
        }
        else {
            //NSLog(@"Metadata: %@", info[UIImagePickerControllerMediaMetadata]);
            // Lets add the pic to our album.
            [assetsLibrary writeImageToSavedPhotosAlbum:editedImage.CGImage
                                            orientation:ALAssetOrientationUp
                                        completionBlock:^(NSURL *assetURL, NSError *error) {
                                            
                                            if (error) {
                                                NSLog(@"%@", error);
                                            }
                                        }];
            
        }
    }];
    // End of completion block.
}


//Save the pic to the documents array
-(void)saveCurrentStudentsUIImage:(UIImage*)anImage{
    if (anImage != nil){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* studentNameString = self.currentStudent.name;
        NSString* path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",studentNameString]];
        NSLog(@"the path is %@" , path);
        NSData* data = UIImageJPEGRepresentation(anImage, 0.5);
        [data writeToFile:path atomically:YES];
    }
}


- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that you want to zoom
    return self.view;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}



@end
