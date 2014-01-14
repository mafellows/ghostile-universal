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
#import "SettingsViewController.h"
#import "EAIntroPage.h"
#import "EAIntroView.h"

@interface FirstViewController () <EAIntroDelegate> {
    CGFloat screenWidth;
    CGRect imageViewRect;
}
@end

@implementation FirstViewController
@synthesize backgroundImageView = _backgroundImageView;
@synthesize slider = _slider;
@synthesize cameraButton = _cameraButton;
@synthesize nextButton = _nextButton;
@synthesize toolbar = _toolbar;


- (void)viewDidLoad
{
    [super viewDidLoad];
    screenWidth = [[UIScreen mainScreen] bounds].size.width;
    imageViewRect = CGRectMake(0, 0, screenWidth, screenWidth);

    [self configureNavBar];
    [self configureToolbar];
    [self setNeedsStatusBarAppearanceUpdate];
    [self configureTextLabel];
    [self configureImageView];
    [self configureClearButton];
    [self configureSlider];
    [self handleiOS7];
    
    // EAIntroView
    [self showIntro];
    
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
    // Add button over image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setFrame:imageViewRect];
    [self.view addSubview:button];
    
    // Add Swipe Recognizer
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    [swipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [button addGestureRecognizer:swipeRecognizer];
    
}

-(void)configureImageView
{
    // Add UIImageView
    _backgroundImageView = [[UIImageView alloc] initWithFrame:imageViewRect];
    [_backgroundImageView setBounds:imageViewRect];
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
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(padding, startSlider, screenWidth - padding * 2, 40)];
    [_slider setMaximumValue:1.0];
    [_slider setMinimumValue:0.0];
    [_slider setValue:1.0];
    [_slider addTarget:self
                action:@selector(sliderChanged:)
      forControlEvents:UIControlEventValueChanged];
    
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
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Foreground Photo"
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

-(void)showSettings:(id)sender
{
    SettingsViewController *svc = [[SettingsViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:svc];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

- (IBAction)nextButtonPressed:(id)sender {
    UIImage *selectedImage = [[self backgroundImageView] image];
    CGFloat sliderValue = [[self slider] value]; 
    SecondViewController *svc = [[SecondViewController alloc] init];
    [svc setBackgroundImage:selectedImage];
    [svc setBackgroundSliderValue:sliderValue];
    [[self navigationController] pushViewController:svc animated:YES]; 
}

-(void)swipeRecognized:(UISwipeGestureRecognizer *)recognizer
{
    UIImage *selectedImage = [[self backgroundImageView] image];
    CGFloat sliderValue = [[self slider] value];
    SecondViewController *svc = [[SecondViewController alloc] init];
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

#pragma mark - EAIntro

-(void)showIntro
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger appLaunchAmounts = [userDefaults integerForKey:@"LaunchAmounts"];
    
    if (appLaunchAmounts < 1) {
        EAIntroPage *page1 = [EAIntroPage page];
        page1.title = @"Welcome to Ghostile!";
        page1.desc = @"Tap the screen to select your background photo.";
        if ([UIScreen mainScreen].bounds.size.height < 568.0) {
            page1.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro1.png"] convertToSize:CGSizeMake(176, 312)];
        } else {
            page1.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro1.png"] convertToSize:CGSizeMake(224, 398)];
        }
        
        
        EAIntroPage *page2 = [EAIntroPage page];
        page2.title = @"We selected an ocean picture!";
        page2.desc = @"Swipe right or hit the next button to select another picture.";
        if ([UIScreen mainScreen].bounds.size.height < 568.0) {
            page2.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro2.png"] convertToSize:CGSizeMake(176, 312)];
        } else {
            page2.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro2.png"] convertToSize:CGSizeMake(224, 398)];
        }
        
        EAIntroPage *page3 = [EAIntroPage page];
        page3.title = @"Use Ghostile as the foreground.";
        page3.desc = @"But this isn't very cool. What's next?";
        if ([UIScreen mainScreen].bounds.size.height < 568.0) {
            page3.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro3.png"] convertToSize:CGSizeMake(176, 312)];
        } else {
            page3.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro3.png"] convertToSize:CGSizeMake(224, 398)];
        }
        
        EAIntroPage *page4 = [EAIntroPage page];
        page4.title = @"Adjust the transparency slider.";
        page4.desc = @"Fade to what looks best. Now this is better.";
        if ([UIScreen mainScreen].bounds.size.height < 568.0) {
            page4.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro4.png"] convertToSize:CGSizeMake(176, 312)];
        } else {
            page4.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro4.png"] convertToSize:CGSizeMake(224, 398)];
        }
        
        EAIntroPage *page5 = [EAIntroPage page];
        page5.title = @"Let's add a filter!";
        page5.desc = @"Tap which filter you like best";
        if ([UIScreen mainScreen].bounds.size.height < 568.0) {
            page5.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro5.png"] convertToSize:CGSizeMake(176, 312)];
        } else {
            page5.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro5.png"] convertToSize:CGSizeMake(224, 398)];
        }
        
        EAIntroPage *page6 = [EAIntroPage page];
        page6.title = @"This one looks cool...";
        page6.desc = @"Tap the share button in the top right.";
        if ([UIScreen mainScreen].bounds.size.height < 568.0) {
            page6.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro6.png"] convertToSize:CGSizeMake(176, 312)];
        } else {
            page6.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro6.png"] convertToSize:CGSizeMake(224, 398)];
        }
        
        EAIntroPage *page7 = [EAIntroPage page];
        page7.title = @"Share your picture!";
        page7.desc = @"Facebook, Twitter, Instagram. Or just keep it for yourself.";
        if ([UIScreen mainScreen].bounds.size.height < 568.0) {
            page7.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro7.png"] convertToSize:CGSizeMake(176, 312)];
        } else {
            page7.titleImage = [self imageWithImage:[UIImage imageNamed:@"intro7.png"] convertToSize:CGSizeMake(224, 398)];
        }
        
        EAIntroView *introView = [[EAIntroView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) andPages:@[page1, page2, page3, page4, page5, page6, page7]];
        [introView showInView:self.navigationController.view animateDuration:0.0];
    }
    [userDefaults setInteger:appLaunchAmounts+1 forKey:@"LaunchAmounts"];
}

-(UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}
@end
