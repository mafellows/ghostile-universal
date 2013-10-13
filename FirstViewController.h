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
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

- (IBAction)nextButtonPressed:(id)sender;

@end
