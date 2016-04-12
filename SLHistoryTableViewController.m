//
//  SLHistoryTableViewController.m
//  SleepLogger
//
//  Created by Thomas Bibby on 31/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import "SLHistoryTableViewController.h"
#import "SLDataController.h"
#import "Sleeps.h"
#import "SLHistoryTableViewCell.h"
#import "SLHistoryDetailTableViewController.h"

@interface SLHistoryTableViewController ()

@end

@implementation SLHistoryTableViewController
@synthesize formatterDate;
@synthesize formatterTime;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
  //  [[self tableView] registerClass:[SLHistoryTableViewCell class] forCellReuseIdentifier: @"SLHistoryTableViewCell"];
    formatterDate = [[NSDateFormatter alloc]init];
    formatterTime = [[NSDateFormatter alloc]init];
    [formatterDate setDateStyle:NSDateFormatterMediumStyle];
    [formatterDate setTimeStyle:NSDateFormatterNoStyle];
    [formatterTime setDateStyle:NSDateFormatterNoStyle];
    [formatterTime setTimeStyle:NSDateFormatterShortStyle];
    [[self navigationItem]setTitle:@"History"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView]reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[[SLDataController sharedController]allSleeps]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier =  @"SLHistoryTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    Sleeps *currentSleep = [[[SLDataController sharedController]allSleepsNewestFirst]objectAtIndex:[indexPath row]];
    [[cell textLabel]setText:[formatterDate stringFromDate:[currentSleep sleepStart]]];
    NSString *sleepTimeString =[formatterTime stringFromDate:[currentSleep sleepStart]];
    if(currentSleep.sleepEnd)
    {
        sleepTimeString = [sleepTimeString stringByAppendingFormat:@" - %@", [formatterTime stringFromDate:[currentSleep sleepEnd]]];
    }
    sleepTimeString = [sleepTimeString stringByAppendingFormat:@" (%lu)",[[currentSleep sleepInterruptions]count]];
    NSLog(@"sleep time: %@",sleepTimeString);
    
    [[cell detailTextLabel] setText:sleepTimeString];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLHistoryDetailTableViewController *detailtvc = [[SLHistoryDetailTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [detailtvc setCurrentSleep:[[[SLDataController sharedController]allSleepsNewestFirst]objectAtIndex:[indexPath row]]];
    [[self navigationController]pushViewController:detailtvc animated:YES];
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
