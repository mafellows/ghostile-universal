//
//  FilterViewController.m
//  ghostile
//
//  Created by Michael Fellows on 10/13/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import "FilterViewController.h"
#import "GPUImage.h"
#import "UIColor+MLPFlatColors.h"
#import <Social/Social.h>


@interface FilterViewController () {
    NSArray *array;
    int i;
    GPUImagePicture *stillImageSource;
    UIImage *resultingImage;
    UIImageView *imageView;
    UIActionSheet *saveSheet;
    UIActionSheet *cameraRollSheet;
}

@end

@implementation FilterViewController
@synthesize image = _image;

- (void)viewDidLoad
{
    [super viewDidLoad];
    array = @[@"Swipe To Add Filter",@"Sepia",@"Vignette",@"Exposure",@"Grayscale"];
    i = 0;
    
    // Format navigationBar
    [navigationBar setTintColor:[UIColor blackColor]];     
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, navigationBar.frame.size.height, 320.0, 320.0)];
    [imageView setBounds:CGRectMake(0, 0, 320.0, 320.0)];
    [imageView setImage:_image];
    [self.view addSubview:imageView];
    
    [cancelButton setAction:@selector(dismiss:)];
    [saveButton setAction:@selector(save:)];
    
    // Add Right Swipe Recognizer
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [rightSwipe setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:rightSwipe];
    
    // Add Left Swipe Recognizer
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    [leftSwipe setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:leftSwipe];
    
    // iOS 7 updates
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

-(BOOL)prefersStatusBarHidden
{
    return YES; 
}

#pragma mark - Selector methods
-(void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)save:(id)sender
{
    // Get the image
    UIGraphicsBeginImageContext(CGSizeMake(320.0, 320.0));
    [[imageView image] drawInRect:CGRectMake(0.0, 0.0, 320.0, 320.0) blendMode:kCGBlendModeNormal alpha:1.0];
    resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook] && [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        saveSheet = [[UIActionSheet alloc] initWithTitle:@"Share your Ghostile pic!"
                                                delegate:self
                                       cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:@"Save to Camera Roll", @"Share on Twitter", @"Share on Facebook",  nil];
        [saveSheet showFromRect:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, 320.0, 0)
                         inView:self.view
                       animated:YES];
    } else {
        cameraRollSheet = [[UIActionSheet alloc] initWithTitle:@"Share your Ghostile pic!"
                                                      delegate:self cancelButtonTitle:@"Cancel"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"Save to Camera Roll", nil];
        [cameraRollSheet showFromRect:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, 320.0, 0)
                               inView:self.view
                             animated:YES];
    }
}

#pragma mark - Swipe Recognizer Methods

-(void)swipeRight:(UISwipeGestureRecognizer *)recognizer
{
    if (i == array.count -1) {
        i = 0;
    } else {
        i+=1;
    }

    if (i == 0) {
        resultingImage = _image;
        [imageView setImage:_image];
    } else if (i == 1) {
        // Set up GPUImage
        stillImageSource = [[GPUImagePicture alloc] initWithImage:_image];
        GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
        [stillImageSource addTarget:sepiaFilter];
        [stillImageSource processImage];
        resultingImage = [sepiaFilter imageFromCurrentlyProcessedOutput];
        [imageView setImage:resultingImage];
    } else if (i == 2) {
        stillImageSource = [[GPUImagePicture alloc] initWithImage:_image];
        GPUImageVignetteFilter *vignetteFilter = [[GPUImageVignetteFilter alloc] init];
        [stillImageSource addTarget:vignetteFilter];
        [stillImageSource processImage];
        resultingImage = [vignetteFilter imageFromCurrentlyProcessedOutput];
        [imageView setImage:resultingImage];
    } else if (i == 3) {
        stillImageSource = [[GPUImagePicture alloc] initWithImage:_image];
        GPUImageExposureFilter *exposureFilter = [[GPUImageExposureFilter alloc] init];
        [stillImageSource addTarget:exposureFilter];
        [stillImageSource processImage];
        resultingImage = [exposureFilter imageFromCurrentlyProcessedOutput];
        [imageView setImage:resultingImage];
    } else if (i == 4) {
        stillImageSource = [[GPUImagePicture alloc] initWithImage:_image];
        GPUImageGrayscaleFilter *grayscaleFilter = [[GPUImageGrayscaleFilter alloc] init];
        [stillImageSource addTarget:grayscaleFilter];
        [stillImageSource processImage];
        resultingImage = [grayscaleFilter imageFromCurrentlyProcessedOutput];
        [imageView setImage:resultingImage];
    }
    navigationBar.topItem.title = array[i];
}

-(void)swipeLeft:(UIGestureRecognizer *)recognizer
{
    if (i < 1) {
        i = array.count - 1;
    } else {
        i-=1;
    }
    
    if (i == 0) {
        resultingImage = _image;
        [imageView setImage:_image];
    } else if (i == 1) {
        // Set up GPUImage
        stillImageSource = [[GPUImagePicture alloc] initWithImage:_image];
        GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
        [stillImageSource addTarget:sepiaFilter];
        [stillImageSource processImage];
        resultingImage = [sepiaFilter imageFromCurrentlyProcessedOutput];
        [imageView setImage:resultingImage];
    } else if (i == 2) {
        stillImageSource = [[GPUImagePicture alloc] initWithImage:_image];
        GPUImageVignetteFilter *vignetteFilter = [[GPUImageVignetteFilter alloc] init];
        [stillImageSource addTarget:vignetteFilter];
        [stillImageSource processImage];
        resultingImage = [vignetteFilter imageFromCurrentlyProcessedOutput];
        [imageView setImage:resultingImage];
    } else if (i == 3) {
        stillImageSource = [[GPUImagePicture alloc] initWithImage:_image];
        GPUImageExposureFilter *exposureFilter = [[GPUImageExposureFilter alloc] init];
        [stillImageSource addTarget:exposureFilter];
        [stillImageSource processImage];
        resultingImage = [exposureFilter imageFromCurrentlyProcessedOutput];
        [imageView setImage:resultingImage];
    } else if (i == 4) {
        stillImageSource = [[GPUImagePicture alloc] initWithImage:_image];
        GPUImageGrayscaleFilter *grayscaleFilter = [[GPUImageGrayscaleFilter alloc] init];
        [stillImageSource addTarget:grayscaleFilter];
        [stillImageSource processImage];
        resultingImage = [grayscaleFilter imageFromCurrentlyProcessedOutput];
        [imageView setImage:resultingImage];
    }
    navigationBar.topItem.title = array[i];
}

#pragma mark - Action Sheet Delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
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
