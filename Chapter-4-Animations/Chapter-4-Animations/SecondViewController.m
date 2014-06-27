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

@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIButton *animateDownToPurpleButton;
@property (weak, nonatomic) IBOutlet UIButton *animateUpToGreenButton;

@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *twoView;

@end

@implementation SecondViewController

#pragma mark - Dissolve one view into another

- (IBAction)animateToTwoButtonPressed:(UIButton *)sender
{
    self.twoView.hidden = NO;
    self.twoView.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        self.oneView.alpha = 0;
        self.twoView.alpha = 1;
    } completion:^(BOOL finished) {
        self.oneView.hidden = YES;
    }];
}

- (IBAction)animateToOneButtonPressed:(UIButton *)sender
{
    self.oneView.hidden = NO;
    self.oneView.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        self.oneView.alpha = 1;
        self.twoView.alpha = 0;
    } completion:^(BOOL finished) {
        self.twoView.hidden = YES;
    }];
}

#pragma mark - Animate green down to purple rectangle

- (IBAction)animateDownToPurpleButtonPressed:(UIButton *)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        self.greenView.backgroundColor = [UIColor purpleColor];
        CGPoint center = self.greenView.center;
        center.y += 100;
        self.greenView.center = center;
    }];
    
    sender.enabled = NO;
    self.animateUpToGreenButton.enabled = YES;
}

- (IBAction)animateUpToGreenButtonPressed:(UIButton *)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        self.greenView.backgroundColor = [UIColor greenColor];
        CGPoint center = self.greenView.center;
        center.y -= 100;
        self.greenView.center = center;
    }];
    
    sender.enabled = NO;
    self.animateDownToPurpleButton.enabled = YES;
}


#pragma mark - Animate yellow rectangle

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
