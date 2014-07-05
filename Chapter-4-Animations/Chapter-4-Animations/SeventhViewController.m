//
//  SeventhViewController.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 5/07/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "SeventhViewController.h"

@interface SeventhViewController ()
@property (strong, nonatomic) CAEmitterLayer *emitterLayer;

@property (strong, nonatomic) CAEmitterCell *grayCircleImageCell;

@property (weak, nonatomic) IBOutlet UISlider *birthRateSlider;

@property (weak, nonatomic) IBOutlet UILabel *birthRateSliderValueLabel;
@end

@implementation SeventhViewController

#pragma mark - IBActions

- (IBAction)birthRateSliderValueChanged:(UISlider *)sender
{
    self.birthRateSliderValueLabel.text = [NSString stringWithFormat:@"%0.f", sender.value];
    
//    // Recreate emiiter layer.
    [self.emitterLayer removeFromSuperlayer];
    self.emitterLayer = nil;
    
    self.emitterLayer = [self emitterLayer];
    
    self.grayCircleImageCell.birthRate = floor(sender.value);
    
    [self.view.layer addSublayer: self.emitterLayer];
    

    
    
}


#pragma mark - UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.emitterLayer = [self emitterLayer];
    [self.view.layer addSublayer: self.emitterLayer];
    self.birthRateSliderValueLabel.text = [NSString stringWithFormat:@"%0.f", self.birthRateSlider.value];
}


#pragma mark - setup
-(CAEmitterLayer *)emitterLayer
{
    CAEmitterLayer *emitterLayer = [CAEmitterLayer new];
    emitterLayer.emitterPosition = CGPointMake(30, 100);
    emitterLayer.emitterShape = kCAEmitterLayerPoint;
    emitterLayer.emitterMode   = kCAEmitterLayerPoints;
    
    self.grayCircleImageCell = [self grayCircleImageCell];
    
    emitterLayer.emitterCells = @[[self grayCircleImageCell]];
    return emitterLayer;
}


-(CAEmitterCell *)grayCircleImageCell
{
    // Make a grey circele image.
    UIGraphicsBeginImageContextWithOptions((CGSizeMake(10, 10)), NO,1);
    CGContextRef con  = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(con, CGRectMake(0, 0, 10, 10));
    CGContextSetFillColorWithColor(con, [UIColor grayColor].CGColor);
    CGContextFillPath(con);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Make a cell with that image.
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.birthRate = 5;
    cell.lifetime = 1;
    cell.velocity = 100;
    cell.contents = (id)image.CGImage;
    
    return cell;
}


@end
