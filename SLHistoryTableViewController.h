//
//  SLHistoryTableViewController.h
//  SleepLogger
//
//  Created by Thomas Bibby on 31/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLHistoryTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
@property (strong, nonatomic) NSDateFormatter *formatterDate;
@property (strong, nonatomic) NSDateFormatter *formatterTime;

@end
