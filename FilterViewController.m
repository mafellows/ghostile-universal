//
//  FilterViewController.m
//  Ghostile
//
//  Created by Michael Fellows on 10/12/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController
@synthesize filterImageView = _filterImageView;
@synthesize image = _image;

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
    _filterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0, 320.0)];
    [_filterImageView setBounds:CGRectMake(0, 0, 320.0, 320.0)];
    [_filterImageView setImage:_image];
    
    
    [self.view addSubview:_filterImageView]; 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
