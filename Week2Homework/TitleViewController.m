//
//  ViewController.m
//  Week2Homework
//
//  Created by Udo Hoppenworth on 10/28/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import "TitleViewController.h"
#import "GameViewController.h"
#import "Game.h"

@interface TitleViewController ()
@property (strong, nonatomic) NSMutableArray *games;
@end


@implementation TitleViewController

- (NSMutableArray *)games
{
    if (!_games) {
        _games = [[NSMutableArray alloc] init];
    }
    return _games;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self animateTitleView];
}

- (void)animateTitleView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.titleLabel.transform = CGAffineTransformMakeRotation(0.05);
        self.titleLabel.center = CGPointMake(160, 185);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.titleLabel.transform = CGAffineTransformMakeRotation(-0.05);
            self.titleLabel.center = CGPointMake(160, 185);
        } completion:^(BOOL finished) {
            [self animateTitleView];
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"startGame"]) {
        if ([segue.destinationViewController isKindOfClass:[GameViewController class]]) {
            GameViewController *gvc = segue.destinationViewController;
            Game *newGame = [[Game alloc] init];
            [self.games addObject:newGame];
            gvc.games = self.games;
        }
    }
}

- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
    [self updateHighScore];
}

- (void)updateHighScore
{
    int highScore = 0;
    
    for (Game *game in self.games) {
        if (game.score > highScore) {
            highScore = game.score;
        }
    }
    self.highScoreLabel.text = [NSString stringWithFormat:@"High Score: %d", highScore];
}


@end
