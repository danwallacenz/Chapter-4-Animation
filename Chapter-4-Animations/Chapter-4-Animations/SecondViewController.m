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
@property (weak, nonatomic) IBOutlet UIButton *runAutoReversingButton;
@property (weak, nonatomic) IBOutlet UIStepper *repetitionStepper;
@property (weak, nonatomic) IBOutlet UILabel *repetitionStepperValueLabel;


@property (weak, nonatomic) IBOutlet UIView *brownRectangle;
@property BOOL reverse;


@property (weak, nonatomic) IBOutlet UIView *blackRectangle;
@property BOOL overrideInheritedDurationReversed;


@property (weak, nonatomic) IBOutlet UIView *cyanRectangle;
@property (weak, nonatomic) IBOutlet UIButton *runCancellableAnimationButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelCancellableAnimationButton;
@property CGPoint initialCenter;


@property (strong, nonatomic) IBOutlet UIView *redRectangle;
@property (weak, nonatomic) IBOutlet UIButton *redRectangleRunButton;
@property (weak, nonatomic) IBOutlet UIButton *redRectangleCancelButton;
@property CGPoint redRectInitialCenter;

@end

@implementation SecondViewController

#pragma mark - cancel repeating animations

- (IBAction)redRectangleRunButtonPressed:(UIButton *)sender
{
    sender.enabled = NO;
    self.redRectangleCancelButton.enabled = YES;
    
    CGPoint center = self.redRectangle.center;
    self.redRectInitialCenter = center;
    center.x += 100;
    NSUInteger opts = UIViewAnimationOptionAutoreverse |UIViewAnimationOptionRepeat;
    [UIView animateWithDuration:1 delay:0 options:opts animations:^{
        self.redRectangle.center = center;
    } completion:nil];
}

- (IBAction)redRectangleCancelButtonPressed:(UIButton *)sender
{
    sender.enabled = NO;
    self.redRectangleRunButton.enabled = YES;
    
    NSUInteger opts =  UIViewAnimationOptionBeginFromCurrentState;
    [UIView animateWithDuration: 0.2 delay: 0 options: opts
                     animations:^{
                         self.redRectangle.center = self.redRectInitialCenter;
                     } completion:nil];
    
}

#pragma mark - cancelling animations

- (IBAction)runCancellableAnimationButtonPressed:(UIButton *)sender
{
    sender.enabled = NO;
    self.cancelCancellableAnimationButton.enabled = YES;

    CGPoint center = self.cyanRectangle.center;
    self.initialCenter = center;
    center.x += 100;
    [UIView animateWithDuration: 2
                     animations: ^{
                          self.cyanRectangle.center = center;
                     }];
}


- (IBAction)cancelCancellableAnimationButtonPressed:(UIButton *)sender
{
    sender.enabled = NO;
    
    NSUInteger opts = UIViewAnimationOptionBeginFromCurrentState;
    [UIView animateWithDuration: 0.1 delay: 0 options: opts animations:^{
        CGPoint center = self.initialCenter;
        center.x += 1; // a slight change
        self.cyanRectangle.center = center;
    } completion:^(BOOL finished) {
        CGPoint center = self.initialCenter;
        self.cyanRectangle.center = center;
    }];
    
    self.runCancellableAnimationButton.enabled = YES;
}

#pragma mark - UIViewAnimationOptionOverrideInheritedDuration

- (IBAction)blackRectangleRunButtonPressed:(UIButton *)sender
{
    sender.enabled = NO;
    
    [UIView animateWithDuration:2 animations:^{
        CGPoint center = self.blackRectangle.center;
        
        if(self.overrideInheritedDurationReversed){
            center.x -= 100;
        }else{
            center.x += 100;
        }
        self.blackRectangle.center = center;
        //        NSInteger opts = 0;
        NSInteger opts = UIViewAnimationOptionOverrideInheritedDuration;
        
        [UIView animateWithDuration:0.5 delay:0 options:opts animations:^{
            self.blackRectangle.backgroundColor = (self.overrideInheritedDurationReversed)?[UIColor blackColor]:[UIColor yellowColor];
        } completion: ^(BOOL finished){
            self.overrideInheritedDurationReversed = !self.overrideInheritedDurationReversed;
            sender.enabled = YES;
        }];
    }];
}

#pragma mark - UIViewAnimationOptionBeginFromCurrentState

- (IBAction)runUIAnimationOptionBeginFromCurrentStateButtonPressed:(id)sender
{
    [UIView animateWithDuration: 1 animations:^{
        CGPoint center = self.brownRectangle.center;
        
        if(self.reverse){
            center.x -= 100;
        }else{
            center.x += 100;
        }
        
        self.brownRectangle.center = center;
    }];
    
    // glides diagonally down to the right
    NSUInteger opts = UIViewAnimationOptionBeginFromCurrentState;
    
    // jumps right then glides straight down
//    NSUInteger opts = 0;
    
    [UIView animateWithDuration: 1 delay: 0 options: opts animations:^{
        CGPoint center = self.brownRectangle.center;
        if(self.reverse){
            center.y -= 100;
        }else{
            center.y += 100;
        }
        self.brownRectangle.center = center;
    } completion: ^(BOOL finished){
        self.reverse = !self.reverse;
    }];
}

#pragma mark - Auto Reverse
- (IBAction)repetitionStepperChanged:(UIStepper *)sender
{
    self.repetitionStepperValueLabel.text = [NSString stringWithFormat:@"repeat %0.f", sender.value + 1];
}

- (IBAction)purpleAutoReversingRunButtonPressed:(UIButton *)sender
{
    [self animate: self.repetitionStepper.value];
    
    sender.enabled = NO;
}


-(void) animate: (int) count
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
        if(count){
            [self animate: count - 1];
        }else{
            self.runAutoReversingButton.enabled = YES;
        }
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
    self.reverse = NO;
    self.overrideInheritedDurationReversed = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
