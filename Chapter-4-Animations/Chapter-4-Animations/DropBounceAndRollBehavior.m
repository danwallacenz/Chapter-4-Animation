//
//  DropBounceAndRollBehavior.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 9/07/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "DropBounceAndRollBehavior.h"

@interface DropBounceAndRollBehavior() <UICollisionBehaviorDelegate>

@property (strong, nonatomic) UIView *view;

@end

@implementation DropBounceAndRollBehavior

-(instancetype)initWithView: (UIView *)view
{
    self = [super init];
    if(self){
        self.view = view;
    }
    return self;
}

- (void)willMoveToAnimator:(UIDynamicAnimator *)dynamicAnimator
{
    if (!dynamicAnimator) {
        return;
    }
    
    UIView *superView = dynamicAnimator.referenceView;
    // The gravity child.
    UIGravityBehavior *gravity = [UIGravityBehavior new];
    /*
     If a dynamic behavior’s action block refers to the dynamic behavior
     itself, there’s a danger of a retain cycle, because the behavior retains
     the block which refers to the behavior. Express yourself in some other
     way (perhaps attaching the block to some other behavior), or use
     the weak–strong dance to break the retain cycle in the block.
     */
    __weak DropBounceAndRollBehavior *weakSelf = self;
    gravity.action = ^{

        DropBounceAndRollBehavior *sself = weakSelf;
        if(sself){
        NSArray *visibleItems = [dynamicAnimator itemsInRect:superView.bounds];
            if(NSNotFound ==[visibleItems indexOfObject: self.view]){
                [dynamicAnimator removeBehavior: sself];
                [self.view removeFromSuperview];
                NSLog(@"%@", @"done");
            }
        }
    };
    
    [self addChildBehavior: gravity];
    [gravity addItem: self.view];
    
    // Git it a push to the right a bit.
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.view] mode:UIPushBehaviorModeInstantaneous];
    push.pushDirection = CGVectorMake(2, 0);
    [push setTargetOffsetFromCenter:UIOffsetMake(0, -200) forItem:self.view];
    [self addChildBehavior:push];
    
    // Collide with the floor. Dead cat bounce.
    UICollisionBehavior *collision = [UICollisionBehavior new];
    collision.collisionMode = UICollisionBehaviorModeBoundaries;
    collision.collisionDelegate = self;
    [collision addBoundaryWithIdentifier:@"floor"
                               fromPoint:CGPointMake(0, self.view.bounds.size.height)
                                 toPoint: CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    [self addChildBehavior:collision];
    [collision addItem:self.view];
    
    
    // Make it bounce up.
    UIDynamicItemBehavior *bounce = [UIDynamicItemBehavior new];
    bounce.elasticity = 0.4;
    [self addChildBehavior:bounce];
    [bounce addItem:self.view];
}

#pragma mark - UICollisionBehaviorDelegate

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    for (UIDynamicItemBehavior *theBehavior in self.childBehaviors) {
        if([theBehavior isKindOfClass:[UIDynamicItemBehavior class]]){
            
            NSLog(@"BoundaryIdentifier =  %@", identifier);
            NSLog(@"%@", NSStringFromCGPoint(p));
            
            UIDynamicItemBehavior *bounce = (UIDynamicItemBehavior*)theBehavior;
            CGFloat angularVelocity = [bounce angularVelocityForItem:self.view];
            NSLog(@"angularVelocity = %f", angularVelocity);
            if(angularVelocity <= abs(0.1)){ // Do this just once.
                NSLog(@"%@", @"adding angular velocity");
                [bounce addAngularVelocity:30 forItem:self.view];
                NSLog(@"angularVelocity now = %f", [bounce angularVelocityForItem:self.view]);
            }
            break;
        }
    }
}

@end
