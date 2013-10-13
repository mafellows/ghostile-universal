//
//  FilterViewController.h
//  ghostile
//
//  Created by Michael Fellows on 10/13/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterViewController : UIViewController
{
    IBOutlet UINavigationBar *navigationBar;
    IBOutlet UIBarButtonItem *saveButton;
    IBOutlet UIBarButtonItem *cancelButton;
}
@property (nonatomic, strong) UIImage *image;
@end
