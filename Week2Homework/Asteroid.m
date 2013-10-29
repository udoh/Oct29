//
//  Asteroid.m
//  Week2Homework
//
//  Created by Udo Hoppenworth on 10/25/13.
//  Copyright (c) 2013 Andrew Garrahan. All rights reserved.
//

#import "Asteroid.h"

@implementation Asteroid


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initMakeMeABox{
    
    CGRect frame = CGRectMake(0, 0, 30, 30);
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.backgroundColor = [UIColor blueColor];
        
        _deltaX = 0.2;
        _deltaY = 0.5;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        UIImage *image = [UIImage imageNamed:@"asteroid.png"];
        imageView.image = image;
        [self addSubview:imageView];
    }
    return self;
}

- (id)initWithLocation:(CGPoint)point deltaX:(CGFloat)deltaX deltaY:(CGFloat)deltaY
{
    CGRect frame = CGRectMake(point.x, point.y, 20, 20);
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        _deltaX = deltaX;
        _deltaY = deltaY;
    }
    return self;
}

@end
