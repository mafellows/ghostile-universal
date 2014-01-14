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
#import "NewFilterViewController.h"
#import "DMActivityInstagram.h"

@interface SecondViewController () {
    UIImage *resultingImage;
    UIBarButtonItem *clearButton;
    CGFloat screenWidth;
    CGRect imageViewRect;
}
-(void)checkText;
@end

@implementation SecondViewController
@synthesize slider = _slider;
@synthesize cameraButton = _cameraButton;
@synthesize saveButton = _saveButton;
@synthesize foregroundImageView = _foregroundImageView;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize backgroundImage = _backgroundImage; 
@synthesize backgroundSliderValue = _backgroundSliderValue;
@synthesize textLabel = _textLabel;
@synthesize toolbar = _toolbar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    screenWidth = [[UIScreen mainScreen] bounds].size.width;
    imageViewRect = CGRectMake(0, 0, screenWidth, screenWidth); 
    
    [self configureNavBar];
    [self configureToolbar];
    [self configureTextLabel];
    [self configureImageViews];
    [self configureButtons];
    [self configureSlider];
    [self addSwipeRecognizer];
    [self handleiOS7];
    [self enableButtons];

    // Camera Button
    [_cameraButton setAction:@selector(showActionSheet:)];
    [_filterButton setAction:@selector(showFilterController:)];
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
    [button setFrame:imageViewRect];
    [self.view addSubview:button];
}

-(void)configureImageViews
{
    // Add backgroundImageView
    _backgroundImageView = [[UIImageView alloc] initWithFrame:imageViewRect];
    [_backgroundImageView setBounds:imageViewRect];
    [_backgroundImageView setImage:_backgroundImage];
    [_backgroundImageView setAlpha:_backgroundSliderValue];
    [self.view addSubview:_backgroundImageView];
    
    // Add foregroundImageView;
    _foregroundImageView = [[UIImageView alloc] initWithFrame:imageViewRect];
    [_foregroundImageView setBounds:imageViewRect];
    [self.view addSubview:_foregroundImageView];
}

-(void)configureNavBar
{
    // Navigation Bar Appearance
    [self.navigationItem setTitle:NSLocalizedString(@"Foreground", nil)];
    clearButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"x-circle.png"]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(clearImage:)];
    [self.navigationItem setRightBarButtonItem:clearButton];
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
    CGFloat startSlider = heightICareAbout - toolbarHeight - (gap / 2) - 20.0;
    
    // Padding for sides of _slider
    CGFloat padding = 15.0;
    
    // Add UISlider
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(padding, startSlider, screenWidth - padding * 2, 40)];
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
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

#pragma mark - Convenience Methods

-(void)enableButtons
{
    if ([_backgroundImageView image] == nil && [_foregroundImageView image] == nil) {
        _filterButton.enabled = NO;
        _saveButton.enabled = NO;
    } else {
        _filterButton.enabled = YES;
        _saveButton.enabled = YES;
    }
    
    if (_foregroundImageView.image == nil) {
        clearButton.enabled = NO;
    } else {
        clearButton.enabled = YES;
    }
}

#pragma mark - Selector

-(void)clearImage:(id)sender
{
    [_foregroundImageView setImage:nil];
    [self checkText];
    [self enableButtons];
}

-(void)checkText
{
    if (!_backgroundImage && ![_foregroundImageView image]) {
        [_textLabel setText:NSLocalizedString(@"Tap For Foreground Pic", nil)];
    } else {
        [_textLabel setText:@""];
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
        UIActionSheet *cameraSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Background Photo", nil)
                                                                 delegate:self
                                                        cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:NSLocalizedString(@"Take New Photo", nil), NSLocalizedString(@"Choose Existing Photo", nil), nil];
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

- (IBAction)saveButtonPressed:(id)sender
{
    DMActivityInstagram *activityInstagram = [[DMActivityInstagram alloc] init];
    resultingImage = [self getResultingImage];
    NSArray *activityItems = @[@"#ghostile", resultingImage, [NSURL URLWithString:@""]];
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

#pragma mark - Photo Delegate   

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [[self foregroundImageView] setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self checkText];
    [self enableButtons];
}


#pragma mark - UIActionSheet

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
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
    }
}

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




















