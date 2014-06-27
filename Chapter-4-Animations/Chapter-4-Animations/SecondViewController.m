//
//  SecondViewController.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 24/06/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (strong, nonatomic) IBOutlet UIView *yellowView;
@property (weak, nonatomic) IBOutlet UIButton *animateToRedButton;
@property (weak, nonatomic) IBOutlet UIButton *animatetoYellowButton;

@end

@implementation SecondViewController

- (IBAction)animateToRedButtonPressed:(UIButton *)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        self.yellowView.backgroundColor = [UIColor redColor];
    }];
    
    sender.enabled = NO;
    self.animatetoYellowButton.enabled = YES;
}

- (IBAction)animateToYellowButtonPressed:(UIButton *)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        self.yellowView.backgroundColor = [UIColor yellowColor];
    }];
    
    sender.enabled = NO;
    self.animateToRedButton.enabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
