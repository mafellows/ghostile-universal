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
<<<<<<< HEAD
#import "ADVAnimationController.h"
#import "ZoomAnimationController.h"
#import "NewFilterViewController.h"
#import "DMActivityInstagram.h"
=======
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351

@interface SecondViewController () {
    UIActionSheet *cameraSheet;
    UIActionSheet *saveSheet;
    UIActionSheet *cameraRollSheet;
    UIImage *resultingImage;
}
<<<<<<< HEAD
-(void)checkText;
=======
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
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
<<<<<<< HEAD
@synthesize toolbar = _toolbar; 
=======
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351

- (void)viewDidLoad
{
    [super viewDidLoad];
<<<<<<< HEAD
    [self configureNavBar];
    [self configureToolbar];
    [self configureTextLabel];
    [self configureImageViews];
    [self configureButtons];
    [self configureSlider];
    [self addSwipeRecognizer];
    [self handleiOS7];

    // Camera Button
    [_cameraButton setAction:@selector(showActionSheet:)];
    [_filterButton setAction:@selector(showFilterController:)]; 
    
    _saveButton.enabled = [self areImages];
}

#pragma mark - Appearance

-(void)addSwipeRecognizer
{
    // Add swipe recognizer
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(swipeBack:)];
    [swipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:swipeRecognizer];
}

-(void)configureButtons
{
    
    // Add button over image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 320.0, 320.0)]; // Abstract the frame size
    [self.view addSubview:button];
}

-(void)configureImageViews
{
=======
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
    
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
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
<<<<<<< HEAD
}

-(void)configureNavBar
{
    // Navigation Bar Appearance
    [self.navigationItem setTitle:@"Foreground"];
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"x-circle.png"]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(clearImage:)];
    [self.navigationItem setRightBarButtonItem:clearButton];
    [toolbar setTintColor:[UIColor blackColor]];
}

-(void)configureSlider
{
    // Configure starting point for UISlider
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat toolbarHeight = _toolbar.frame.size.height;
    CGFloat imageHeight = _backgroundImageView.frame.size.height;
    CGFloat viewHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat heightICareAbout = viewHeight - statusBarHeight - navBarHeight;
    CGFloat gap = heightICareAbout - imageHeight - toolbarHeight;
    CGFloat startSlider = heightICareAbout - toolbarHeight - (gap / 2) - 20.0; // 20pt offset
    
    // Padding for sides of _slider
    CGFloat padding = 15.0;
    
    // Add UISlider
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(padding, startSlider, self.view.frame.size.width - padding * 2, 40)];
    [_slider setMaximumValue:1.0];
    [_slider setMinimumValue:0.0];
    [_slider setValue:1.0];
    [_slider addTarget:self
                action:@selector(sliderValueChanged:)
      forControlEvents:UIControlEventValueChanged];
    _slider.minimumTrackTintColor = [UIColor colorWithRed:102.0 / 255.0 green:204.0 / 255.0 blue:204.0 / 255.0 alpha:1.0];
    [self.view addSubview:_slider];
}

-(void)configureTextLabel
{
    [self.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24.0]];
    [self checkText];
}

-(void)configureToolbar
{
    _toolbar.tintColor = [UIColor whiteColor];
    self.navigationController.toolbar.barTintColor = [UIColor colorWithRed:74 / 255 green:72 / 255 blue:78 / 255 alpha:0.9];
    _toolbar.barTintColor = [UIColor colorWithRed:74 / 255 green:72 / 255 blue:78 / 255 alpha:0.75];
}

#pragma mark - System misc. 

-(void)handleiOS7
{
=======
    
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
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

<<<<<<< HEAD
#pragma mark - Convenience Methods

-(BOOL)areImages
{
    if ([_backgroundImageView image] == nil && [_foregroundImageView image] == nil) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - Selector

=======
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
-(void)clearImage:(id)sender
{
    [_foregroundImageView setImage:nil];
    [self checkText];
    // Check the status of the background image - Make this a method?
<<<<<<< HEAD
    _saveButton.enabled = [self areImages];
=======
    if ([_backgroundImageView image] == nil && [_foregroundImageView image] == nil) {
        [_saveButton setEnabled:NO];
    }
    
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
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

<<<<<<< HEAD
- (IBAction)saveButtonPressed:(id)sender
{
    DMActivityInstagram *activityInstagram = [[DMActivityInstagram alloc] init];
    resultingImage = [self getResultingImage];
    NSArray *activityItems = @[@"Hello World", resultingImage, [NSURL URLWithString:@""]];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[activityInstagram]];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

-(void)showFilterController:(id)sender
{
    NewFilterViewController *fvc = [[NewFilterViewController alloc] init];
    resultingImage = [self getResultingImage]; 
    [fvc setOriginalImage:resultingImage];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:fvc];
    [self presentViewController:navController animated:YES completion:nil];
}
=======
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

>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351

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
<<<<<<< HEAD

#pragma mark - Get current image 
-(UIImage *)getResultingImage
{
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
    return resultingImage;
}

@end




















=======
@end
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
