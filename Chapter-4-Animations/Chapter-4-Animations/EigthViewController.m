//
//  EigthViewController.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 6/07/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "EigthViewController.h"

@interface EigthViewController ()

@property (weak, nonatomic) IBOutlet UIView *view0;
@property CGRect image1Extent;
@property CIFilter *transition;
@property CFTimeInterval timestamp;
@property CIContext* ciContext;
@property double currentFrame;

@end

@implementation EigthViewController


- (IBAction)run0ButtonPressed
{
    
    [self runTransition];
}

-(void) runTransition
{
    // Create a CIImage for use with the transition as key = 'inputTargetImage'.
    UIImage* moi = [UIImage imageNamed:@"legs1"];
//    UIImage* moi = [UIImage imageNamed:@"moi"];
    CIImage* moi2 = [[CIImage alloc] initWithCGImage:moi.CGImage];
    self.image1Extent = moi2.extent;
    
    
    // Create a CIImage for use with the transition as key = 'inputImage'.
    CIFilter* col = [CIFilter filterWithName:@"CIConstantColorGenerator"];
    CIColor* cicol = [[CIColor alloc] initWithColor:[UIColor redColor]];
    [col setValue:cicol forKey:@"inputColor"];
    CIImage* colorimage = [col valueForKey: @"outputImage"];
    
    
    // Create the transition.
    CIFilter* tran = [CIFilter filterWithName:@"CIFlashTransition"];
    [tran setValue: colorimage forKey: @"inputImage"];
    [tran setValue: moi2 forKey: @"inputTargetImage"];
    CIVector* center = [CIVector vectorWithX: self.image1Extent.size.width/2.0 Y: self.image1Extent.size.height/2.0];
    [tran setValue:center forKey: @"inputCenter"];
    
    self.ciContext = [CIContext contextWithOptions: nil];
    self.transition = tran;
    self.timestamp = 0.0; // signal that we are starting
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        CADisplayLink* link = [CADisplayLink displayLinkWithTarget:self selector:@selector(nextFrame:)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *allFilters = [CIFilter filterNamesInCategories: nil];
    for (NSObject *filter in allFilters) {
        NSLog(@"CIFilter %@", filter);
    }
}

#define SCALE 1.0 // try 0.2 for slow motion, looks better in simulator
- (void) nextFrame: (CADisplayLink*) sender {
    
    if (self.timestamp < 0.01) { // pick up and store first timestamp
        self.timestamp = sender.timestamp;
        self.currentFrame = 0.0;
    } else { // calculate frame
        self.currentFrame = (sender.timestamp - self->_timestamp) * SCALE;
    }
    sender.paused = YES; // defend against frame loss
    
    [self.transition setValue:@(self.currentFrame) forKey:@"inputTime"];
    CGImageRef moi = [self.ciContext createCGImage:self.transition.outputImage
                                      fromRect:self.image1Extent];
    [CATransaction setDisableActions:YES];
    self.view0.layer.contents = (__bridge id)moi;
    CGImageRelease(moi);
    
    if (self.currentFrame > 1.0) {
        NSLog(@"%@", @"invalidate");
        [sender invalidate];
    }
    sender.paused = NO;
    
    NSLog(@"here %f", self.currentFrame); // useful for seeing dropped frame rate
}

@end
