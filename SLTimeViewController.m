//
//  SLTimeViewController.m
//  SleepLogger
//
//  Created by Thomas Bibby on 31/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import "SLTimeViewController.h"
#import "SLDataController.h"
#import "Sleeps.h"
#import "Interruptions.h"

@interface SLTimeViewController ()

@end

@implementation SLTimeViewController

@synthesize now;
@synthesize currentSleep;
@synthesize picker;
@synthesize notesTextView;
@synthesize settingForEnd;
@synthesize settingForStart;
@synthesize settingForInterruption;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    now = [NSDate date];
    if(settingForStart || settingForEnd)
    {
        [notesTextView setHidden:YES];
    }
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tappedCancel:(id)sender {
    if(settingForStart)
    {
        [[SLDataController sharedController]deleteSleep:currentSleep];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tappedSave:(id)sender {
    if(settingForStart)
    {
        [currentSleep setSleepStart:[picker date]];
    }
    else if(settingForEnd)
    {
        [currentSleep setSleepEnd:[picker date]];
    }
    else if(settingForInterruption)
    {
        Interruptions *newInterruption = [[SLDataController sharedController]createInterruption];
        [newInterruption setLocallyCreatedDate:[NSDate date]];
        [newInterruption setInterruptionTime:[picker date]];
        [newInterruption setInterruptionDetails:[notesTextView text]];
        [newInterruption setInterruptionSleep:currentSleep];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
