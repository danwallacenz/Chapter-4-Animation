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

@property (weak, nonatomic) IBOutlet UIButton *animatedButton;

@property UIImageView *flashingImageView;

@property (weak, nonatomic) IBOutlet UIImageView *pacmanImageView;

@property BOOL buttonIsAnimating;

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


- (IBAction)animatedButtonTapped:(UIButton *)sender
{
    self.buttonIsAnimating = !self.buttonIsAnimating;
    if(self.buttonIsAnimating){
        [self animateButton];
    }else{
        [self.animatedButton setImage:nil forState:UIControlStateNormal];
    }
}

-(void) animateButton
{
    NSMutableArray *circles = [NSMutableArray array];
    float w = 18;
    for (int i = 0; i < 6; i++) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, w), NO, 0);
        CGContextRef con =  UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(con, [UIColor redColor].CGColor);
        CGContextAddEllipseInRect(con, CGRectMake(0+i, 0+i, w-i*2, w-i*2));
        CGContextFillPath(con);
        UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [circles addObject: circle];
    }
    UIImage *animatedImage = [UIImage animatedImageWithImages:circles duration:0.5];
    [self.animatedButton setImage:animatedImage forState:UIControlStateNormal];
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.repeatLabel.text = [NSString stringWithFormat:@"%0.f", self.repeatStepper.value ];
    
    self.durationLabel.text = [NSString stringWithFormat:@"%0.f ms", self.durationStepper.value ];
    
    self.buttonIsAnimating = NO;
    
    self.pacmanImageView.image = [UIImage animatedImageNamed:@"pac" duration:0.5];
    
}
@end
