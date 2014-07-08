//
//  NinthViewController.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 7/07/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "NinthViewController.h"

@interface NinthViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mars;

@property (strong, nonatomic)UIDynamicAnimator *animator;

@end

@implementation NinthViewController

- (IBAction)runButtonPressed:(UIButton *)sender
{
    UIGravityBehavior *gravity = [UIGravityBehavior new];
    /*
     If a dynamic behavior’s action block refers to the dynamic behavior
     itself, there’s a danger of a retain cycle, because the behavior retains
     the block which refers to the behavior. Express yourself in some other
     way (perhaps attaching the block to some other behavior), or use
     the weak–strong dance to break the retain cycle in the block.
     */
    gravity.action = ^{
        NSArray *visibleItems = [self.animator itemsInRect:self.view.bounds];
        if(NSNotFound ==[visibleItems indexOfObject:self.mars]){
            [self.animator removeAllBehaviors];
            [self.mars removeFromSuperview];
        }
    };
    
    [self.animator addBehavior:gravity];
    [gravity addItem:self.mars];
    
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.mars] mode:UIPushBehaviorModeInstantaneous];
    push.pushDirection = CGVectorMake(2, 0);
    [self.animator addBehavior:push];
    
    UICollisionBehavior *collision = [UICollisionBehavior new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

@end
