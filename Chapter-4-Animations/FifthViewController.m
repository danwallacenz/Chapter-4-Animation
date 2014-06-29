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
@property (strong, nonatomic) CAShapeLayer *layer1;
@property (strong, nonatomic) CATextLayer *layer2;
@property (strong, nonatomic) CAGradientLayer *layer3;

@end

@implementation FifthViewController

#pragma mark - CAGradientLayer animatable properties


- (IBAction)gradientStartPointButtonPressed
{
    int ix = arc4random_uniform(101);
    int iy = arc4random_uniform(101);
    double dx = ix/100.0;
    double dy = iy/100.0;
    self.layer3.startPoint = CGPointMake(dx, dy);
}

- (IBAction)gradientEndPointButtonPressed
{
    int ix = arc4random_uniform(101);
    int iy = arc4random_uniform(101);
    double dx = ix/100.0;
    double dy = iy/100.0;
    self.layer3.endPoint = CGPointMake(dx, dy);
}

- (IBAction)gradientLocationsButtonPressed
{

    NSMutableArray *locations = [NSMutableArray arrayWithCapacity:2];

    int i0 = arc4random_uniform(34);
    int i1 = i0 + arc4random_uniform(34);
    int i2 = i1 + arc4random_uniform(34);
    
    if(i0 + i1 + i2 > 100){
        NSLog(@"ERROR - numbers add up to more than 100");
    }
    
    double r0 = i0/100.0;
    double r1 = i1/100.0;
    double r2 = i2/100.0;
    
    NSLog(@"locations are %f and %f and %f", r0, r1, r2);
    
    locations[0] = @(r0);
    locations[1] = @(r1);
    locations[1] = @(r2);

    self.layer3.locations = locations;
}

- (IBAction)gradientColorsButtonPressed
{
    self.layer3.colors = @[(id)[self randomColor].CGColor,(id)[self randomColor].CGColor, (id)[self randomColor].CGColor];
}

- (IBAction)resetGradientLayerButtonPressed
{
    [self.layer3 removeFromSuperlayer];
    self.layer3 = nil;
    
    self.layer3 = [CAGradientLayer new];
    self.layer3.frame = CGRectMake(600, 500, 300, 200);
    self.layer3.colors = @[(id)[UIColor blackColor].CGColor,
                           (id)[UIColor redColor].CGColor];
    
    self.layer3.locations = nil;
    self.layer3.endPoint = CGPointMake(0.5, 1.0);
    [self.view.layer addSublayer: self.layer3];
}

#pragma mark - CATextLayer animatable properties

- (IBAction)fontSizeButtonPressed
{
    self.layer2.fontSize = self.layer2.fontSize + 5.0;
}

- (IBAction)forgroundColorButtonPressed
{
    self.layer2.foregroundColor = [self randomColor].CGColor;
}

- (IBAction)resetTaxtLayerButtonPressed
{
    [self.layer2 removeFromSuperlayer];
    self.layer2 = nil;
    
    self.layer2 = [CATextLayer new];
    self.layer2.frame = CGRectMake(100, 600, 300, 100);
    self.layer2.backgroundColor = [[self randomColor] CGColor];
    self.layer2.string = @"⚽︎ Daniel🔑 ";
    [self.view.layer addSublayer: self.layer2];
}

#pragma mark - CAShaperLayer animatable properties

- (IBAction)miterLimitButtonPressed
{
    self.layer1.miterLimit = 20.0;
}

- (IBAction)lineDashPhaseButtonPressed
{
    self.layer1.lineDashPattern = @[@20,@30];
    if(self.layer1.lineDashPhase == 100.0){
        self.layer1.lineDashPhase = 0;
    }else{
        self.layer1.lineDashPhase = 100.0;
    }
}

- (IBAction)lineWidthButtonPressed
{
    if(self.layer1.lineWidth == 4.0){
        self.layer1.lineWidth = 10.0;
    }else{
        self.layer1.lineWidth = 4.0;
    }
}

- (IBAction)strokeColorButtonPressed:(id)sender
{
    self.layer1.strokeColor = [self randomColor].CGColor;
}

- (IBAction)fillColorButtonPressed:(id)sender
{
    self.layer1.fillColor = [self randomColor].CGColor;
}

- (IBAction)pathButtonPressed:(id)sender
{
    self.layer1.contentsScale = [UIScreen mainScreen].scale;
    self.layer1.lineWidth = 4.0;
    self.layer1.strokeColor = [self randomColor].CGColor;
    CGMutablePathRef p = CGPathCreateMutable();
    CGPathAddEllipseInRect(p, nil, CGRectInset( self.layer1.bounds, 3, 3));
    self.layer1.path = p;
    CGPathRelease(p);
    
}
- (IBAction)resetShapelayerButtonPressed:(id)sender
{
    [self.layer1 removeFromSuperlayer];
    self.layer1 = nil;
    
    self.layer1 = [CAShapeLayer new];
    self.layer1.frame = CGRectMake(100, 420, 100, 100);
    self.layer1.backgroundColor = [[self randomColor] CGColor];
    self.layer1.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer: self.layer1];
}

#pragma mark - CALayer animatable properties in action

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
//    self.layerHierarchyContainer.backgroundColor = [UIColor clearColor];
    self.layerHierarchyContainer.backgroundColor = [UIColor yellowColor];
    [self.view addSubview: self.layerHierarchyContainer];
    
    self.layer0 = [CALayer new];
    self.layer0.frame = CGRectMake(0, 0, 100, 100);
    self.layer0.backgroundColor = [[self randomColor] CGColor];
    [self.layerHierarchyContainer.layer addSublayer: self.layer0];
    
    self.layer1 = [CAShapeLayer new];
    self.layer1.frame = CGRectMake(100, 420, 100, 100);
    self.layer1.backgroundColor = [[self randomColor] CGColor];
    self.layer1.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer: self.layer1];
    
    self.layer2 = [CATextLayer new];
    self.layer2.frame = CGRectMake(100, 600, 300, 100);
    self.layer2.backgroundColor = [[self randomColor] CGColor];
    self.layer2.string = @"⚽︎ Daniel🔑 ";
    [self.view.layer addSublayer: self.layer2];
    
    
    self.layer3 = [CAGradientLayer new];
    self.layer3.frame = CGRectMake(600, 500, 300, 200);
//    self.layer3.backgroundColor = [[self randomColor] CGColor];
//    self.layer3.colors = @[[self randomColor],[self randomColor],[self randomColor]];
    
    self.layer3.colors = @[(id)[UIColor blackColor].CGColor,
                 (id)[UIColor redColor].CGColor];
    
    self.layer3.endPoint = CGPointMake(0.5, 1.0);
    self.layer3.locations = nil;
    [self.view.layer addSublayer: self.layer3];

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
