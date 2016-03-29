//
//  SLLogViewController.m
//  SleepLogger
//
//  Created by Thomas Bibby on 29/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import "SLLogViewController.h"

@interface SLLogViewController ()

@end

@implementation SLLogViewController
@synthesize sleepButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sleepButtonTapped:(id)sender {
    NSLog(@"Sleep button tapped");
}
@end
