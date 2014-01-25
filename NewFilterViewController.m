//
//  NewFilterViewController.m
//  Ghostile
//
//  Created by Michael Fellows on 12/6/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import "NewFilterViewController.h"
#import "FilterCollectionViewCell.h"
#import "GPUImage.h"
#import "DMActivityInstagram.h"

@interface NewFilterViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    GPUImagePicture *stillImageSource;
    UIImage *resultingImage;
    UIView *clearView;
    UIBarButtonItem *rightButton;
    UIImageView *imageView;
    CGFloat screenWidth;
    CGFloat screenHeight;
}

@end

@implementation NewFilterViewController
@synthesize originalImage = _originalImage;

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
    screenWidth = [[UIScreen mainScreen] bounds].size.width;
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    [self configureNavBar]; 
    [self.view setBackgroundColor:[UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0f]];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [_collectionView registerNib:[UINib nibWithNibName:@"FilterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    rightButton.enabled = NO;    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Appearance

-(void)configureNavBar
{
    self.navigationItem.title = NSLocalizedString(@"Add Filter", nil);
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"x-circle.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(dismiss:)];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                 target:self
                                                                                 action:@selector(shareImage:)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:74 / 255 green:72 / 255 blue:78 / 255 alpha:0.75];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                    NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:18.0]};
}

