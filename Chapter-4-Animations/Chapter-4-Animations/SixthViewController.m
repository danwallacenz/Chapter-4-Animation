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
#import "LayerWithThickness.h"

@interface SixthViewController ()

@property (weak, nonatomic) CompassView *compassView;
@property (weak, nonatomic) CALayer *arrow;;

@property (weak, nonatomic) IBOutlet UIView *outer;
@property (weak, nonatomic) IBOutlet UIView *inner;
@property CGRect originalInnerFrame;
@property CGRect originalInnerBounds;
@property CGPoint originalInnerPosition;

@property (nonatomic, strong) CALayer* sprite;
@property (nonatomic, strong) NSArray* images;

@property (strong, nonatomic) LayerWithThickness *layerWithThickness;

@property (strong, nonatomic) UIView *boat;
@property (weak, nonatomic) IBOutlet UIButton *sailHerButton;

@property (strong, nonatomic) CALayer *pushTransitionLayer;
@property (strong, nonatomic) UIView *pushTransitionView;

@end

@implementation SixthViewController

#pragma mark - Transitions.

- (IBAction)pushButtonPressed
{
    CATransition *pushTransition= [CATransition animation];
    pushTransition.type = kCATransitionPush;
    pushTransition.subtype = kCATransitionFromBottom;
    pushTransition.duration = 2;
    [CATransaction setDisableActions: YES];
    
    self.pushTransitionLayer.contents = (id)[UIImage imageNamed: @"SmileyiPhone"].CGImage;
    [self.pushTransitionLayer addAnimation:pushTransition forKey:nil];
}

-(void)addPushTransitionLayer
{
    // Add a view.
    self.pushTransitionView = [[UIView alloc] initWithFrame:CGRectMake(540, 80, 100, 100)];
    [self.view addSubview:self.pushTransitionView];
    
    // Configure its layer
    self.pushTransitionView.layer.borderWidth = 2.0;
    self.pushTransitionView.layer.masksToBounds = YES;
    
    // Create a sub layer with an image.
    self.pushTransitionLayer = [CALayer layer];
    self.pushTransitionLayer.frame = self.pushTransitionView.layer.bounds;
    self.pushTransitionLayer.contents = (id)[UIImage imageNamed:@"Mars"].CGImage;
    self.pushTransitionLayer.contentsGravity = kCAGravityResizeAspectFill;

    // Add the sub layer to the vire's layer.
    [self.pushTransitionView.layer addSublayer: self.pushTransitionLayer];
}


#pragma mark - Sail the boat - three grouped animations.

- (IBAction)sailHerButtonPressed:(UIButton *)sender
{
    sender.enabled = NO;
    [self.boat removeFromSuperview];
    self.boat = nil;
    [self addTheBoat];
    
    // The curving path animation.
    CGFloat h = 250;
    CGFloat v = 75;
    CGMutablePathRef path = CGPathCreateMutable();
    int leftRight = 1;
    CGPoint next = self.boat.layer.position;
    CGPoint pos;
    CGPathMoveToPoint(path, nil, next.x, next.y);
    for (int i = 0; i < 4; i++) {
        pos = next;
        leftRight *= -1;
        next = CGPointMake(pos.x + h * leftRight, pos.y + v);
        CGPathAddCurveToPoint(path, nil, pos.x, pos.y + 30, next.x, next.y - 30, next.x, next.y);
    }
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = path;
    pathAnimation.calculationMode = kCAAnimationPaced;
    
    
    // Reversal animation.
    NSArray *reversals = @[@0.0f, @M_PI, @0.0f, @M_PI];
    CAKeyframeAnimation *reversalsAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    reversalsAnimation.values = reversals;
    reversalsAnimation.valueFunction = [CAValueFunction functionWithName: kCAValueFunctionRotateY];
    reversalsAnimation.calculationMode = kCAAnimationDiscrete;
    
    
    // Rocking the boat animation.
    NSArray *pitches = @[@0.0f,
                         @(M_PI/60.0),
                         @0.0f,
                         @(-M_PI/60.0),
                         @0.0f];
    CAKeyframeAnimation *pitchingAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    pitchingAnimation.values = pitches;
    pitchingAnimation.repeatCount = HUGE_VALF;
    pitchingAnimation.duration = 0.5;
    pitchingAnimation.additive = YES;
    pitchingAnimation.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
    
    
    // Combine the three animations into a group.
    CAAnimationGroup *sailAway = [CAAnimationGroup animation];
    sailAway.animations = @[pathAnimation, reversalsAnimation, pitchingAnimation];
    sailAway.duration = 8;
    
     [CATransaction setCompletionBlock:^{
         sender.enabled = YES;
     }];
    
    [self.boat.layer addAnimation:sailAway forKey:nil];
    [CATransaction setDisableActions:YES];
    
    // Change model layer's position to match the animation's (presentation layer) final position.
    self.boat.layer.position = next;
}


#pragma mark - Grouped Animations = rotate and waggle

