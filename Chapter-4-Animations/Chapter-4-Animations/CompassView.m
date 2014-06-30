//
//  CompassView.m
//  Chapter 3 Layers
//
//  Created by Daniel Wallace [DATACOM] on 12/05/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "CompassView.h"
#import "CompassLayer.h"

@implementation CompassView

+ (Class) layerClass
{
    return [CompassLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.layer.delegate = self;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



@end