-(void)showViewWithImage:(UIImage *)image
{
    rightButton.enabled = YES;
    CGRect deviceFrame = CGRectMake(0, 0, screenWidth, screenHeight);
    clearView = [[UIView alloc] initWithFrame:deviceFrame];
    clearView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:clearView];
    UIView *transparentView = [[UIView alloc] initWithFrame:deviceFrame];
    UIColor *bg = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    transparentView.backgroundColor = bg;
    [clearView addSubview:transparentView];
    
    imageView = [[UIImageView alloc] initWithImage:image];
    CGFloat y = screenHeight / 2 - screenWidth / 2;
    // NSLog(@"%f", y);
    imageView.frame = CGRectMake(0, y, screenWidth, screenWidth);
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.opaque = YES;
    [clearView addSubview:imageView];
    
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [transparentView addSubview:clearButton];
    [clearButton addTarget:self action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *bottomClearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, y + screenWidth, screenWidth, y)];
    [transparentView addSubview:bottomClearButton];
    [bottomClearButton addTarget:self action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Selector Methods

-(void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dismissView:(id)sender
{
    [clearView removeFromSuperview];
    rightButton.enabled = NO;
}

-(void)shareImage:(id)sender
{
    DMActivityInstagram *activityInstagram = [[DMActivityInstagram alloc] init];
    resultingImage = [self getResultingImage];
    NSArray *activityItems = @[@"#ghostile", resultingImage, [NSURL URLWithString:@""]];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[activityInstagram]];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

-(UIImage *)getResultingImage
{
    // Get the image
    UIGraphicsBeginImageContext(CGSizeMake(screenWidth, screenWidth));
    [imageView.image drawInRect:CGRectMake(0, 0, screenWidth, screenWidth) blendMode:kCGBlendModeNormal alpha:1.0];
    resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage; 
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    cell.imageView.image = [self getFilterAtIndex:indexPath.row withImage:_originalImage];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [UIView transitionWithView:_collectionView duration:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
    }completion:^(BOOL finished) {
        UIImage *imageToShow = [self getFilterAtIndex:indexPath.row withImage:_originalImage];
        [self showViewWithImage:imageToShow];
    }];
}





#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout *)collectionViewLayout
 sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(screenWidth / 2, screenWidth / 2);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - Filter Methods

-(UIImage *)getFilterAtIndex:(NSInteger)n withImage:(UIImage *)image
{
    resultingImage = image;
    stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    if (n == 0) {
        // Do nothing
    } else if (n == 1) {
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
        GPUImageGrayscaleFilter *grayscaleFilter = [[GPUImageGrayscaleFilter alloc] init];
        [stillImageSource addTarget:grayscaleFilter];
        [stillImageSource processImage];
        resultingImage = [grayscaleFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 4) {
        GPUImageEmbossFilter *embossFilter = [[GPUImageEmbossFilter alloc] init];
        [stillImageSource addTarget:embossFilter];
        [stillImageSource processImage];
        resultingImage = [embossFilter imageFromCurrentlyProcessedOutput];
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
        GPUImageSmoothToonFilter *smoothToon = [[GPUImageSmoothToonFilter alloc] init];
        [stillImageSource addTarget:smoothToon];
        [stillImageSource processImage];
        resultingImage = [smoothToon imageFromCurrentlyProcessedOutput];
    } else if (n == 8) {
        GPUImageSketchFilter *sketchFilter = [[GPUImageSketchFilter alloc] init];
        [stillImageSource addTarget:sketchFilter];
        [stillImageSource processImage];
        resultingImage = [sketchFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 9) {
        GPUImageThresholdSketchFilter *sketchFilter2 = [[GPUImageThresholdSketchFilter alloc] init];
        [stillImageSource addTarget:sketchFilter2];
        [stillImageSource processImage];
        resultingImage = [sketchFilter2 imageFromCurrentlyProcessedOutput];
    } else if (n == 10) {
        GPUImageCrosshatchFilter *crossHatchFilter = [[GPUImageCrosshatchFilter alloc] init];
        [stillImageSource addTarget:crossHatchFilter];
        [stillImageSource processImage];
        resultingImage = [crossHatchFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 11) {
        GPUImageHalftoneFilter *halfToneFilter = [[GPUImageHalftoneFilter alloc] init];
        [stillImageSource addTarget:halfToneFilter];
        [stillImageSource processImage];
        resultingImage = [halfToneFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 12) {
        GPUImagePolkaDotFilter *polkaDotFilter = [[GPUImagePolkaDotFilter alloc] init];
        [stillImageSource addTarget:polkaDotFilter];
        [stillImageSource processImage];
        resultingImage = [polkaDotFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 13) {
        GPUImagePixellateFilter *pixelateFilter = [[GPUImagePixellateFilter alloc] init];
        [stillImageSource addTarget:pixelateFilter];
        [stillImageSource processImage];
        resultingImage = [pixelateFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 14) {
        GPUImageSwirlFilter *swirlFilter = [[GPUImageSwirlFilter alloc] init];
        [stillImageSource addTarget:swirlFilter];
        [stillImageSource processImage];
        resultingImage = [swirlFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 15) {
        GPUImageColorInvertFilter *colorInvertFilter = [[GPUImageColorInvertFilter alloc] init];
        [stillImageSource addTarget:colorInvertFilter];
        [stillImageSource processImage];
        resultingImage = [colorInvertFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 16) {
        GPUImageGlassSphereFilter *glassSphereFilter = [[GPUImageGlassSphereFilter alloc] init];
        [stillImageSource addTarget:glassSphereFilter];
        [stillImageSource processImage];
        resultingImage = [glassSphereFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 17) {
        GPUImageStretchDistortionFilter *stretchDistortionFilter = [[GPUImageStretchDistortionFilter alloc] init];
        [stillImageSource addTarget:stretchDistortionFilter];
        [stillImageSource processImage];
        resultingImage = [stretchDistortionFilter imageFromCurrentlyProcessedOutput];
    } else if (n == 18) {
        GPUImagePinchDistortionFilter *pinchDistortion = [[GPUImagePinchDistortionFilter alloc] init];
        [stillImageSource addTarget:pinchDistortion];
        [stillImageSource processImage];
        resultingImage = [pinchDistortion imageFromCurrentlyProcessedOutput];
    } else if (n == 19) {
        GPUImageBulgeDistortionFilter *bulgeFilter = [[GPUImageBulgeDistortionFilter alloc] init];
        [stillImageSource addTarget:bulgeFilter];
        [stillImageSource processImage];
        resultingImage = [bulgeFilter imageFromCurrentlyProcessedOutput];
    }
    return resultingImage;
}




@end
