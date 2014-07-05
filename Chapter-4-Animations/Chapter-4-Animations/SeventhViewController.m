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
    
    
//    self.birthRateSliderValueLabel.text = [NSString stringWithFormat:@"%0.f", self.birthRateSlider.value];
}


#pragma mark - setup
-(CAEmitterLayer *)emitterLayer1
{
    return [self emitterLayerAtPoint: CGPointMake(30, 100) WithCells: @[[self grayCircleImageCell]]];
}


-(CAEmitterLayer *)emitterLayer2
{
    return [self emitterLayerAtPoint: CGPointMake(30, 200) WithCells: @[[self firehoseGrayCircleImageCell]]];
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
