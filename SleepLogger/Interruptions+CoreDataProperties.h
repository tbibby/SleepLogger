//
//  Interruptions+CoreDataProperties.h
//  SleepLogger
//
//  Created by Thomas Bibby on 23/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Interruptions.h"

NS_ASSUME_NONNULL_BEGIN

@interface Interruptions (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *interruptionTime;
@property (nullable, nonatomic, retain) NSString *interruptionDetails;
@property (nullable, nonatomic, retain) NSDate *locallyCreatedDate;
@property (nullable, nonatomic, retain) Sleeps *interruptionSleep;

@end

NS_ASSUME_NONNULL_END
