//
//  FilterViewController.m
//  ghostile
//
//  Created by Michael Fellows on 10/13/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import "FilterViewController.h"
#import "GPUImage.h"


@interface FilterViewController () {
    NSArray *array;
    int i;
    GPUImagePicture *stillImageSource;
    UIImage *resultingImage;
    UIImageView *imageView;
}

@end

@implementation FilterViewController
@synthesize image = _image;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    array = @[@"Swipe To Add Filter",@"Sepia",@"Vignette",@"Exposure",@"Grayscale"];
    i = 0;
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, navigationBar.frame.size.height, 320.0, 320.0)];
    [imageView setBounds:CGRectMake(0, 0, 320.0, 320.0)];
    
    
    
    [imageView setImage:_image];
    [self.view addSubview:imageView];
    
    [cancelButton setAction:@selector(dismiss:)];
    
    // Add Right Swipe Recognizer
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [rightSwipe setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:rightSwipe];
    
    // Add Left Swipe Recognizer
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    [leftSwipe setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:leftSwipe];
    
    // iOS 7 updates
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
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










@end
