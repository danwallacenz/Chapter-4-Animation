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

@end

@implementation ThirdViewController

#pragma mark - Springing View Animation

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
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity: self.initialSpringVelocityStepper.value options:0 animations:^{
        CGPoint center = self.orangeRectangle.center;
        center.x += self.distanceSlider.value;
        self.orangeRectangle.center = center;
    } completion:nil];
}


- (IBAction)leftButtonPressed:(UIButton *)sender
{
    sender.enabled = NO;
    self.rightButton.enabled = YES;
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity: self.initialSpringVelocityStepper.value options:0 animations:^{
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
