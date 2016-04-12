//
//  SLHistoryDetailTableViewController.h
//  SleepLogger
//
//  Created by Thomas Bibby on 06/04/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Sleeps;

@interface SLHistoryDetailTableViewController : UITableViewController
@property (nonatomic, strong) NSDateFormatter *formatterDate;
@property (nonatomic, strong) NSDateFormatter *formatterTime;
@property (nonatomic, strong) Sleeps *currentSleep;
@property (nonatomic, strong) NSArray *interruptionsArray;

@end
