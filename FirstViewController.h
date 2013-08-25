//
//  FirstViewController.h
//  ghostile
//
//  Created by Michael Fellows on 8/23/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
{
    IBOutlet UIToolbar *toolbar;
}
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cameraButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *nextButton;


- (IBAction)sliderChanged:(id)sender;
- (IBAction)takePicture:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;
- (IBAction)takePictureButtonPressed:(id)sender;


@end
