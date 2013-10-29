//
//  GameViewController.m
//  Week2Homework
//
//  Created by Udo Hoppenworth on 10/28/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import "GameViewController.h"
#import "ScoreViewController.h"
#import "Asteroid.h"
#import "Rocket.h"
#import "Game.h"

#define SCREEN_WIDTH self.view.frame.size.width
#define SCREEN_HEIGHT self.view.frame.size.height
#define NUM_ASTEROIDS 50


@implementation GameViewController {
    
    NSMutableSet * asteriods;
    NSMutableSet *rockets;
    
    NSMutableSet *deletedAsteroids;
    NSMutableSet *deletedRockets;
    
    NSTimer * spawnBox;
    BOOL isGameOver;
    int numAsteroids;
}

- (Game *)currentGame
{
    return [self.games lastObject];
}

- (void)viewDidLoad
{
    asteriods = [[NSMutableSet alloc] init];
    rockets = [[NSMutableSet alloc] init];
    deletedAsteroids = [[NSMutableSet alloc] init];
    deletedRockets = [[NSMutableSet alloc] init];
    
    isGameOver = NO;
    numAsteroids = 0;
    
    CADisplayLink * displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(stepWorld)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    spawnBox = [NSTimer scheduledTimerWithTimeInterval:3.0/12.0 target:self selector:@selector(spawnABox) userInfo:nil repeats:YES];
}

- (void)spawnABox
{
    numAsteroids++;
    
    if (!isGameOver) {
        Asteroid *temp = [[Asteroid alloc]initMakeMeABox];
        
        int radX = arc4random() % (int)SCREEN_HEIGHT;
        
        //nt radX = SCREEN_WIDTH * 0.5;
        int radY = SCREEN_HEIGHT * 0.0;
        
        temp.center = CGPointMake(radX, radY);
        
        temp.deltaX = 0;  // + arc4random() % 2;
        temp.deltaY = 0.5 + arc4random() % 5;
        
        [self.view addSubview:temp];
        
        // add to array
        [asteriods addObject:temp];
    } else {
        return;
    }
    
    if (numAsteroids >= NUM_ASTEROIDS) {
        isGameOver = YES;
        [self gameOver];
    }
}

- (void)stepWorld
{
    for (Rocket *rocket in rockets) {
        rocket.center = CGPointMake(rocket.center.x + rocket.deltaX, rocket.center.y + rocket.deltaY);
        if (!CGRectIntersectsRect(rocket.frame, self.view.bounds)) {
            [deletedRockets addObject:rocket];
        }
    }
    
    // Update center
    for (Asteroid *asteroid in asteriods) {
        asteroid.center = CGPointMake(asteroid.center.x + asteroid.deltaX, asteroid.center.y + asteroid.deltaY);
        
        if (!CGRectIntersectsRect(asteroid.frame, self.view.bounds)) {
            [deletedAsteroids addObject:asteroid];
        }
        
        // bounce only if asteriod
        if ([asteroid isMemberOfClass:[Asteroid class]]) {
            if (asteroid.center.x > SCREEN_WIDTH) {
                asteroid.deltaX *= -1;
            } else if (asteroid.center.x < 0) {
                asteroid.deltaX *= -1;
            }
            
            for (Rocket *rocket in rockets) {
                if (CGRectIntersectsRect(asteroid.frame, rocket.frame)) {
                    [deletedAsteroids addObject:asteroid];
                    [asteroid removeFromSuperview];
                    [deletedRockets addObject:rocket];
                    [rocket removeFromSuperview];
                    self.currentGame.score += 10;
                }
            }
        }
    }
    
    [asteriods minusSet:deletedAsteroids];
    [rockets minusSet:deletedRockets];
    
    [deletedAsteroids removeAllObjects];
    [deletedRockets removeAllObjects];

}

- (void)shootAtPoint:(CGPoint)point
{
    // Calculate the shoot angle (distance for velocity?)
    CGPoint launchPoint = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT);
    
    CGFloat dx = point.x - launchPoint.x;
    CGFloat dy = point.y - launchPoint.y;
    
    //CGFloat angleRad = atan(dy/dx);
    //CGFloat angleDeg = angleRad * (180 / M_PI);
    
    CGFloat speedFactor = 50;
    
    // Spawn rocket from bottom center of screen
    Rocket *rocket = [[Rocket alloc] initWithLocation:launchPoint deltaX:dx/speedFactor deltaY:dy/speedFactor];
    rocket.backgroundColor = [UIColor clearColor];
    //[asteriods addObject:rocket];
    [rockets addObject:rocket];
    [self.view addSubview:rocket];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    [self shootAtPoint:point];
}

- (void)gameOver
{
    [self performSegueWithIdentifier:@"showScore" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showScore"]) {
        if ([segue.destinationViewController isKindOfClass:[ScoreViewController class]]) {
            ScoreViewController *svc = segue.destinationViewController;
            svc.highScores = [self.games sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                NSNumber *aScore = @(((Game *)a).score);
                NSNumber *bScore = @(((Game *)b).score);
                return [bScore compare:aScore];
            }];
        }
    }
}

@end
