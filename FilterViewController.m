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
    NSInteger i;
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
    array = @[@"Swipe To Add Filter",@"Sepia",@"Vignette",@"Emboss",@"Grayscale", @"Blur", @"Cartoon", @"Sketch", @"Swirl", @"Smooth Toon", @"Sketch 2", @"Cross Hatch", @"Half Tone", @"Polka Dot", @"Pixelate", @"Hue Blend", @"Color Inverter", @"Haze Filter", @"Voronoi Filter", @"Mosaic", @"Perlin Noise", @"Kuwahara", @"Glass Sphere", @"Stretch Distortion", @"Pinch Distortion", @"Bulge Filter", @"Burn Blend Filter", @"Saturation", @"Color Blend", @"Color Burn Blend", @"Hard Light Blend" ];
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

#pragma mark - Filter Methods

-(void)getFilterAtIndex:(NSInteger)n
{
    resultingImage = _image;
    [imageView setImage:_image];
    stillImageSource = [[GPUImagePicture alloc] initWithImage:_image];
    if (n == 0) {
        // Do nothing
    } else if (n == 1) {
        // Set up GPUImage
        GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
        [stillImageSource addTarget:sepiaFilter];
        [stillImageSource processImage];
        resultingImage = [sepiaFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 2) {
        GPUImageVignetteFilter *vignetteFilter = [[GPUImageVignetteFilter alloc] init];
        [stillImageSource addTarget:vignetteFilter];
        [stillImageSource processImage];
        resultingImage = [vignetteFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 3) {
        GPUImageEmbossFilter *embossFilter = [[GPUImageEmbossFilter alloc] init];
        [stillImageSource addTarget:embossFilter];
        [stillImageSource processImage];
        resultingImage = [embossFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 4) {
        GPUImageGrayscaleFilter *grayscaleFilter = [[GPUImageGrayscaleFilter alloc] init];
        [stillImageSource addTarget:grayscaleFilter];
        [stillImageSource processImage];
        resultingImage = [grayscaleFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 5) {
        GPUImageGaussianBlurFilter *blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
        [stillImageSource addTarget:blurFilter];
        [stillImageSource processImage];
        resultingImage = [blurFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 6) {
        GPUImageToonFilter *toonFilter = [[GPUImageToonFilter alloc] init];
        [stillImageSource addTarget:toonFilter];
        [stillImageSource processImage];
        resultingImage = [toonFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 7) {
        GPUImageSketchFilter *sketchFilter = [[GPUImageSketchFilter alloc] init];
        [stillImageSource addTarget:sketchFilter];
        [stillImageSource processImage];
        resultingImage = [sketchFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 8) {
        GPUImageSwirlFilter *swirlFilter = [[GPUImageSwirlFilter alloc] init];
        [stillImageSource addTarget:swirlFilter];
        [stillImageSource processImage];
        resultingImage = [swirlFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 9) {
        GPUImageSmoothToonFilter *smoothToon = [[GPUImageSmoothToonFilter alloc] init];
        [stillImageSource addTarget:smoothToon];
        [stillImageSource processImage];
        resultingImage = [smoothToon imageFromCurrentlyProcessedOutput];
    } else if (n == 10) {
        GPUImageThresholdSketchFilter *sketchFilter2 = [[GPUImageThresholdSketchFilter alloc] init];
        [stillImageSource addTarget:sketchFilter2];
        [stillImageSource processImage];
        resultingImage = [sketchFilter2 imageFromCurrentlyProcessedOutput];
    } else if (n == 11) {
        GPUImageCrosshatchFilter *crossHatchFilter = [[GPUImageCrosshatchFilter alloc] init];
        [stillImageSource addTarget:crossHatchFilter];
        [stillImageSource processImage];
        resultingImage = [crossHatchFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 12) {
        GPUImageHalftoneFilter *halfToneFilter = [[GPUImageHalftoneFilter alloc] init];
        [stillImageSource addTarget:halfToneFilter];
        [stillImageSource processImage];
        resultingImage = [halfToneFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 13) {
        GPUImagePolkaDotFilter *polkaDotFilter = [[GPUImagePolkaDotFilter alloc] init];
        [stillImageSource addTarget:polkaDotFilter];
        [stillImageSource processImage];
        resultingImage = [polkaDotFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 14) {
        GPUImagePixellateFilter *pixelateFilter = [[GPUImagePixellateFilter alloc] init];
        [stillImageSource addTarget:pixelateFilter];
        [stillImageSource processImage];
        resultingImage = [pixelateFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 15) {
        GPUImageHueBlendFilter *hueBlendFilter = [[GPUImageHueBlendFilter alloc] init];
        [stillImageSource addTarget:hueBlendFilter];
        [stillImageSource processImage];
        resultingImage = [hueBlendFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 16) {
        GPUImageColorInvertFilter *colorInvertFilter = [[GPUImageColorInvertFilter alloc] init];
        [stillImageSource addTarget:colorInvertFilter];
        [stillImageSource processImage];
        resultingImage = [colorInvertFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 17) {
        GPUImageHazeFilter *hazeFilter = [[GPUImageHazeFilter alloc] init];
        [stillImageSource addTarget:hazeFilter];
        [stillImageSource processImage];
        resultingImage = [hazeFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 18) {
        GPUImageVoronoiConsumerFilter *voronoiFilter = [[GPUImageVoronoiConsumerFilter alloc] init];
        [stillImageSource addTarget:voronoiFilter];
        [stillImageSource processImage];
        resultingImage = [voronoiFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 19) {
        GPUImageMosaicFilter *mosaicFilter = [[GPUImageMosaicFilter alloc] init];
        [stillImageSource addTarget:mosaicFilter];
        [stillImageSource processImage];
        resultingImage = [mosaicFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 20) {
        GPUImagePerlinNoiseFilter *perlinNoiseFilter = [[GPUImagePerlinNoiseFilter alloc] init];
        [stillImageSource addTarget:perlinNoiseFilter];
        [stillImageSource processImage];
        resultingImage = [perlinNoiseFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 21) {
        GPUImageKuwaharaFilter *kuwaharaFilter = [[GPUImageKuwaharaFilter alloc] init];
        [stillImageSource addTarget:kuwaharaFilter];
        [stillImageSource processImage];
        resultingImage = [kuwaharaFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 22) {
        GPUImageGlassSphereFilter *glassSphereFilter = [[GPUImageGlassSphereFilter alloc] init];
        [stillImageSource addTarget:glassSphereFilter];
        [stillImageSource processImage];
        resultingImage = [glassSphereFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 23) {
        GPUImageStretchDistortionFilter *stretchDistortionFilter = [[GPUImageStretchDistortionFilter alloc] init];
        [stillImageSource addTarget:stretchDistortionFilter];
        [stillImageSource processImage];
        resultingImage = [stretchDistortionFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 24) {
        GPUImagePinchDistortionFilter *pinchDistortion = [[GPUImagePinchDistortionFilter alloc] init];
        [stillImageSource addTarget:pinchDistortion];
        [stillImageSource processImage];
        resultingImage = [pinchDistortion imageFromCurrentlyProcessedOutput];
    } else if (n == 25) {
        GPUImageBulgeDistortionFilter *bulgeFilter = [[GPUImageBulgeDistortionFilter alloc] init];
        [stillImageSource addTarget:bulgeFilter];
        [stillImageSource processImage];
        resultingImage = [bulgeFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 25) {
        GPUImageLinearBurnBlendFilter *burnBlendFilter = [[GPUImageLinearBurnBlendFilter alloc] init];
        [stillImageSource addTarget:burnBlendFilter];
        [stillImageSource processImage];
        resultingImage = [burnBlendFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 26) {
        GPUImageSaturationBlendFilter *saturationBlendFilter = [[GPUImageSaturationBlendFilter alloc] init];
        [stillImageSource addTarget:saturationBlendFilter];
        [stillImageSource processImage];
        resultingImage = [saturationBlendFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 27) {
        GPUImageColorBlendFilter *colorBlendFilter = [[GPUImageColorBlendFilter alloc] init];
        [stillImageSource addTarget:colorBlendFilter];
        [stillImageSource processImage];
        resultingImage = [colorBlendFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 28) {
        GPUImageColorBurnBlendFilter *colorBurnBlendFilter = [[GPUImageColorBurnBlendFilter alloc] init];
        [stillImageSource addTarget:colorBurnBlendFilter];
        [stillImageSource processImage];
        resultingImage = [colorBurnBlendFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 29) {
        GPUImageHardLightBlendFilter *hardLightBlend = [[GPUImageHardLightBlendFilter alloc] init];
        [stillImageSource addTarget:hardLightBlend];
        [stillImageSource processImage];
        resultingImage = [hardLightBlend imageFromCurrentlyProcessedOutput];
    }
    [imageView setImage:resultingImage];
    navigationBar.topItem.title = array[n];
}

#pragma mark - Swipe Recognizer Methods

-(void)swipeRight:(UISwipeGestureRecognizer *)recognizer
{
    if (i == array.count -1) {
        i = 0;
    } else {
        i+=1;
    }

    [self getFilterAtIndex:i];
}

-(void)swipeLeft:(UIGestureRecognizer *)recognizer
{
    if (i < 1) {
        i = array.count - 1;
    } else {
        i-=1;
    }
    [self getFilterAtIndex:i]; 
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

#pragma mark - UIAlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
