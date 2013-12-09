//
//  FirstViewController.m
//  ghostile
//
//  Created by Michael Fellows on 8/23/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "UIColor+MLPFlatColors.h"
<<<<<<< HEAD
#import "SettingsViewController.h"
=======
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351

@interface FirstViewController () 
@end

@implementation FirstViewController
@synthesize backgroundImageView = _backgroundImageView;
@synthesize slider = _slider;
@synthesize cameraButton = _cameraButton;
@synthesize nextButton = _nextButton;
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
    [self setNeedsStatusBarAppearanceUpdate];
    [self configureTextLabel];
    [self configureImageView];
    [self configureClearButton];
    [self configureSlider];
    [self handleiOS7];
    
    // Test
//    [self.view setUserInteractionEnabled:YES];
    
    // CameraButtonItem
    [self.cameraButton setAction:@selector(showActionSheet:)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setTitle:@"Background"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationItem setTitle:@""];
}

#pragma mark - Appearance methods

-(void)configureClearButton
{
=======
    // Configure Navigation Bar
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(clearImage:)];
    [self.navigationItem setRightBarButtonItem:clearButton];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [toolbar setTintColor:[UIColor blackColor]];

    // Configure UITextLabel
    [self.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24.0]];
    [self checkText];
    
    // Add UIImageView
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0, 320.0)];
    [_backgroundImageView setBounds:CGRectMake(0, 0, 320.0, 320.0)];
    [self.view addSubview:_backgroundImageView];
    
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
    // Add button over image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 320.0, 320.0)]; // Abstract the frame size
    [self.view addSubview:button];
    
<<<<<<< HEAD
    // Add Swipe Recognizer
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    [swipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [button addGestureRecognizer:swipeRecognizer];
    
}

-(void)configureImageView
{
    // Add UIImageView
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0, 320.0)];
    [_backgroundImageView setBounds:CGRectMake(0, 0, 320.0, 320.0)];
    [self.view addSubview:_backgroundImageView];
}

-(void)configureNavBar
{
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"_Gear.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(showSettings:)];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"x-circle.png"]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(clearImage:)];
    
    [self.navigationItem setRightBarButtonItem:clearButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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
=======
    // Configure starting point for UISlider
    CGFloat toolbarHeight = toolbar.frame.size.height;
    CGFloat imageHeight = 320.0;
    CGFloat offset = 36.0;
    CGFloat viewHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat gap = viewHeight - imageHeight - toolbarHeight;
    CGFloat startSlider = imageHeight + (gap / 2) - offset;
    CGFloat padding = 15.0;
    
    // Add UISlider
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(padding, startSlider, self.view.frame.size.width - padding * 2, 20)];
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
    [_slider setMaximumValue:1.0];
    [_slider setMinimumValue:0.0];
    [_slider setValue:1.0];
    [_slider addTarget:self
                action:@selector(sliderChanged:)
      forControlEvents:UIControlEventValueChanged];
<<<<<<< HEAD
    
    _slider.minimumTrackTintColor = [UIColor colorWithRed:102.0 / 255.0 green:204.0 / 255.0 blue:204.0 / 255.0 alpha:1.0];
    [self.view addSubview:_slider];
}

-(void)configureTextLabel
{
    // Configure UITextLabel
    [self.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24.0]];
    [self checkText];
    
}

-(void)configureToolbar
{
    _toolbar.tintColor = [UIColor whiteColor];
    self.navigationController.toolbar.barTintColor = [UIColor colorWithRed:74 / 255 green:72 / 255 blue:78 / 255 alpha:0.9];
    _toolbar.barTintColor = [UIColor colorWithRed:74 / 255 green:72 / 255 blue:78 / 255 alpha:0.75];
}

#pragma mark - System Methods

-(void)handleiOS7
{
    // iOS 7 updates
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent; 
}


=======
    [self.view addSubview:_slider];
    
    // Test
    [self.view setUserInteractionEnabled:YES];
    
    // CameraButtonItem
    [self.cameraButton setAction:@selector(showActionSheet:)];
    
    // Add Swipe Recognizer
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    [swipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [button addGestureRecognizer:swipeRecognizer];
    
    // iOS 7 updates
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

// Hide status bar for iOS 7 devices
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - View Methods
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setTitle:@"Background"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationItem setTitle:@""];
}

>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
#pragma mark - Selector Metods
-(void)clearImage:(id)sender
{
    [_backgroundImageView setImage:nil];
    [self checkText];
}

-(void)sliderChanged:(id)sender
{
    CGFloat sliderValue = [_slider value];
    [_backgroundImageView setAlpha:sliderValue];
}

-(void)checkText
{
    if ([[_backgroundImageView image] isKindOfClass:[UIImage class]]) {
        [self.textLabel setText:@""];
    } else {
        [self.textLabel setText:@"Tap For Background Pic"];
    }
}

-(void)showActionSheet:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Take Photo"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Take New Photo", @"Choose Existing Photo", nil];
        
        [actionSheet showFromBarButtonItem:_cameraButton animated:YES];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setDelegate:self];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    [self checkText];
}

<<<<<<< HEAD
-(void)showSettings:(id)sender
{
    SettingsViewController *svc = [[SettingsViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:svc];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

=======
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
- (IBAction)nextButtonPressed:(id)sender {
    UIImage *selectedImage = [[self backgroundImageView] image];
    CGFloat sliderValue = [[self slider] value]; 
    SecondViewController *svc = [[SecondViewController alloc] init];
    // Setter methods
    [svc setBackgroundImage:selectedImage];
<<<<<<< HEAD
    [svc setBackgroundSliderValue:sliderValue];
=======
    [svc setBackgroundSliderValue:sliderValue]; 
    
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
    [[self navigationController] pushViewController:svc animated:YES]; 
}

-(void)swipeRecognized:(UISwipeGestureRecognizer *)recognizer
{
    UIImage *selectedImage = [[self backgroundImageView] image];
    CGFloat sliderValue = [[self slider] value];
    SecondViewController *svc = [[SecondViewController alloc] init];
    // Setter methods
    [svc setBackgroundImage:selectedImage];
    [svc setBackgroundSliderValue:sliderValue];
<<<<<<< HEAD
=======
    
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
    [[self navigationController] pushViewController:svc animated:YES];
}

#pragma mark - Photo elements

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage]; 
    [[self backgroundImageView] setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self checkText]; 
}

#pragma mark - UIActionSheet

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if (buttonIndex == 0) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else if (buttonIndex == 1) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil]; 
    }
<<<<<<< HEAD
=======
    
>>>>>>> c1211f40aa532bed86377eb5fccc6bd439429351
    [imagePicker setDelegate:self]; 
}
@end
