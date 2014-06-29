//
//  FifthViewController.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 29/06/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "FifthViewController.h"

@interface FifthViewController ()

@property (strong, nonatomic) UIView *layerHierarchyContainer;
@property (strong, nonatomic) CALayer *layer0;

@end

@implementation FifthViewController

- (IBAction)transformButtonPressed:(UIButton *)sender
{
    self.layer0.transform = CATransform3DMakeRotation(M_PI/4, 2, 2, 2);
}

#warning doesn't do anything without sublayers
- (IBAction)sublayerTransformButtonPressed:(UIButton *)sender
{
    self.layer0.sublayerTransform = CATransform3DMakeRotation(M_PI/4, 2, 2, 2);
}

- (IBAction)shadowRadiusButtonPressed:(UIButton *)sender
{
    self.layer0.shadowRadius = 5.0;
}

- (IBAction)shadowOpacityButtonPressed:(UIButton *)sender
{
    self.layer0.shadowOpacity = 0.5;
}

- (IBAction)shadowOffsetButtonPressed:(UIButton *)sender
{
    self.layer0.shadowOffset = CGSizeMake(0.0, -5.0);
}

- (IBAction)shadowColorButtonPressed:(UIButton *)sender
{
    self.layer0.shadowColor = [self randomColor].CGColor;
}

#warning ??
- (IBAction)shouldRasterizeButtonPressed:(UIButton *)sender
{
    self.layer0.shouldRasterize = !self.layer0.shouldRasterize;
}

#warning ???
- (IBAction)rasterizationScaleButtonPressed:(UIButton *)sender
{
    self.layer0.rasterizationScale = 0.5;
}

#warning doesn't do anything currently
- (IBAction)zPositionButtonPressed:(UIButton *)sender
{
    self.layer0.zPosition = -20.0;
}

- (IBAction)positionButtonPressed:(UIButton *)sender
{
    CGPoint position = self.layer0.position;
    position.x += 50.0;
    position.y += 50.0;
    self.layer0.position = position;
}

- (IBAction)opacityButtonPressed:(UIButton *)sender
{
    self.layer0.opacity = 0.5;
}

- (IBAction)masksToBoundsButtonPressed:(UIButton *)sender
{
 
    self.layer0.masksToBounds = !self.layer0.masksToBounds;
}

- (IBAction)hiddenButtonPressed:(UIButton *)sender
{
    self.layer0.hidden = !self.layer0.hidden;
}

#warning fuck knows
- (IBAction)doubleSidedButtonPressed:(UIButton *)sender
{
    self.layer0.doubleSided = !self.layer0.doubleSided;
}

- (IBAction)cornerRadiusButtonPressed:(UIButton *)sender
{
    self.layer0.cornerRadius = 20.0;
}

#warning fuck knows what this does either
- (IBAction)contentsRectButtonPressed:(UIButton *)sender
{
    self.layer0.contentsRect = CGRectMake(.5, .5, 0.5, .5);
}

#warning fuck knows what this does
- (IBAction)contentsCenterButtonPressed:(UIButton *)sender
{
    self.layer0.contentsCenter = CGRectMake(0, 0, 0.5,0.5);
}

- (IBAction)contentsButtonPressed:(UIButton *)sender
{
    UIImage *mars = [UIImage imageNamed: @"Mars"];
    self.layer0.contents = (__bridge id)([mars CGImage]);
}

- (IBAction)boundsButtonPressed:(UIButton *)sender
{
    CGRect oldBounds = self.layer0.bounds;

    CGRect newBounds = CGRectMake(0, 0, oldBounds.size.width * 1.2, oldBounds.size.height * 1.2);
    self.layer0.bounds = newBounds;
}


- (IBAction)borderWidthColorButtonPressed:(UIButton *)sender
{
    self.layer0.borderWidth = 4.0f;
}

- (IBAction)borderColorButtonPressed:(UIButton *)sender
{
     self.layer0.borderColor = [self randomColor].CGColor;
}

- (IBAction)backgroundColorButtonPressed:(UIButton *)sender
{
    self.layer0.backgroundColor = [self randomColor].CGColor;
}

#warning TODO do something with this
- (IBAction)anchorPointZButtonPressed:(id)sender
{
    self.layer0.anchorPointZ = 1.0;
}

- (IBAction)anchorPointButtonPressed:(UIButton *)sender
{
    self.layer0.anchorPoint = CGPointMake(0.4, 0.4);
}

- (IBAction)resetButtonPressed:(UIButton *)sender
{
    [self.layer0 removeFromSuperlayer];
    self.layer0 = nil;
    
    self.layer0 = [CALayer new];
    self.layer0.frame = CGRectMake(0, 0, 100, 100);
    self.layer0.backgroundColor = [[self randomColor] CGColor];
    [self.layerHierarchyContainer.layer addSublayer: self.layer0];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.layerHierarchyContainer = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.layerHierarchyContainer.backgroundColor = [UIColor clearColor];
    [self.view addSubview: self.layerHierarchyContainer];
    
    self.layer0 = [CALayer new];
    self.layer0.frame = CGRectMake(0, 0, 100, 100);
    self.layer0.backgroundColor = [[self randomColor] CGColor];
    [self.layerHierarchyContainer.layer addSublayer: self.layer0];
}

#pragma mark - utils
-(UIColor *)randomColor
{
    CGFloat redValue    = (arc4random() % 255) / 255.0f;
    CGFloat greenValue  = (arc4random() % 255) / 255.0f;
    CGFloat blueValue   = (arc4random() % 255) / 255.0f;
    
    return [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0f];
}

@end
