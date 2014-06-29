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

- (IBAction)backgroundColorButtonPressed:(UIButton *)sender
{
    self.layer0.backgroundColor = [UIColor greenColor].CGColor;
}

- (IBAction)resetButtonPressed:(UIButton *)sender
{
    [self.layer0 removeFromSuperlayer];
    self.layer0 = nil;
    
    self.layer0 = [CALayer new];
    self.layer0.frame = CGRectMake(0, 0, 100, 100);
    self.layer0.backgroundColor = [[UIColor blueColor] CGColor];
    [self.layerHierarchyContainer.layer addSublayer: self.layer0];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.layerHierarchyContainer = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.layerHierarchyContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.layerHierarchyContainer];
    
    self.layer0 = [CALayer new];
    self.layer0.frame = CGRectMake(0, 0, 100, 100);
    self.layer0.backgroundColor = [[UIColor blueColor] CGColor];
    [self.layerHierarchyContainer.layer addSublayer: self.layer0];
}

@end
