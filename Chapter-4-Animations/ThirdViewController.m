//
//  ThirdViewController.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 27/06/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@property (weak, nonatomic) IBOutlet UIView *orangeRectangle;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIStepper *initialSpringVelocityStepper;
@property (weak, nonatomic) IBOutlet UILabel *initialSpringVelocityStepperValueLabel;
@property (weak, nonatomic) IBOutlet UISlider *dampingSlider;
@property (weak, nonatomic) IBOutlet UILabel *dampingValueLabel;


@property (weak, nonatomic) IBOutlet UIView *greenRectangle;


@end

@implementation ThirdViewController


#pragma mark - Keyframe Animation
- (IBAction)runKeyframeButtonPressed:(UIButton *)sender
{
    sender.enabled = NO;
    
    __block CGPoint center = self.greenRectangle.center;
    [UIView animateKeyframesWithDuration:4 delay:0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:.25 animations:^{
            center.x += 100;
            center.y += 50;
            self.greenRectangle.center = center;
        }];
        [UIView addKeyframeWithRelativeStartTime:.25 relativeDuration:.25 animations:^{
            center.x -= 100;
            center.y += 50;
            self.greenRectangle.center = center;
        }];
        [UIView addKeyframeWithRelativeStartTime:.5 relativeDuration:.25 animations:^{
            center.x += 100;
            center.y += 50;
            self.greenRectangle.center = center;
        }];
        [UIView addKeyframeWithRelativeStartTime:.75 relativeDuration:.25 animations:^{
            center.x -= 100;
            center.y += 50;
            self.greenRectangle.center = center;
        }];
    } completion:^(BOOL finished) {
//        code
    }];
}


#pragma mark - Springing View Animation


- (IBAction)dampingSliderChanged:(UISlider *)sender
{
    self.dampingValueLabel.text = [NSString stringWithFormat:@"%1.1f", sender.value ];
}


- (IBAction)initialSpringVelocityStepperChanged:(UIStepper *)sender
{
    self.initialSpringVelocityStepperValueLabel.text = [NSString stringWithFormat:@"%0.f", sender.value ];
}

- (IBAction)distanceSliderChanged:(UISlider *)sender
{
    self.distanceLabel.text = [NSString stringWithFormat:@"%0.f", sender.value];
}


- (IBAction)rightButtonPressed:(UIButton *)sender
{
    sender.enabled = NO;
    self.leftButton.enabled = YES;
    
    
    NSUInteger opts = UIViewAnimationOptionCurveEaseIn;
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping: self.dampingSlider.value initialSpringVelocity: self.initialSpringVelocityStepper.value options:opts animations:^{
        CGPoint center = self.orangeRectangle.center;
        center.x += self.distanceSlider.value;
        self.orangeRectangle.center = center;
    } completion:nil];
}


- (IBAction)leftButtonPressed:(UIButton *)sender
{
    sender.enabled = NO;
    self.rightButton.enabled = YES;
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping: self.dampingSlider.value initialSpringVelocity: self.initialSpringVelocityStepper.value options:0 animations:^{
        CGPoint center = self.orangeRectangle.center;
        center.x -= self.distanceSlider.value;
        self.orangeRectangle.center = center;
    } completion:nil];
}

#pragma mark -  UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.leftButton.enabled = NO;
}


@end
