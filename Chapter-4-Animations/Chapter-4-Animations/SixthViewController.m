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

@end

@implementation SixthViewController

#pragma mark - rotations


- (IBAction)rotate01ConsensedButtonPressed
{
    [CATransaction setDisableActions:YES];
    
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
