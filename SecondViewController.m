//
//  SecondViewController.m
//  ghostile
//
//  Created by Michael Fellows on 8/24/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import "SecondViewController.h"
#import <Social/Social.h> 

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize slider = _slider;
@synthesize cameraButton = _cameraButton;
@synthesize saveButton = _saveButton;
@synthesize foregroundImageView = _foregroundImageView;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize backgroundImage = _backgroundImage; 
@synthesize backgroundSliderValue; 




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
    // Do any additional setup after loading the view from its nib.
    [[self slider] setMaximumValue:1.0];
    [[self slider] setMinimumValue:0.0];
    [[self slider] setValue:1.0];
    [[self navigationItem] setTitle:@"Foreground"];
    
    [[self backgroundImageView] setImage:_backgroundImage];
    [[self backgroundImageView] setAlpha:backgroundSliderValue];
    
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearImage:)];
    [[self navigationItem] setRightBarButtonItem:clearButton]; 
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack:)];
    [swipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:swipeRecognizer];
    
    // Appearance
    [toolbar setTintColor:[UIColor blackColor]]; 
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"p5.png"]];
    [_slider setMinimumTrackTintColor:[UIColor darkGrayColor]]; 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValueChanged:(id)sender {
    CGFloat sliderValue = [[self slider] value];
    [[self foregroundImageView] setAlpha:sliderValue]; 
}

-(void)clearImage:(id)sender
{
    [_foregroundImageView setImage:nil]; 
}

-(void)swipeBack:(UISwipeGestureRecognizer *)recognizer
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)cameraButtonPressed:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Take Photo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take New Photo", @"Choose Existing Photo", nil];
        [actionSheet showFromBarButtonItem:_cameraButton animated:YES];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setDelegate:self];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
}

- (IBAction)saveButtonPressed:(id)sender {
    
    float width = [[self backgroundImageView] bounds].size.width;
    float height = [[self backgroundImageView] bounds].size.height;
    CGFloat backgroundAlpha = [self backgroundSliderValue];
    CGFloat foregroundAlpha = [[self slider] value];
    
    NSLog(@"Slider value: %f", foregroundAlpha);
    
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [[[self backgroundImageView] image] drawInRect:CGRectMake(0.0, 0.0, width, height) blendMode:kCGBlendModeNormal alpha:backgroundAlpha];
    [[[self foregroundImageView] image] drawInRect:CGRectMake(0, 0, width, height) blendMode:kCGBlendModeNormal alpha:foregroundAlpha];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); 
    
    UIImageWriteToSavedPhotosAlbum(resultingImage, nil, nil, nil);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved"
                                                    message:@"Image saved to camera roll"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    
    [alert show];
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Check out my awesome ghost pick from #ghostile"];
        [tweetSheet addImage:resultingImage];
        [self presentViewController:tweetSheet animated:YES completion:nil] ; 
    }
}

- (IBAction)takePictureButtonPressed:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Take Photo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take New Photo", @"Choose Existing Photo", nil];
        [actionSheet showFromBarButtonItem:_cameraButton animated:YES];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setDelegate:self];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}


#pragma mark - Photo Delegate   

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [[self foregroundImageView] setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil]; 
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
