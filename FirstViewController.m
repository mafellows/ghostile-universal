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
@synthesize cameraButtonItem = _cameraButtonItem;
@synthesize nextButton = _nextButton; 


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self slider] setMaximumValue:1.0];
    [[self slider] setMinimumValue:0.0];
    [[self slider] setValue:1.0];
    [[self navigationItem] setTitle:@"Background"];
    
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearImage:)];
    [[self navigationItem] setRightBarButtonItem:clearButton];
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    [swipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:swipeRecognizer]; 
    
    // Appearance
    [[[self navigationController] navigationBar] setTintColor:[UIColor flatGrayColor]];
    [toolbar setTintColor:[UIColor flatGrayColor]];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"p5.png"]];
    [_slider setMinimumTrackTintColor:[UIColor flatDarkBlueColor]];
    

    [[self textLabel] setFont:[UIFont fontWithName:@"Avenir-Light" size:24.0]];
    [self checkText]; 
    
    /*
    // Constraints
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_backgroundImageView, _slider, toolbar);
    NSArray *constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:@"|-[_slider]-[toolbar]-|"
                                                                        options:NSLayoutFormatAlignAllBaseline
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    for (int i=0; i<constraintsArray.count; i++) {
        [self.view addConstraint:constraintsArray[i]]; 
    } */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clearImage:(id)sender
{
    [_backgroundImageView setImage:nil];
    [self checkText]; 
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

- (IBAction)sliderChanged:(id)sender {
    CGFloat sliderValue = [[self slider] value];
    [[self backgroundImageView] setAlpha:sliderValue]; 
}

-(void)checkText
{
    if ([[_backgroundImageView image] isKindOfClass:[UIImage class]]) {
        [[self textLabel] setText:@""]; 
    } else {
        [[self textLabel] setText:@"Tap For Background Pic"];
    }
}


- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Take Photo"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Take New Photo", @"Choose Existing Photo", nil];
        
        [actionSheet showFromBarButtonItem:_cameraButtonItem animated:YES]; 
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

- (IBAction)takePictureButtonPressed:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Take Photo"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Take New Photo", @"Choose Existing Photo", nil];
        
        [actionSheet showFromBarButtonItem:_cameraButtonItem animated:YES];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setDelegate:self];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
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
