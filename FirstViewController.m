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

@interface FirstViewController () 
@end

@implementation FirstViewController
@synthesize backgroundImageView = _backgroundImageView;
@synthesize slider = _slider;
@synthesize cameraButton = _cameraButton;
@synthesize nextButton = _nextButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(padding, startSlider, self.view.frame.size.width - padding * 2, 0)];
    [_slider setMaximumValue:1.0];
    [_slider setMinimumValue:0.0];
    [_slider setValue:1.0];
    [_slider addTarget:self
                action:@selector(sliderChanged:)
      forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    
    // CameraButtonItem
    [self.cameraButton setAction:@selector(showActionSheet:)];
    
    // Add Swipe Recognizer
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    [swipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:swipeRecognizer];
    
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

- (IBAction)nextButtonPressed:(id)sender {
    UIImage *selectedImage = [[self backgroundImageView] image];
    CGFloat sliderValue = [[self slider] value]; 
    SecondViewController *svc = [[SecondViewController alloc] init];
    // Setter methods
    [svc setBackgroundImage:selectedImage];
    [svc setBackgroundSliderValue:sliderValue]; 
    
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
    
    [imagePicker setDelegate:self]; 
}
@end
