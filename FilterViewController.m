//
//  FilterViewController.m
//  ghostile
//
//  Created by Michael Fellows on 10/13/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import "FilterViewController.h"
#import "GPUImage.h"


@interface FilterViewController ()

@end

@implementation FilterViewController
@synthesize image = _image;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, navigationBar.frame.size.height, 320.0, 320.0)];
    [imageView setBounds:CGRectMake(0, 0, 320.0, 320.0)];
    
    // Set up GPUImage
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_image];
    GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
    [stillImageSource addTarget:sepiaFilter];
    [stillImageSource processImage];
    UIImage *resultingImage = [sepiaFilter imageFromCurrentlyProcessedOutput];
    
    [imageView setImage:resultingImage];
    [self.view addSubview:imageView];
    
    [cancelButton setAction:@selector(dismiss:)];
    
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
@end
