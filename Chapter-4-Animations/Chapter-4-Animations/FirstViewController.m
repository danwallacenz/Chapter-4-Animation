//
//  FirstViewController.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 24/06/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIView *animationImagesView;
@property (weak, nonatomic) IBOutlet UIStepper *durationStepper;
@property (weak, nonatomic) IBOutlet UIStepper *repeatStepper;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@property (weak, nonatomic) IBOutlet UILabel *repeatLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property UIImageView *flashingImageView;
@end

@implementation FirstViewController

- (IBAction)durationStepperChanged:(UIStepper *)sender
{
    self.durationLabel.text = [NSString stringWithFormat:@"%0.f ms", sender.value ];
}

- (IBAction)repeatStepperChanged:(UIStepper *)sender
{
        self.repeatLabel.text = [NSString stringWithFormat:@"%0.f", sender.value ];
    
}

- (IBAction)flashButtonPressed:(id)sender
{
    [self flashMars];
}

- (IBAction)stopButtonPressed:(UIButton *)sender
{
    [self.flashingImageView stopAnimating];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.repeatLabel.text = [NSString stringWithFormat:@"%0.f", self.repeatStepper.value ];
    
    self.durationLabel.text = [NSString stringWithFormat:@"%0.f ms", self.durationStepper.value ];

}

-(void)flashMars
{
    UIImage *mars = [UIImage imageNamed: @"Mars"];
    UIGraphicsBeginImageContextWithOptions(mars.size, NO, 0);
    UIImage *empty = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSArray *animationImages = @[mars, empty];
    self.flashingImageView = [[UIImageView alloc] initWithImage: empty];
    CGRect imageViewFrame = self.flashingImageView.frame;
    imageViewFrame.origin = CGPointMake(10, 10);
    self.flashingImageView.frame =  imageViewFrame;
    [self.animationImagesView addSubview: self.flashingImageView];
    self.flashingImageView.animationImages = animationImages;
    self.flashingImageView.animationDuration = self.durationStepper.value/ 1000.0;
    self.flashingImageView.animationRepeatCount = self.repeatStepper.value;
    [self.flashingImageView startAnimating];
}

@end
