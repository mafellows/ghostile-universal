//
//  ScreenshotViewController.m
//  ghostile
//
//  Created by Michael Fellows on 8/25/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import "ScreenshotViewController.h"
#import "UIColor+MLPFlatColors.h"

@interface ScreenshotViewController ()

@end

@implementation ScreenshotViewController

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
    [self.view setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"p5.png"]]];
    [[self navigationItem] setTitle:@""];
    [toolbar setTintColor:[UIColor flatGrayColor]];
    [[[self navigationController] navigationBar] setTintColor:[UIColor flatGrayColor]];
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
