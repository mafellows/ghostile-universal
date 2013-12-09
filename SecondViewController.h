//
//  SecondViewController.h
//  ghostile
//
//  Created by Michael Fellows on 8/24/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>

<<<<<<< HEAD
@interface SecondViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UIViewControllerTransitioningDelegate>
=======
@interface SecondViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate> 
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
{
//    CGFloat backgroundSliderValue;
    IBOutlet UIToolbar *toolbar;
}

@property (strong, nonatomic) IBOutlet UIImageView *foregroundImageView;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;
<<<<<<< HEAD
@property (strong, nonatomic) IBOutlet UIBarButtonItem *filterButton;
=======
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIImage *backgroundImage; 
@property CGFloat backgroundSliderValue;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;
<<<<<<< HEAD
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
=======
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351

- (IBAction)saveButtonPressed:(id)sender;

@end