- (IBAction)rotateAndWaggleButtonPressed
{
    CAAnimation *rotation = [self rotation];
    CAAnimation *waggle = [self wagglesGetProgressivelySmaller];
    waggle.beginTime = rotation.duration;
    waggle.duration = 0.25;

    CAAnimationGroup *rotateAndWaggle = [CAAnimationGroup animation];
    rotateAndWaggle.animations = @[rotation, waggle];
    rotateAndWaggle.duration = rotation.duration + waggle.duration;
    [self.arrow addAnimation: rotateAndWaggle forKey:nil];
}

#pragma mark - Making a Property Animatable

- (IBAction)AnimateTHicknessButtonPressed
{
    CABasicAnimation *thicknessAnimation = [CABasicAnimation animationWithKeyPath:@"thickness"];
    thicknessAnimation.toValue = [NSNumber numberWithFloat:10.0];
    thicknessAnimation.autoreverses = YES;
    [self.layerWithThickness addAnimation:thicknessAnimation forKey:nil];
}


#pragma mark - Keyframe Animated Images - animating contents and position

- (IBAction)RunPacmanKeyframeAnimatedImagesButtonPressed
{
    [self.view.layer addSublayer:self.sprite];
    
    CAKeyframeAnimation* anim = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    anim.values = self.images;
    anim.keyTimes = @[@0,@0.25,@0.5,@0.75,@1];
    anim.calculationMode = kCAAnimationDiscrete;
    anim.duration = 1.5;
    anim.repeatCount = HUGE_VALF;
    
    CABasicAnimation* anim2 = [CABasicAnimation animationWithKeyPath:@"position"];
    anim2.duration = 10;
    anim2.toValue = [NSValue valueWithCGPoint: CGPointMake(830,517)];
    
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = @[anim, anim2];
    group.duration = 10;
    
    [self.sprite addAnimation:group forKey:nil];
}

-(CALayer *)sprite
{
    if(!_sprite){
        _sprite = [CALayer new];
        _sprite.frame = CGRectMake(522,505,24,24);
        _sprite.contentsScale = [UIScreen mainScreen].scale;
        _sprite.contents = self.images[0];
    }
    return _sprite;
}

-(NSArray *)images
{
    if(!_images){
        NSMutableArray* arr = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(24,24), YES, 0);
            [[UIImage imageNamed: @"sprites.png"]
             drawAtPoint:CGPointMake(-(5+i)*24,-4*24)];
            UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [arr addObject: (id)im.CGImage];
        }
        for (int i = 1; i >= 0; i--) {
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(24,24), YES, 0);
            [[UIImage imageNamed: @"sprites.png"]
             drawAtPoint:CGPointMake(-(5+i)*24,-4*24)];
            UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [arr addObject: (id)im.CGImage];
        }
        _images = [arr copy];
    }
    return _images;
}

#pragma mark - waggles using Keyframe Animation

- (IBAction)wagglesGetProgressivelySmallerButtonPressed
{
    [self.arrow addAnimation: [self wagglesGetProgressivelySmaller] forKey:nil];
}

-(CAKeyframeAnimation *)wagglesGetProgressivelySmaller
{
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:@0.0f];
    int direction = 1;
    for (int i = 20; i < 60; i += 5, direction *= -1) { // Alternate directions.
        [values addObject: @(direction * M_PI/(float)i)];
    }
    [values addObject:@0.0f];
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim.values = values;
    anim.additive = YES;
    anim.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
    return anim;
}


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
    [self reset];
}


// This doesn't work very well.
-(void)reset
{
    self.inner.frame = self.originalInnerFrame; // from UIView Animation.
    
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
    [self.arrow addAnimation:[self rotation] forKey:nil];
}

-(CABasicAnimation *) rotation
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
    
    return animation;
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

    // Add a CompassView to to my view.  It has a CompassLayer as its layer.
    [self addACompassView];
    
    self.originalInnerBounds = self.inner.layer.bounds;
    self.originalInnerPosition = self.inner.layer.position;
    
    [self addALayerWithThickness];
    
    [self addTheBoat];
    
    [self addPushTransitionLayer];
}

#pragma mark - Add layers.



-(void)addTheBoat
{
//    self.boat = [[UIView alloc] initWithFrame:CGRectMake(254,28,56,38)];
    self.boat = [[UIView alloc] initWithFrame:CGRectMake(854,360,56,38)];
    [self.view addSubview: self.boat];
    self.boat.layer.contents = (id)[[UIImage imageNamed:@"boat.gif"] CGImage];
    self.boat.layer.contentsGravity = kCAGravityResizeAspectFill;
}

-(void)addALayerWithThickness
{
    self.layerWithThickness =  [[LayerWithThickness alloc] init];
    self.layerWithThickness.frame = CGRectMake(530,600,100,100);
    self.layerWithThickness.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer: self.layerWithThickness];
    [self.layerWithThickness setNeedsDisplay];
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
