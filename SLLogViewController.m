//
//  SLLogViewController.m
//  SleepLogger
//
//  Created by Thomas Bibby on 29/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import "SLLogViewController.h"
#import "SLDataController.h"
#import "Sleeps.h"
#import "SLTimeViewController.h"

@interface SLLogViewController ()

@end

@implementation SLLogViewController
@synthesize sleepButton;
@synthesize interruptionButton;
@synthesize wakeButton;
@synthesize sleepLabel;
@synthesize interruptionLabel;
@synthesize wakeLabel;
@synthesize dateFormatter;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [wakeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [interruptionButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [sleepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    //set up the date formatter which we'll use to display when data was last entered
    dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDoesRelativeDateFormatting:YES];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //no data entered yet
    if([[SLDataController sharedController]numberOfSleeps]==0)
    {
        [sleepButton setUserInteractionEnabled:YES];
        
        [sleepLabel setText:NSLocalizedString(@"No Sleep data entered yet", @"")];
        [interruptionLabel setHidden:YES];
        [wakeLabel setHidden:YES];
        [interruptionButton setEnabled:NO];
        [wakeButton setEnabled:NO];
    }
    
    // else we have a last sleep, so let's check it to see if we're in the middle of a sleep or not
    else
    {
        Sleeps *lastSleep = [[SLDataController sharedController]lastSleep];
        //prepare the sleep label
        NSString *sleepPrefix = NSLocalizedString(@"Sleep time: ", @"sleep time prefix when we're in a sleep");
         NSString *interruptionsString = NSLocalizedString(@"Number of interruptions so far: ","prefix for number of interruptions");
        
        //are we in the middle of a sleep?
        if(![lastSleep sleepEnd])
        {
            [sleepButton setEnabled:NO];
            [interruptionButton setEnabled:YES];
            [wakeButton setEnabled:YES];
            
            [interruptionLabel setHidden:NO];
            [wakeLabel setHidden:YES];
            [sleepLabel setHidden:NO];
            
        }
        //else we haven't gone to bed yet
        else
        {
            sleepPrefix = NSLocalizedString(@"Last Sleep Time: ", @"sleep prefix when we're not in a sleep");
            interruptionsString = NSLocalizedString(@"Number of interruptions last sleep: ", @"interruptions prefix when we're not in the middle of a sleep");
            
            [sleepButton setEnabled:YES];
            [interruptionButton setEnabled:NO];
            [wakeButton setEnabled:NO];
            [sleepLabel setHidden:NO];
            [interruptionLabel setHidden:NO];
            [wakeLabel setHidden:YES];
            
        }
        
        //populate the sleep label
        
        NSString *lastSleepString = [sleepPrefix stringByAppendingString:[dateFormatter stringFromDate:[lastSleep sleepStart]]];
        [sleepLabel setText:lastSleepString];
        
        NSInteger numberOfInterruptions = [[lastSleep sleepInterruptions]count];
        [interruptionLabel setText:[interruptionsString stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)numberOfInterruptions]]];
    }
    
  
    
    
}

- (IBAction)sleepButtonTapped:(id)sender {
    SLTimeViewController *timeVC = [[SLTimeViewController alloc]init];
    //create a sleep object
    Sleeps *newSleep =[[SLDataController sharedController]createSleep];
    [newSleep setLocallyCreatedDate:[NSDate date]];
    [timeVC setCurrentSleep:newSleep];
    [timeVC setSettingForStart:YES];
    [self presentViewController:timeVC animated:YES completion:nil];
}

- (IBAction)interruptionButtonTapped:(id)sender {
    SLTimeViewController *timeVC = [[SLTimeViewController alloc]init];
    //create a sleep object
    Sleeps *newSleep =[[SLDataController sharedController]lastSleep];
    [timeVC setCurrentSleep:newSleep];
    [timeVC setSettingForInterruption:YES];
    [self presentViewController:timeVC animated:YES completion:nil];
}

- (IBAction)wakeButtonTapped:(id)sender {
    SLTimeViewController *timeVC = [[SLTimeViewController alloc]init];
    //create a sleep object
    Sleeps *newSleep =[[SLDataController sharedController]lastSleep];
    [timeVC setCurrentSleep:newSleep];
    [timeVC setSettingForEnd:YES];
    [self presentViewController:timeVC animated:YES completion:nil];
}
@end
