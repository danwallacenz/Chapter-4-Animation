//
//  SixthViewController.m
//  Chapter-4-Animations
//
//  Created by Daniel Wallace on 30/06/14.
//  Copyright (c) 2014 nz.co.datacom.danielw. All rights reserved.
//

#import "SixthViewController.h"
#import "CompassView.h"

@interface SixthViewController ()

@property (weak, nonatomic) CompassView *compassView;

@end

@implementation SixthViewController




#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Add a CompassView to to my view.  It has a CompassLayer as its layer.
    [self addACompassView];
}


-(void)addACompassView
{
    // Add a CompassView to to my view.  It has a CompassLayer as its layer.
    CompassView *compassView = [[CompassView alloc] initWithFrame:CGRectMake(100, 100, 400, 400)];
    [self.view addSubview: compassView];
    self.compassView = compassView; // for zPosition changes later.
}
@end
