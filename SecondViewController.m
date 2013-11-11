//
//  SecondViewController.m
//  ghostile
//
//  Created by Michael Fellows on 8/24/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import "SecondViewController.h"
#import "FilterViewController.h"
#import <Social/Social.h> 
#import "UIColor+MLPFlatColors.h"

@interface SecondViewController () {
    UIActionSheet *cameraSheet;
    UIActionSheet *saveSheet;
    UIActionSheet *cameraRollSheet;
    UIImage *resultingImage;
}
@end

@implementation SecondViewController
@synthesize slider = _slider;
@synthesize cameraButton = _cameraButton;
@synthesize saveButton = _saveButton;
@synthesize foregroundImageView = _foregroundImageView;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize backgroundImage = _backgroundImage; 
@synthesize backgroundSliderValue;
@synthesize textLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Navigation Bar Appearance
    [self.navigationItem setTitle:@"Foreground"];
    
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                 target:self
                                                                                 action:@selector(clearImage:)];
    [self.navigationItem setRightBarButtonItem:clearButton];
    [toolbar setTintColor:[UIColor blackColor]];
    
    // Configure Text Label
    [self.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24.0]];
    [self checkText];
    
    // Add backgroundImageView
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0, 320.0)];
    [_backgroundImageView setBounds:CGRectMake(0, 0, 320.0, 320.0)];
    [_backgroundImageView setImage:_backgroundImage];
    [_backgroundImageView setAlpha:backgroundSliderValue];
    [self.view addSubview:_backgroundImageView];
    
    // Add foregroundImageView;
    _foregroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0, 320.0)];
    [_foregroundImageView setBounds:CGRectMake(0, 0, 320.0, 320.0)];
    [self.view addSubview:_foregroundImageView];
    
    // Add button over image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 320.0, 320.0)]; // Abstract the frame size
    [self.view addSubview:button];
    
    // Configure starting point for UISlider
    CGFloat toolbarHeight = toolbar.frame.size.height;
    CGFloat imageHeight = 320.0;
    CGFloat offset = 36.0;
    CGFloat viewHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat gap = viewHeight - imageHeight - toolbarHeight;
    CGFloat startSlider = imageHeight + (gap / 2) - offset;
    CGFloat padding = 15.0;
    
    // Add UISlider
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(padding, startSlider, self.view.frame.size.width - padding * 2, 20.0)];
    [_slider addTarget:self
                action:@selector(sliderValueChanged:)
      forControlEvents:UIControlEventValueChanged];
    [_slider setMaximumValue:1.0];
    [_slider setMinimumValue:0.0];
    [_slider setValue:1.0];
    [self.view addSubview:_slider];
    
    // Add swipe recognizer
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(swipeBack:)];
    [swipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:swipeRecognizer];
    
    // Camera Button
    [_cameraButton setAction:@selector(showActionSheet:)];
    
    // Check the status of the background image - Make this a method?
    if ([_backgroundImageView image] == nil && [_foregroundImageView image] == nil) {
        [_saveButton setEnabled:NO]; 
    }
    
    // iOS 7 updates
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)clearImage:(id)sender
{
    [_foregroundImageView setImage:nil];
    [self checkText];
    // Check the status of the background image - Make this a method?
    if ([_backgroundImageView image] == nil && [_foregroundImageView image] == nil) {
        [_saveButton setEnabled:NO];
    }
    
}

-(void)checkText
{
    if (!_backgroundImage && ![_foregroundImageView image]) {
        [textLabel setText:@"Tap For Foreground Pic"];
    } else {
        [textLabel setText:@""];
    }
}

-(void)swipeBack:(UISwipeGestureRecognizer *)recognizer
{
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Selector methods
-(void)showActionSheet:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        cameraSheet = [[UIActionSheet alloc] initWithTitle:@"Take Photo"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Take New Photo", @"Choose Existing Photo", @"Add Filter", nil];
        
        [cameraSheet showFromBarButtonItem:_cameraButton animated:YES];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setDelegate:self];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    [self checkText];
}

-(void)sliderValueChanged:(id)sender
{
    CGFloat sliderValue = [_slider value];
    [_foregroundImageView setAlpha:sliderValue];
}

