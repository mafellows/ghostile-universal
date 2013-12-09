//
//  NewFilterViewController.h
//  Ghostile
//
//  Created by Michael Fellows on 12/6/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFilterViewController : UIViewController
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UIImage *originalImage; 
@end
