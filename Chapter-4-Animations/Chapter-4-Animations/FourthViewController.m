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
@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView2;
@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView3;
@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView4;

@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView5;
@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView6;
@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView7;
@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView8;
@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView9;
@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView10;
@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView11;
@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView12;
@property (strong, nonatomic) RectangleOrEllipseView *rectangleOrEllipseView13;

@property (weak, nonatomic) IBOutlet UISegmentedControl *UIViewAnimationOptionTransitionSegmentedControl;

@property (strong, nonatomic) IBOutlet UILabel *flipLabel; // default is weak but needs to be strong to retain and flip back
@property (strong,nonatomic) UILabel *flippedLabel;
@property BOOL labelFlipped;
@end

@implementation FourthViewController

#pragma mark - transitionFromView:toView:

- (IBAction)flipLabelButtonPressed:(UIButton *)sender
{

    if(!self.labelFlipped){
        [UIView transitionFromView: self.flipLabel
                            toView: self.flippedLabel
                          duration: 0.8
                           options: UIViewAnimationOptionTransitionFlipFromLeft
                        completion: ^(BOOL finished){
                            self.labelFlipped = !self.labelFlipped;
                        }];
    }else{
        [UIView transitionFromView: self.flippedLabel
                            toView: self.flipLabel
                          duration: 0.8
                           options: UIViewAnimationOptionTransitionFlipFromLeft
                        completion: ^(BOOL finished){
                            self.labelFlipped = !self.labelFlipped;
                        }];
    }
}


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
    
    // animate view 0
    CGRect originalBounds0 = self.rectangleOrEllipseView0.bounds;
    self.rectangleOrEllipseView0.bounds = newBounds;
    [UIView transitionWithView: self.rectangleOrEllipseView0 duration: .4 options: opts animations:^{
        self.rectangleOrEllipseView0.bounds = originalBounds0;
        [self.rectangleOrEllipseView0 setNeedsDisplay];
        
    } completion:nil];
    
    // animate view 1
    CGRect originalBounds1 = self.rectangleOrEllipseView1.bounds;
    self.rectangleOrEllipseView1.bounds = newBounds;
    [UIView transitionWithView: self.rectangleOrEllipseView1 duration: .45 options: opts animations:^{
        self.rectangleOrEllipseView1.bounds = originalBounds1;
        [self.rectangleOrEllipseView1 setNeedsDisplay];
    } completion:nil];
    
    // animate view 2
    CGRect originalBounds2 = self.rectangleOrEllipseView2.bounds;
    self.rectangleOrEllipseView2.bounds = newBounds;
    [UIView transitionWithView: self.rectangleOrEllipseView2 duration: .5 options: opts animations:^{
        self.rectangleOrEllipseView2.bounds = originalBounds2;
        [self.rectangleOrEllipseView2 setNeedsDisplay];
    } completion:nil];
    
    // animate view 3
    CGRect originalBounds3 = self.rectangleOrEllipseView3.bounds;
    self.rectangleOrEllipseView3.bounds = newBounds;
    [UIView transitionWithView: self.rectangleOrEllipseView3 duration: .55 options: opts animations:^{
        self.rectangleOrEllipseView3.bounds = originalBounds3;
        [self.rectangleOrEllipseView3 setNeedsDisplay];
    } completion:nil];
    
    // animate view 4
    CGRect originalBounds4 = self.rectangleOrEllipseView4.bounds;
    self.rectangleOrEllipseView4.bounds = newBounds;
    [UIView transitionWithView: self.rectangleOrEllipseView4 duration: .6 options: opts animations:^{
        self.rectangleOrEllipseView4.bounds = originalBounds4;
        [self.rectangleOrEllipseView4 setNeedsDisplay];
    } completion:nil];
    
    // animate view 5
    CGRect originalBounds5 = self.rectangleOrEllipseView5.bounds;
    self.rectangleOrEllipseView5.bounds = newBounds;
    [UIView transitionWithView: self.rectangleOrEllipseView5 duration: .65 options: opts animations:^{
        self.rectangleOrEllipseView5.bounds = originalBounds5;
        [self.rectangleOrEllipseView5 setNeedsDisplay];
    } completion:nil];
    
    // animate view 6
    CGRect originalBounds6 = self.rectangleOrEllipseView6.bounds;
    self.rectangleOrEllipseView6.bounds = newBounds;
    [UIView transitionWithView: self.rectangleOrEllipseView6 duration: .7 options: opts animations:^{
        self.rectangleOrEllipseView6.bounds = originalBounds6;
        [self.rectangleOrEllipseView6 setNeedsDisplay];
    } completion:nil];
    
    // animate view 7
    CGRect originalBounds7 = self.rectangleOrEllipseView7.bounds;
    self.rectangleOrEllipseView7.bounds = newBounds;
    [UIView transitionWithView: self.rectangleOrEllipseView7 duration: .75 options: opts animations:^{
        self.rectangleOrEllipseView7.bounds = originalBounds7;
        [self.rectangleOrEllipseView7 setNeedsDisplay];
    } completion:nil];
    
    // animate view 8
    CGRect originalBounds8 = self.rectangleOrEllipseView8.bounds;
    self.rectangleOrEllipseView8.bounds = newBounds;
    [UIView transitionWithView: self.rectangleOrEllipseView8 duration: .8 options: opts animations:^{
        self.rectangleOrEllipseView8.bounds = originalBounds8;
        [self.rectangleOrEllipseView8 setNeedsDisplay];
    } completion:nil];
    
    // animate view 9
    CGRect originalBounds9 = self.rectangleOrEllipseView9.bounds;
    self.rectangleOrEllipseView9.bounds = newBounds;
    [UIView transitionWithView: self.rectangleOrEllipseView9 duration: .85 options: opts animations:^{
        self.rectangleOrEllipseView9.bounds = originalBounds9;
        [self.rectangleOrEllipseView9 setNeedsDisplay];
    } completion:nil];
    
    // animate view 10
    CGRect originalBounds10 = self.rectangleOrEllipseView10.bounds;
    self.rectangleOrEllipseView10.bounds = newBounds;
    [UIView transitionWithView: self.rectangleOrEllipseView10 duration: .9 options: opts animations:^{
        self.rectangleOrEllipseView10.bounds = originalBounds10;
        [self.rectangleOrEllipseView10 setNeedsDisplay];
    } completion:nil];
    
    // animate view 11
    CGRect originalBounds11 = self.rectangleOrEllipseView11.bounds;
    self.rectangleOrEllipseView11.bounds = newBounds;
    [UIView transitionWithView: self.rectangleOrEllipseView11 duration: .95 options: opts animations:^{
        self.rectangleOrEllipseView11.bounds = originalBounds11;
        [self.rectangleOrEllipseView11 setNeedsDisplay];
    } completion:nil];
    
    // animate view 12
    CGRect originalBounds12 = self.rectangleOrEllipseView12.bounds;
    self.rectangleOrEllipseView12.bounds = newBounds;
    [UIView transitionWithView: self.rectangleOrEllipseView12 duration: 1 options: opts animations:^{
        self.rectangleOrEllipseView12.bounds = originalBounds12;
        [self.rectangleOrEllipseView12 setNeedsDisplay];
    } completion:nil];
    
    // animate view 13
    CGRect originalBounds13 = self.rectangleOrEllipseView13.bounds;
    self.rectangleOrEllipseView13.bounds = newBounds;
    [UIView transitionWithView: self.rectangleOrEllipseView13 duration: 1.05 options: opts animations:^{
        self.rectangleOrEllipseView13.bounds = originalBounds13;
        [self.rectangleOrEllipseView13 setNeedsDisplay];
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
    
    self.rectangleOrEllipseView2 = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(20.0, 400.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView2];
    
    self.rectangleOrEllipseView3 = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(20.0, 500.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView3];
    
    self.rectangleOrEllipseView4 = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(20.0, 600.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView4];
    
    self.rectangleOrEllipseView5 = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(120.0, 600.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView5];
    
    self.rectangleOrEllipseView6 = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(220.0, 600.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView6];
    
    self.rectangleOrEllipseView7 = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(320.0, 600.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView7];
    
    self.rectangleOrEllipseView8 = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(420.0, 600.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView8];
    
    self.rectangleOrEllipseView9 = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(520.0, 600.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView9];
    
    self.rectangleOrEllipseView10 = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(620.0, 600.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView10];
    
    self.rectangleOrEllipseView11 = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(720.0, 600.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView11];
    
    self.rectangleOrEllipseView12 = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(820.0, 600.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView12];
    
    self.rectangleOrEllipseView13 = [[RectangleOrEllipseView alloc]initWithFrame: CGRectMake(920.0, 600.0, 100.0, 100.0)];
    [self.view addSubview:self.rectangleOrEllipseView13];
    
    
    self.flippedLabel =[[UILabel alloc] initWithFrame:self.flipLabel.frame];
    self.flippedLabel.text = @"Bad!";
    [self.flippedLabel sizeToFit];
    self.labelFlipped = NO;
}

@end
