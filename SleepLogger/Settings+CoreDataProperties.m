//
//  Settings+CoreDataProperties.m
//  SleepLogger
//
//  Created by Thomas Bibby on 23/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Settings+CoreDataProperties.h"

@implementation Settings (CoreDataProperties)

@dynamic startReminderTime;
@dynamic endReminderTime;
@dynamic doStartReminder;
@dynamic doEndReminder;
@dynamic locallyCreatedDate;

@end
