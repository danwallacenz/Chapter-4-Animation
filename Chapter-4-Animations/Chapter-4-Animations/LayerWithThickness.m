//
//  LayerWithThickness.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 30/06/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "LayerWithThickness.h"

@interface LayerWithThickness ()

@property CGFloat thickness;

@end

@implementation LayerWithThickness

@dynamic thickness;

+ (BOOL)needsDisplayForKey: (NSString *)key
{
    if([key isEqualToString:@"thickness"]){
        return YES;
    }
    return [super needsDisplayForKey: key];
}

-(void) drawInContext:(CGContextRef)ctx
{
    CGRect rect = CGRectInset(self.bounds, 20, 20);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillRect(ctx, rect);
    CGContextSetLineWidth(ctx, self.thickness);
    CGContextStrokeRect(ctx, rect);
}

@end
