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

- (IBAction)sleepButtonTapped:(id)sender;
@end
