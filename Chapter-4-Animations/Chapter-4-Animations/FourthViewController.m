//
//  FourthViewController.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 28/06/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "FourthViewController.h"
#import "RectangleOrEllipseView.h"

@interface FourthViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *flipImageView;
@property BOOL flipped;
@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView;

@end

@implementation FourthViewController

- (IBAction)flipButton:(UIButton *)sender
{
    [UIView transitionWithView:self.flipImageView duration:0.8 options: UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.flipImageView.image = self.flipped?[UIImage imageNamed:@"Mars"]:[UIImage imageNamed:@"smileyiPhone"];
    } completion:^(BOOL finished){
        self.flipped = !self.flipped;
    }];
    
}
- (IBAction)flipRectangleOrEllipseButtonPressed:(UIButton *)sender
{
    [self.rectangleOrEllipseView flip];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.flipped = NO;
    
    self.rectangleOrEllipseView = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(20.0, 200.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView];
}

@end
