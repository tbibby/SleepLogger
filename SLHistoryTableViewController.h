//
//  SLHistoryTableViewController.h
//  SleepLogger
//
//  Created by Thomas Bibby on 31/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLHistoryTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSDateFormatter *formatterDate;
@property (strong, nonatomic) NSDateFormatter *formatterTime;

@end
