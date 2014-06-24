//
//  FirstViewController.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 24/06/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImage *mars = [UIImage imageNamed: @"Mars"];
    UIGraphicsBeginImageContextWithOptions(mars.size, NO, 0);
    UIImage *empty = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSArray *animationImages = @[mars, empty, mars, empty, mars];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: empty];
    CGRect imageViewFrame = imageView.frame;
    imageViewFrame.origin = CGPointMake(100, 100);
    imageView.frame =  imageViewFrame;
    [self.view addSubview: imageView];
    imageView.animationImages = animationImages;
    imageView.animationDuration = 2;
    imageView.animationRepeatCount = 1;
    [imageView startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
