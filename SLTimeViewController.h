//
//  SLTimeViewController.h
//  SleepLogger
//
//  Created by Thomas Bibby on 31/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Sleeps;

@interface SLTimeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *picker;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

@property (nonatomic, strong) Sleeps *currentSleep;
@property (nonatomic, strong) NSDate *now;

@property BOOL settingForStart;
@property BOOL settingForEnd;
@property BOOL settingForInterruption;

- (IBAction)tappedCancel:(id)sender;
- (IBAction)tappedSave:(id)sender;

@end
