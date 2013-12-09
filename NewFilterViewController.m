//
//  NewFilterViewController.m
//  Ghostile
//
//  Created by Michael Fellows on 12/6/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import "NewFilterViewController.h"
#import "FilterCollectionViewCell.h"
#import "FilterDetailView.h"
#import "GPUImage.h"


@interface NewFilterViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    GPUImagePicture *stillImageSource;
    UIImage *resultingImage;
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
    // Do any additional setup after loading the view from its nib.
    [self configureNavBar]; 
    [self.view setBackgroundColor:[UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0f]];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [_collectionView registerNib:[UINib nibWithNibName:@"FilterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Appearance

-(void)configureNavBar
{
    self.navigationItem.title = @"Add Filter";
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"x-circle.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(dismiss:)];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:74 / 255 green:72 / 255 blue:78 / 255 alpha:0.75];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                    NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:18.0]};
}

#pragma mark - Selector Methods

-(void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    cell.imageView.image = [self getFilterAtIndex:indexPath.row withImage:_originalImage];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UINib *nib = [UINib nibWithNibName:@"FilterDetailView" bundle:nil];
    FilterDetailView *filterDetailView = [[nib instantiateWithOwner:self options:nil ] objectAtIndex:0];
    UIImage *imageToShow = [self getFilterAtIndex:indexPath.row withImage:_originalImage];
    [filterDetailView.imageView setImage:imageToShow];
    [self.view addSubview:filterDetailView];
    NSLog(@"%f", filterDetailView.frame.size.height);
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout *)collectionViewLayout
 sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(160, 160);
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
    return resultingImage;
}




@end
