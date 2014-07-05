//
//  SeventhViewController.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 5/07/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "SeventhViewController.h"

@interface SeventhViewController ()

@property (strong, nonatomic) CAEmitterLayer *emitterLayer1;
@property (strong, nonatomic) CAEmitterLayer *emitterLayer2;
@property (strong, nonatomic) CAEmitterLayer *emitterLayer3;
@property (strong, nonatomic) CAEmitterLayer *emitterLayer4;


//@property (strong, nonatomic) CAEmitterCell *grayCircleImageCell;

//@property (weak, nonatomic) IBOutlet UISlider *birthRateSlider;
//
//@property (weak, nonatomic) IBOutlet UILabel *birthRateSliderValueLabel;
@end

@implementation SeventhViewController

#pragma mark - IBActions

//- (IBAction)birthRateSliderValueChanged:(UISlider *)sender
//{
//    self.birthRateSliderValueLabel.text = [NSString stringWithFormat:@"%0.f", sender.value];
//    
////    // Recreate emiiter layer.
//    [self.emitterLayer removeFromSuperlayer];
//    self.emitterLayer = nil;
//    
//    self.emitterLayer = [self emitterLayer];
//    
//    self.grayCircleImageCell.birthRate = floor(sender.value);
//    
//    [self.view.layer addSublayer: self.emitterLayer];
//}


#pragma mark - UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.emitterLayer1 = [self emitterLayer1];
    [self.view.layer addSublayer: self.emitterLayer1];
    
     self.emitterLayer2 = [self emitterLayer2];
    [self.view.layer addSublayer: self.emitterLayer2];
    
    self.emitterLayer3 = [self emitterLayer3];
    [self.view.layer addSublayer: self.emitterLayer3];
    
    self.emitterLayer4 = [self emitterLayer4];
    [self.view.layer addSublayer: self.emitterLayer4];
    
//    self.birthRateSliderValueLabel.text = [NSString stringWithFormat:@"%0.f", self.birthRateSlider.value];
}


#pragma mark - setup

-(CAEmitterLayer *)emitterLayer1
{
    return [self emitterLayerAtPoint: CGPointMake(30, 100) WithCells: @[[self grayCircleImageCell]]];
}

-(CAEmitterLayer *)emitterLayer2
{
    return [self emitterLayerAtPoint: CGPointMake(30, 300) WithCells: @[[self firehoseGrayCircleImageCell]]];
}

-(CAEmitterLayer *)emitterLayer3
{
    return  [self emitterLayerAtPoint: CGPointMake(30, 400) WithCells: @[[self waterfallGrayCircleImageCell]]];
}

-(CAEmitterLayer *)emitterLayer4
{
    CAEmitterLayer *waterfall = [self emitterLayerAtPoint: CGPointMake(230, 100) WithCells: @[[self waterfallGrayCircleImageCell]]];
    [waterfall setValue:@2.0f forKeyPath :@"emitterCells.circle.greenSpeed"];
    return waterfall;
}

-(CAEmitterLayer *)emitterLayerAtPoint: (CGPoint)point WithCells: (NSArray *)cells
{
    CAEmitterLayer *emitterLayer = [CAEmitterLayer new];
    emitterLayer.emitterPosition = point;
    emitterLayer.emitterShape = kCAEmitterLayerPoint;
    emitterLayer.emitterMode   = kCAEmitterLayerPoints;

    
    emitterLayer.emitterCells = cells;
    return emitterLayer;
}

-(CAEmitterCell *)waterfallGrayCircleImageCell
{
    
    CAEmitterCell *cell = [self firehoseGrayCircleImageCell];
    
    cell.xAcceleration = -40;
    cell.yAcceleration = 200;
    
    cell.lifetimeRange = .4;
    cell.velocityRange = 20;
    cell.scaleRange = .2;
    cell.scaleSpeed = .2;
    cell.color = [UIColor blueColor].CGColor;
    cell.greenRange = .5;
    cell.greenSpeed = .75;
    
    cell.contents = (id)[self grayCircle].CGImage;
    [cell setValue:@"circle" forKeyPath:@"name"]; // For setting parameters later.
    return cell;
}

-(CAEmitterCell *)firehoseGrayCircleImageCell
{
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.birthRate = 100;
    cell.lifetime = 1.6;
    cell.velocity = 100;
    cell.emissionRange = M_PI/5.0;
    cell.contents = (id)[self grayCircle].CGImage;
    return cell;
}

-(CAEmitterCell *)grayCircleImageCell
{
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.birthRate = 5;
    cell.lifetime = 1;
    cell.velocity = 100;
    cell.contents = (id)[self grayCircle].CGImage;
//    [cell setValue:@"circle" forKeyPath:@"name"];
    return cell;
}

-(UIImage *)grayCircle
{
    // Make a grey circle image.
    UIGraphicsBeginImageContextWithOptions((CGSizeMake(10, 10)), NO,1);
    CGContextRef con  = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(con, CGRectMake(0, 0, 10, 10));
    CGContextSetFillColorWithColor(con, [UIColor grayColor].CGColor);
    CGContextFillPath(con);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
