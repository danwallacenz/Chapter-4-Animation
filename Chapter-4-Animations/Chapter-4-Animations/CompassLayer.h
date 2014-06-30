//
//  CompassLayer.h
//  Chapter 3 Layers
//
//  Created by Daniel Wallace [DATACOM] on 12/05/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CompassLayer : CALayer
@property (strong , nonatomic) CALayer *rotationLayer;
@end
