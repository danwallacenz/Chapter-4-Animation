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

@property (weak, nonatomic) IBOutlet UISegmentedControl *UIViewAnimationOptionTransitionSegmentedControl;
@property BOOL flipRectangleOrEllipseReverse;
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
    [self flip];
}

-(void) flip
{
    
    /*
     UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
     UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
     UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
     UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
     UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
     UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
     UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
     */
    
    NSUInteger opts;
    switch (self.UIViewAnimationOptionTransitionSegmentedControl.selectedSegmentIndex) {
        case 0:
            opts = UIViewAnimationOptionTransitionFlipFromLeft;
            break;
        case 1:
            opts = UIViewAnimationOptionTransitionFlipFromRight;
            break;
        case 2:
            opts = UIViewAnimationOptionTransitionCurlUp;
            break;
        case 3:
            opts = UIViewAnimationOptionTransitionCurlDown;
            break;
        case 4:
            opts = UIViewAnimationOptionTransitionCrossDissolve;
            break;
        case 5:
            opts = UIViewAnimationOptionTransitionFlipFromTop;
            break;
        case 6:
            opts = UIViewAnimationOptionTransitionFlipFromBottom;
            break;
        case 7:
            opts = UIViewAnimationOptionTransitionNone;
            break;
        default:
            opts = UIViewAnimationOptionTransitionNone;
            break;
    }
    
    
    
//    opts = opts | UIViewAnimationOptionAllowAnimatedContent; // makes no difference
    
    self.flipRectangleOrEllipseReverse = !self.flipRectangleOrEllipseReverse;
    [UIView transitionWithView: self.rectangleOrEllipseView duration: 1 options: opts animations:^{
        [self.rectangleOrEllipseView setNeedsDisplay];
    } completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.flipped = NO;
    
    self.flipRectangleOrEllipseReverse = NO;
    
    self.rectangleOrEllipseView = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(20.0, 200.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView];
}

@end
