//
//  GameViewController.h
//  Week2Homework
//
//  Created by Udo Hoppenworth on 10/28/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"


@interface GameViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *games;
@property (nonatomic, readonly) Game *currentGame;

@end
