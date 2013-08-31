//
//  SecondViewController.h
//  ghostile
//
//  Created by Michael Fellows on 8/24/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate> 
{
    CGFloat backgroundSliderValue;
    IBOutlet UIToolbar *toolbar;
}

@property (strong, nonatomic) IBOutlet UIImageView *foregroundImageView;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIImage *backgroundImage; 
@property CGFloat backgroundSliderValue;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)cameraButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)takePictureButtonPressed:(id)sender;

@end
