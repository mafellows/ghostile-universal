//
//  FilterDetailView.m
//  Ghostile
//
//  Created by Michael Fellows on 12/7/13.
//  Copyright (c) 2013 Michael Fellows. All rights reserved.
//

#import "FilterDetailView.h"
#import <unistd.h>

@implementation FilterDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1.0 / 255 green:1.0 / 255 blue:1.0 / 255 alpha:0.6];
        self.opaque = NO;
        self.imageView.backgroundColor = [UIColor whiteColor];
        self.imageView.opaque = YES; 
        
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
        [self addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer
{
    CGPoint transalation = [recognizer translationInView:recognizer.view];
    CGPoint velocity = [recognizer velocityInView:recognizer.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
    
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Track the movement
        CGFloat y = transalation.y + self.frame.size.height / 2 - self.imageView.frame.size.height / 2;
        [self.imageView setFrame:CGRectMake(transalation.x, y, 320.0, 320.0)];
        NSLog(@"UIGestureRecognizerStateChanged translation x: %f, translation y: %f", transalation.x, transalation.y);
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        // Animate to final position
        if (transalation.x < -200 || transalation.x > 200) {
            [self removeFromSuperview];
        } else {
            CGFloat y = self.frame.size.height / 2 - self.imageView.frame.size.height / 2;
            [self.imageView setFrame:CGRectMake(0, y, 320.0, 320.0)];
        }

    }
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//    [[UIColor clearColor] setFill];
//    UIRectFill(rect);
}

@end
