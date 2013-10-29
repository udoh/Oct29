//
//  ScoreViewController.h
//  Week2Homework
//
//  Created by Udo Hoppenworth on 10/28/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *highScores;

@end
