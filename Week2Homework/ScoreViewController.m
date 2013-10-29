//
//  ScoreViewController.m
//  Week2Homework
//
//  Created by Udo Hoppenworth on 10/28/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import "ScoreViewController.h"
#import "Game.h"


@implementation ScoreViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.highScores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Game *game = self.highScores[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d", game.score];
    return cell;
}

@end
