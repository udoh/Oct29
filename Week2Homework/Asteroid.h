//
//  Asteroid.h
//  Week2Homework
//
//  Created by Udo Hoppenworth on 10/25/13.
//  Copyright (c) 2013 Andrew Garrahan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Asteroid : UIView

@property (nonatomic) CGFloat deltaX;
@property (nonatomic) CGFloat deltaY;

- (id)initMakeMeABox;
- (id)initWithLocation:(CGPoint)point deltaX:(CGFloat)deltaX deltaY:(CGFloat)deltaY;

@end
