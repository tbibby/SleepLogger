//
//  SLLogViewController.h
//  SleepLogger
//
//  Created by Thomas Bibby on 29/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLLogViewController : UIViewController





@property (weak, nonatomic) IBOutlet UIButton *sleepButton;
@property (weak, nonatomic) IBOutlet UIButton *interruptionButton;
@property (weak, nonatomic) IBOutlet UIButton *wakeButton;

@property (weak, nonatomic) IBOutlet UILabel *sleepLabel;
@property (strong, nonatomic) IBOutlet UILabel *interruptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *wakeLabel;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;


- (IBAction)sleepButtonTapped:(id)sender;
- (IBAction)interruptionButtonTapped:(id)sender;
- (IBAction)wakeButtonTapped:(id)sender;

@end
