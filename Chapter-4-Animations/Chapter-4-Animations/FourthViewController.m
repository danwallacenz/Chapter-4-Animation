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
@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView0;
@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView1;

@property (weak, nonatomic) IBOutlet UISegmentedControl *UIViewAnimationOptionTransitionSegmentedControl;

@end

@implementation FourthViewController

#pragma mark -  flip mars

- (IBAction)flipButton:(UIButton *)sender
{
    [UIView transitionWithView:self.flipImageView duration:0.8 options: UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.flipImageView.image = self.flipped?[UIImage imageNamed:@"Mars"]:[UIImage imageNamed:@"smileyiPhone"];
    } completion:^(BOOL finished){
        self.flipped = !self.flipped;
    }];
    
}

#pragma mark -  flip rectangle to ellipse

- (IBAction)flipRectangleOrEllipseButtonPressed:(UIButton *)sender
{
    [self flip];
}

-(void) flip
{
    
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
    
    
    
    opts = opts | UIViewAnimationOptionAllowAnimatedContent; // makes no difference
    
    CGRect newBounds = CGRectMake(0, 0, 0, 0);
    
    CGRect originalBounds0 = self.rectangleOrEllipseView0.bounds;
    self.rectangleOrEllipseView0.bounds = newBounds;
    

    
    [UIView transitionWithView: self.rectangleOrEllipseView0 duration: 0.8 options: opts animations:^{
        self.rectangleOrEllipseView0.bounds = originalBounds0;
        [self.rectangleOrEllipseView0 setNeedsDisplay];
        
    } completion:nil];
    
    CGRect originalBounds1 = self.rectangleOrEllipseView1.bounds;
    self.rectangleOrEllipseView1.bounds = newBounds;
    
    [UIView transitionWithView: self.rectangleOrEllipseView1 duration: 1 options: opts animations:^{
        
        self.rectangleOrEllipseView1.bounds = originalBounds1;
        [self.rectangleOrEllipseView1 setNeedsDisplay];
        
    } completion:nil];
}

#pragma mark - UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.flipped = NO;
    
    self.rectangleOrEllipseView0 = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(20.0, 200.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView0];
    
    self.rectangleOrEllipseView1 = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(20.0, 300.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView1];
}

@end
