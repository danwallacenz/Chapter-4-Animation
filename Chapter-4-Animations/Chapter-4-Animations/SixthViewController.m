//
//  SixthViewController.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 30/06/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "SixthViewController.h"
#import "CompassView.h"
#import "CompassLayer.h"

@interface SixthViewController ()

@property (weak, nonatomic) CompassView *compassView;
@property (weak, nonatomic) CALayer *arrow;;

@property (weak, nonatomic) IBOutlet UIView *outer;
@property (weak, nonatomic) IBOutlet UIView *inner;
@property CGRect originalInnerFrame;
@property CGRect originalInnerBounds;
@property CGPoint originalInnerPosition;
@end

@implementation SixthViewController


#pragma mark - animating frames
- (IBAction)animateUsingCABasicAnimationButtonPressed
{
    
    // Set back to original state. This doesn't work very well.
    [self reset];
    
  /*
   Remember that there is no @"frame" key. To animate a layer’s frame, if both its position and bounds are to change, you must animate both.
   */
    
    // Animate the bounds.
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    CGRect innerBounds = self.inner.layer.bounds;// UIViewAnimation used frame here.
    self.originalInnerBounds = innerBounds; // save for reset later
    innerBounds.size.width = self.outer.layer.bounds.size.width;
    
    self.inner.layer.bounds = innerBounds;
    [self.inner.layer addAnimation:boundsAnimation forKey:nil];
    
    // Animate the position.
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint innerPosition = self.inner.layer.position;// UIViewAnimation used frame here.
    self.originalInnerPosition = innerPosition; // save for reset later
    innerPosition.x = CGRectGetMidX(self.outer.layer.bounds);
    self.inner.layer.position = innerPosition;
    [self.inner.layer addAnimation:positionAnimation forKey:nil];

}

- (IBAction)animateUsingUIViewAnimationButtonPressed
{
    
    // Set back to original state. This doesn't work very well.
    [self reset];
    
    NSUInteger opts = UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionAllowAnimatedContent;
    [UIView transitionWithView:self.outer duration:1 options:opts
                    animations:^{
                        CGRect f = self.inner.frame;
                        self.originalInnerFrame = f; // save for reset later
                        f.size.width = self.outer.frame.size.width;
                        f.origin.x = 0;
                        self.inner.frame = f;
                    } completion:nil];
}


- (IBAction)frameAnimationResetButtonPressed
{
//    self.inner.frame = self.originalInnerFrame; // from UIView Animation.
//    
//    self.inner.layer.bounds = self.originalInnerBounds;     // from CABasic Animation.
//    self.inner.layer.position = self.originalInnerPosition;
    [self reset];
}


// This doesn't work very well.
-(void)reset
{
//    self.inner.frame = self.originalInnerFrame; // from UIView Animation.
    
    self.inner.layer.bounds = self.originalInnerBounds;     // from CABasic Animation.
    self.inner.layer.position = self.originalInnerPosition;
}


#pragma mark - waggles

- (IBAction)waggle01CondensedButtonPressed
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.05;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.repeatCount = 3;
    animation.autoreverses = YES;
    animation.additive = YES;
    animation.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
    animation.fromValue = @(M_PI/40);
    animation.toValue = @(-M_PI/40);
    [self.arrow addAnimation:animation forKey:nil];
}

- (IBAction)waggle01ButtonPressed
{
    // Capture the start and end values.
    CATransform3D nowValue = self.arrow.transform;
    CATransform3D startValue = CATransform3DRotate(nowValue, M_PI/40.0, 0, 0, 1);
    CATransform3D endValue = CATransform3DRotate(nowValue, -M_PI/40.0, 0, 0, 1);
    
    // Construct the explicit animation.
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.05;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.repeatCount = 3;
    animation.autoreverses = YES;
    animation.fromValue = [NSValue valueWithCATransform3D:startValue];
    animation.toValue = [NSValue valueWithCATransform3D:endValue];
    
    // Ask for the explicit animation.
    [self.arrow addAnimation:animation forKey:nil];
}

#pragma mark - rotations

- (IBAction)rotate01ConsensedButtonPressed
{
    /*
     Once you know the full form, you will find that in many cases it can be condensed. For example, when fromValue and toValue are not set, the former and current values of the property are used automatically. (This magic is possible because the presentation layer still has the former value of the property, while the layer itself has the new value.) Thus, in this case there was no need to set them, and so there was no need to capture the start and end values beforehand either.
     */
    
    [CATransaction setDisableActions:YES];
    self.arrow.transform = CATransform3DRotate(self.arrow.transform, M_PI/4.0, 0, 0, 1);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.8;
    CAMediaTimingFunction *clunk = [CAMediaTimingFunction functionWithControlPoints:.9 :.1 :.7 :.9];
    animation.timingFunction = clunk;
    [self.arrow addAnimation:animation forKey:nil];
    
}

- (IBAction)rotate01ButtonPressed
{
    /*
     1. Capture the start and end values for the layer property you’re going to change, because you’re likely to need these values in what follows.
     2. Change the layer property to its end value, first calling setDisableActions: if necessary to prevent implicit animation.
     3. Construct the explicit animation, using the start and end values you captured earlier, and with its keyPath corresponding to the layer property you just changed.
     4. Add the explicit animation to the layer.
     */
    
    // Capture the start and end values.
    CATransform3D startValue = self.arrow.transform;
    CATransform3D endValue = CATransform3DRotate(startValue, M_PI/4.0, 0, 0, 1);
    
    //Change the layer, without implicit animation.
    [CATransaction setDisableActions:YES];
    self.arrow.transform = endValue;
    
    // Construct the explicit animation.
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.8;
    CAMediaTimingFunction *clunk = [CAMediaTimingFunction functionWithControlPoints:.9 :.1 :.7 :.9];
    animation.timingFunction = clunk;
    animation.fromValue = [NSValue valueWithCATransform3D:startValue];
    animation.toValue = [NSValue valueWithCATransform3D:endValue];
    
    // Ask for the explicit animation.
    [self.arrow addAnimation:animation forKey:nil];
}


-(CALayer *)arrow
{
    if (!_arrow) {
        if([self.compassView.layer isKindOfClass:[CompassLayer class]]){
            CompassLayer *compassLayer = (CompassLayer *)self.compassView.layer;
            _arrow = compassLayer.arrow;;
        }
    }
    return _arrow;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Add a CompassView to to my view.  It has a CompassLayer as its layer.
    [self addACompassView];
    
    self.originalInnerBounds = self.inner.layer.bounds;
    self.originalInnerPosition = self.inner.layer.position;
}


-(void)addACompassView
{
    // Add a CompassView to to my view.  It has a CompassLayer as its layer.
    CompassView *compassView = [[CompassView alloc] initWithFrame:CGRectMake(100, 100, 400, 400)];
    [self.view addSubview: compassView];
    self.compassView = compassView;

    if([self.compassView.layer isKindOfClass:[CompassLayer class]]){
        CompassLayer *compassLayer = (CompassLayer *)self.compassView.layer;
        self.arrow = compassLayer.arrow;
    }
}
@end
