//
//  Sleeps+CoreDataProperties.h
//  SleepLogger
//
//  Created by Thomas Bibby on 23/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Sleeps.h"

NS_ASSUME_NONNULL_BEGIN

@interface Sleeps (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *sleepStart;
@property (nullable, nonatomic, retain) NSDate *sleepEnd;
@property (nullable, nonatomic, retain) NSDate *locallyCreatedDate;
@property (nullable, nonatomic, retain) NSSet<Interruptions *> *sleepInterruptions;

@end

@interface Sleeps (CoreDataGeneratedAccessors)

- (void)addSleepInterruptionsObject:(Interruptions *)value;
- (void)removeSleepInterruptionsObject:(Interruptions *)value;
- (void)addSleepInterruptions:(NSSet<Interruptions *> *)values;
- (void)removeSleepInterruptions:(NSSet<Interruptions *> *)values;

@end

NS_ASSUME_NONNULL_END
