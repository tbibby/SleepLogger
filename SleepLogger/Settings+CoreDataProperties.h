//
//  Settings+CoreDataProperties.h
//  SleepLogger
//
//  Created by Thomas Bibby on 23/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Settings.h"

NS_ASSUME_NONNULL_BEGIN

@interface Settings (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *startReminderTime;
@property (nullable, nonatomic, retain) NSDate *endReminderTime;
@property (nullable, nonatomic, retain) NSNumber *doStartReminder;
@property (nullable, nonatomic, retain) NSNumber *doEndReminder;
@property (nullable, nonatomic, retain) NSDate *locallyCreatedDate;

@end

NS_ASSUME_NONNULL_END
