//
//  Rocket.m
//  Week2Homework
//
//  Created by Udo Hoppenworth on 10/25/13.
//  Copyright (c) 2013 Andrew Garrahan. All rights reserved.
//

#import "Rocket.h"

@implementation Rocket


- (id)initWithLocation:(CGPoint)point deltaX:(CGFloat)deltaX deltaY:(CGFloat)deltaY
{
    self = [super initWithLocation:point deltaX:deltaX deltaY:deltaY];
    if (self) {
        self.frame = CGRectMake(point.x, point.y, 15, 15);
    }
    return self;
}

- (void)stepWithScreenWidth:(CGFloat)width;
{
    self.center = CGPointMake(self.center.x + self.deltaX, self.center.y + self.deltaY);
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    
    [path addClip];

    [[UIColor redColor] setFill];
    [path fill];
}

@end
