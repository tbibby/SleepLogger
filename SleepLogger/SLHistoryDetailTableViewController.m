//
//  SLHistoryDetailTableViewController.m
//  SleepLogger
//
//  Created by Thomas Bibby on 06/04/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import "SLHistoryDetailTableViewController.h"
#import "SLCenteredTableViewCell.h"
#import "Sleeps.h"
#import "Interruptions.h"
#import "SLDataController.h"

@interface SLHistoryDetailTableViewController ()

@end

@implementation SLHistoryDetailTableViewController
@synthesize formatterTime;
@synthesize formatterDate;
@synthesize currentSleep;
@synthesize interruptionsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
        [[self tableView] registerNib:[UINib nibWithNibName:@"SLCenteredTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SLCenteredTableViewCell"];
        formatterDate = [[NSDateFormatter alloc]init];
        formatterTime = [[NSDateFormatter alloc]init];
        [formatterDate setDateStyle:NSDateFormatterMediumStyle];
        [formatterDate setTimeStyle:NSDateFormatterNoStyle];
        [formatterTime setDateStyle:NSDateFormatterNoStyle];
        [formatterTime setTimeStyle:NSDateFormatterShortStyle];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    interruptionsArray = [[currentSleep sleepInterruptions]allObjects];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 2)
    {
        return [[currentSleep sleepInterruptions]count];
    }
    else{
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier =  @"SLCenteredTableViewCell";
    SLCenteredTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//    if(!cell)
//    {
//        cell = [[SLCenteredTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
    
    
    NSLog(@"Wir haben ein cell");
    
    if([indexPath section] == 0)
    {
        [[cell centreLabel]setText:[formatterDate stringFromDate:[currentSleep sleepStart]]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else if([indexPath section] == 1)
    {
        NSString *timeRangeText = [NSString stringWithFormat:@"%@ - %@",[formatterTime stringFromDate:[currentSleep sleepStart]],[formatterTime stringFromDate:[currentSleep sleepEnd]]];
        [[cell centreLabel]setText:timeRangeText];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else if([indexPath section] == 2)
    {
        NSDate *interruptionTime = [[interruptionsArray objectAtIndex:[indexPath row]]interruptionTime];
        
        [[cell centreLabel]setText:[formatterTime stringFromDate:interruptionTime]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else if([indexPath section] == 3)
    {
        [[cell centreLabel]setText:@"Delete"];
        [cell setBackgroundColor:[UIColor redColor]];
    }
    
    // Configure the cell...
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *stringToReturn;
    if(section == 0)
    {
        stringToReturn = @"Date";
    }
    else if (section == 1)
    {
        stringToReturn = @"Time";
    }
    else if (section == 2)
    {
        if([[currentSleep sleepInterruptions]count]>0)
        {
            stringToReturn = @"Interruptions";
        }
        
    }
    return stringToReturn;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section] == 3)
    {
        for (Interruptions *i in [currentSleep sleepInterruptions])
        {
            [[SLDataController sharedController]deleteInterruption:i];
        }
        [[SLDataController sharedController]deleteSleep:currentSleep];
        [[self navigationController]popViewControllerAnimated:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