- (IBAction)saveButtonPressed:(id)sender {
    
    float width = [[self backgroundImageView] bounds].size.width;
    float height = [[self backgroundImageView] bounds].size.height;
    CGFloat backgroundAlpha = [self backgroundSliderValue];
    CGFloat foregroundAlpha = [[self slider] value];
    
    // Get the image
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [[[self backgroundImageView] image] drawInRect:CGRectMake(0.0, 0.0, width, height) blendMode:kCGBlendModeNormal alpha:backgroundAlpha];
    [[[self foregroundImageView] image] drawInRect:CGRectMake(0, 0, width, height) blendMode:kCGBlendModeNormal alpha:foregroundAlpha];
    resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook] && [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        saveSheet = [[UIActionSheet alloc] initWithTitle:@"Share your Ghostile pic!"
                                                delegate:self
                                       cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:@"Save to Camera Roll", @"Share on Twitter", @"Share on Facebook",  nil];
        [saveSheet showFromBarButtonItem:_cameraButton animated:YES];
    } else {
        cameraRollSheet = [[UIActionSheet alloc] initWithTitle:@"Share your Ghostile pic!"
                                                delegate:self cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:@"Save to Camera Roll", nil];
        [cameraRollSheet showFromBarButtonItem:_cameraButton animated:YES];
    }
}


#pragma mark - Photo Delegate   

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [[self foregroundImageView] setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self checkText];
    if (![_saveButton isEnabled]) {
        [_saveButton setEnabled:YES];
    }
}


#pragma mark - UIActionSheet

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == cameraSheet) {

        if (buttonIndex == 0) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            imagePicker.allowsEditing = YES;
            [imagePicker setDelegate:self];
            [self presentViewController:imagePicker animated:YES completion:nil];
        } else if (buttonIndex == 1) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            imagePicker.allowsEditing = YES;
            [imagePicker setDelegate:self];
            [self presentViewController:imagePicker animated:YES completion:nil];
        } else if (buttonIndex == 2) {
            // Get numbers for the image context
            float width = [[self backgroundImageView] bounds].size.width;
            float height = [[self backgroundImageView] bounds].size.height;
            CGFloat backgroundAlpha = [self backgroundSliderValue];
            CGFloat foregroundAlpha = [[self slider] value];
            
            // Get the image
            UIGraphicsBeginImageContext(CGSizeMake(width, height));
            [[[self backgroundImageView] image] drawInRect:CGRectMake(0.0, 0.0, width, height) blendMode:kCGBlendModeNormal alpha:backgroundAlpha];
            [[[self foregroundImageView] image] drawInRect:CGRectMake(0, 0, width, height) blendMode:kCGBlendModeNormal alpha:foregroundAlpha];
            resultingImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            // Check if there's an image to filter!
            if ([_backgroundImageView image] == nil && [_foregroundImageView image] == nil) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Ghostile Image"
                                                                message:@"Take some pictures before adding filters"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            } else {
                // Add Filter View Controller
                FilterViewController *fvc = [[FilterViewController alloc] init];
                [fvc setImage:resultingImage];
                [self presentViewController:fvc animated:YES completion:nil];
            }
            
        }

    }
    
    if (actionSheet == cameraRollSheet) {
        if (buttonIndex == 0) {
            UIImageWriteToSavedPhotosAlbum(resultingImage, nil, nil, nil);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved"
                                                            message:@"Image saved to camera roll"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    if (actionSheet == saveSheet) {
        if (buttonIndex == 0) {
            UIImageWriteToSavedPhotosAlbum(resultingImage, nil, nil, nil);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved"
                                                            message:@"Image saved to camera roll"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        } else if (buttonIndex == 1) {
            SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:@"Check out my awesome ghost pick from #ghostile"];
            [tweetSheet addImage:resultingImage];
            [self presentViewController:tweetSheet animated:YES completion:nil];
        } else if (buttonIndex == 2) {
            SLComposeViewController *facebookSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [facebookSheet setInitialText:@"Great picture made with Ghostile!"];
            [facebookSheet addImage:resultingImage];
            [self presentViewController:facebookSheet animated:YES completion:nil];
        }
        
    }
}
@end
