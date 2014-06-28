//
//  RectangleOrEllipseView.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 28/06/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "RectangleOrEllipseView.h"

@interface RectangleOrEllipseView()

@property BOOL reverse;

@end

@implementation RectangleOrEllipseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.reverse = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void) flip
{
    self.reverse = !self.reverse;
    [UIView transitionWithView:self duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [self setNeedsDisplay];
    } completion:nil];
}

/*
 UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
 UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
 UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
 UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
 UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
 UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
 UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
*/

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect frame = CGRectInset(self.bounds, 10, 10);
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(con, [self randomColor].CGColor);
    CGContextSetFillColorWithColor(con, [self randomColor].CGColor);
    if(self.reverse){
       
        CGContextFillEllipseInRect(con, frame);
         CGContextStrokeEllipseInRect(con, frame);
    }else{
        CGContextFillRect(con, frame);
        CGContextStrokeRect(con, frame);
    }
}

-(UIColor *)randomColor
{
    CGFloat redValue    = (arc4random() % 255) / 255.0f;
    CGFloat greenValue  = (arc4random() % 255) / 255.0f;
    CGFloat blueValue   = (arc4random() % 255) / 255.0f;
    
    return [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0f];
}


@end
