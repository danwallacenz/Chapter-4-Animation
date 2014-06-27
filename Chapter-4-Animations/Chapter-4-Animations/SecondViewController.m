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
@property (weak, nonatomic) IBOutlet UIButton *animateToTwoButton;
@property (weak, nonatomic) IBOutlet UIButton *animateToOneButton;

@property (weak, nonatomic) IBOutlet UIView *orangeView;
@property (weak, nonatomic) IBOutlet UIButton *jumpUpAndGoRedButton;
@property (weak, nonatomic) IBOutlet UIButton *jumpBackAndGoOrangeButton;

@property (strong, nonatomic) IBOutlet UIView *purpleAutoReversingView;


@end

@implementation SecondViewController

#pragma mark - Auto Reverse

- (IBAction)purpleAutoReversingRunButtonPressed:(UIButton *)sender
{
    // save this to restore original position later
    CGPoint originalCenter = self.purpleAutoReversingView.center;
    
    NSUInteger opts = UIViewAnimationOptionAutoreverse;
    [UIView animateWithDuration:1 delay:0 options:opts animations:^{
        CGPoint center = self.purpleAutoReversingView.center;
        center.x += 100;
        self.purpleAutoReversingView.center = center;
    } completion:^(BOOL finished) {
        self.purpleAutoReversingView.center = originalCenter;
    }];
}

#pragma mark - performWithoutAnimation:

- (IBAction)jumpUpAndGoRedButtonPressed:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.4 animations:^{
        self.orangeView.backgroundColor = [UIColor redColor];
        [UIView performWithoutAnimation:^{
            CGPoint center = self.orangeView.center;
            center.y -= 100;
            self.orangeView.center = center;
        }];
    }];
    
    self.jumpBackAndGoOrangeButton.enabled = YES;
    sender.enabled = NO;
}

- (IBAction)jumpBackAndGoOrangeButtonPressed:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.4 animations:^{
        self.orangeView.backgroundColor = [UIColor orangeColor];
        [UIView performWithoutAnimation:^{
            CGPoint center = self.orangeView.center;
            center.y += 100;
            self.orangeView.center = center;
        }];
    }];
    
    self.jumpUpAndGoRedButton.enabled = YES;
    sender.enabled = NO;
}


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
    sender.enabled = NO;
    self.animateToOneButton.hidden = NO;
    self.animateToOneButton.enabled = YES;
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
    sender.enabled = NO;
    self.animateToTwoButton.enabled = YES;
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
    self.jumpBackAndGoOrangeButton.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
