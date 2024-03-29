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
@property (weak, nonatomic) IBOutlet UIButton *runKeyframeButton;
@property (weak, nonatomic) IBOutlet UIButton *resetKeyframeButton;
@property CGPoint originalGreenRectCenter;

@property (weak, nonatomic) IBOutlet UISegmentedControl *uiViewKeyframeAnimationOptionCalculationModeSegmentedControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *uiViewAnimationCurveSegmentedControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *relativeDurationsSegmentedControl;
@end

@implementation ThirdViewController


#pragma mark - Keyframe Animation

/*
 UIViewKeyframeAnimationOptionCalculationModeLinear     = 0 << 9,
 UIViewKeyframeAnimationOptionCalculationModeDiscrete   = 1 << 9,
 UIViewKeyframeAnimationOptionCalculationModePaced      = 2 << 9,
 UIViewKeyframeAnimationOptionCalculationModeCubic      = 3 << 9,
 UIViewKeyframeAnimationOptionCalculationModeCubicPaced = 4 << 9
*/

/*
 typedef enum {
 UIViewAnimationCurveEaseInOut,
 UIViewAnimationCurveEaseIn,
 UIViewAnimationCurveEaseOut,
 UIViewAnimationCurveLinear
 } UIViewAnimationCurve;
 */

- (IBAction)runKeyframeButtonPressed:(UIButton *)sender
{
    sender.enabled = NO;
    
    self.originalGreenRectCenter = self.greenRectangle.center;
    __block CGPoint center = self.greenRectangle.center;
    
    NSUInteger opts;
    
    switch (self.uiViewKeyframeAnimationOptionCalculationModeSegmentedControl.selectedSegmentIndex) {
        case 0:
            opts = UIViewKeyframeAnimationOptionCalculationModeLinear;
            break;
        case 1:
            opts = UIViewKeyframeAnimationOptionCalculationModeDiscrete;
            break;
        case 2:
            opts = UIViewKeyframeAnimationOptionCalculationModePaced;
            break;
        case 3:
            opts = UIViewKeyframeAnimationOptionCalculationModeCubic;
            break;
        case 4:
            opts = UIViewKeyframeAnimationOptionCalculationModeCubicPaced;
            break;
        default:
            break;
    }
    
    NSUInteger uiViewAnimationCurveOption;
    switch (self.uiViewAnimationCurveSegmentedControl.selectedSegmentIndex){
        case 0:
            uiViewAnimationCurveOption = UIViewAnimationCurveEaseInOut;
            break;
        case 1:
            uiViewAnimationCurveOption = UIViewAnimationCurveEaseIn;
            break;
        case 2:
            uiViewAnimationCurveOption = UIViewAnimationCurveEaseOut;
            break;
        case 3:
            uiViewAnimationCurveOption = UIViewAnimationCurveLinear;
            break;
        default:
            break;
    }
    opts = opts | uiViewAnimationCurveOption;
    
    
    CGFloat relativeDuration0;
    CGFloat relativeDuration1;
    CGFloat relativeDuration2;
    CGFloat relativeDuration3;
    
    switch (self.relativeDurationsSegmentedControl.selectedSegmentIndex){
        case 0:
            relativeDuration0 = .1;
//            relativeStartTime0 = 0;
            
            relativeDuration1 = .2;
//            relativeStartTime1 = .1;
            
            relativeDuration2 = .3;
//            relativeStartTime2 = .3;
            
            relativeDuration3 = .4;
//            relativeStartTime3 = .6;
            break;
        case 1:
            relativeDuration0 = .4;
            relativeDuration1 = .3;
            relativeDuration2 = .2;
            relativeDuration3 = .1;
            break;
        case 2:
            relativeDuration0 = .1;
            relativeDuration1 = .4;
            relativeDuration2 = .4;
            relativeDuration3 = .1;
            break;
        case 3:
            relativeDuration0 = .4;
            relativeDuration1 = .1;
            relativeDuration2 = .1;
            relativeDuration3 = .4;
            break;
        default:
            relativeDuration0 = .25;
            relativeDuration1 = .25;
            relativeDuration2 = .25;
            relativeDuration3 = .25;
            break;
    }
    
    CGFloat relativeStartTime0 = 0;
    CGFloat relativeStartTime1 = relativeDuration0;
    CGFloat relativeStartTime2 = relativeDuration0 + relativeDuration1;
    CGFloat relativeStartTime3 = relativeDuration0 + relativeDuration1 + relativeDuration2;
    
    [UIView animateKeyframesWithDuration: 4 delay: 0 options: opts animations:^{
        
//        self.greenRectangle.alpha = 0;
        
        [UIView addKeyframeWithRelativeStartTime:relativeStartTime0 relativeDuration: relativeDuration0 animations:^{
            center.x += 100;
            center.y += 50;
            self.greenRectangle.center = center;
        }];
        [UIView addKeyframeWithRelativeStartTime:relativeStartTime1 relativeDuration: relativeDuration1 animations:^{
            center.x -= 100;
            center.y += 50;
            self.greenRectangle.center = center;
        }];
        [UIView addKeyframeWithRelativeStartTime:relativeStartTime2 relativeDuration: relativeDuration2 animations:^{
            center.x += 100;
            center.y += 50;
            self.greenRectangle.center = center;
        }];
        [UIView addKeyframeWithRelativeStartTime:relativeStartTime3 relativeDuration: relativeDuration3 animations:^{
            center.x -= 100;
            center.y += 50;
            self.greenRectangle.center = center;
        }];
    } completion:^(BOOL finished) {
        self.resetKeyframeButton.enabled = YES;
    }];
}

- (IBAction)resetKeyframeButtonPressed:(UIButton *)sender
{
    sender.enabled = NO;
    self.greenRectangle.center =  self.originalGreenRectCenter;
    self.runKeyframeButton.enabled = YES;
    self.greenRectangle.alpha = 1;
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
    self.resetKeyframeButton.enabled = NO;
}


@end
