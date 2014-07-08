//
//  NinthViewController.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 7/07/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "NinthViewController.h"

@interface NinthViewController () <UICollisionBehaviorDelegate, UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mars;

@property (strong, nonatomic)UIDynamicAnimator *animator;

@end

@implementation NinthViewController

- (IBAction)runButtonPressed:(UIButton *)sender
{
    [sender setEnabled:NO];
    // Fall stright down.
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
            NSLog(@"%@", @"done");
        }
    };
    
    [self.animator addBehavior:gravity];
    [gravity addItem:self.mars];
    
    // Git it a push to the right a bit.
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.mars] mode:UIPushBehaviorModeInstantaneous];
    push.pushDirection = CGVectorMake(2, 0);
    [push setTargetOffsetFromCenter:UIOffsetMake(0, -200) forItem:self.mars];
    [self.animator addBehavior:push];
    
    // Collide with the floor. Dead cat bounce.
    UICollisionBehavior *collision = [UICollisionBehavior new];
    collision.collisionMode = UICollisionBehaviorModeBoundaries;
    collision.collisionDelegate = self;
    [collision addBoundaryWithIdentifier:@"floor"
                               fromPoint:CGPointMake(0, self.view.bounds.size.height)
                                 toPoint: CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.animator addBehavior:collision];
    [collision addItem:self.mars];
    
    
    // Make it bounce up.
    UIDynamicItemBehavior *bounce = [UIDynamicItemBehavior new];
    bounce.elasticity = 0.4;
    [self.animator addBehavior:bounce];
    [bounce addItem:self.mars];
}

#pragma mark - UICollisionBehaviorDelegate

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    for (UIDynamicItemBehavior *theBehavior in self.animator.behaviors) {
        if([theBehavior isKindOfClass:[UIDynamicItemBehavior class]]){
            
            NSLog(@"BoundaryIdentifier =  %@", identifier);
            NSLog(@"%@", NSStringFromCGPoint(p));
            
            UIDynamicItemBehavior *bounce = (UIDynamicItemBehavior*)theBehavior;
            CGFloat angularVelocity = [bounce angularVelocityForItem:self.mars];
            NSLog(@"angularVelocity = %f", angularVelocity);
            if(angularVelocity <= abs(0.1)){ // Do this just once.
                 NSLog(@"%@", @"adding angular velocity");
                [bounce addAngularVelocity:30 forItem:self.mars];
                NSLog(@"angularVelocity now = %f", [bounce angularVelocityForItem:self.mars]);
            }
            break;
        }
    }
}


#pragma mark - UIViewCOntroller methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator.delegate = self;
}

#pragma mark - UIDynamicAnimatorDelegate methods
-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    NSLog(@"%@", @"pause");
}

-(void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator {
    NSLog(@"%@", @"resume");
}
@end
