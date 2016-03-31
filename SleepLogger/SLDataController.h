//
//  SLDataController.h
//  SleepLogger
//
//  Created by Thomas Bibby on 23/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TNPersistenceController;
@class Sleeps;
@class Interruptions;
@class Settings;

@interface SLDataController : NSObject
@property (strong, nonatomic)TNPersistenceController *persistenceController;

+(id)sharedController;
-(void)save;

-(NSInteger)numberOfSleeps;
-(Sleeps *)createSleep;
-(NSArray *)allSleeps;
-(void)deleteSleep:(Sleeps *)s;
-(Sleeps *)lastSleep;

-(NSInteger)numberOfInterruptions;
-(Interruptions *)createInterruption;
-(NSArray *)allInterruptions;
-(void)deleteInterruption:(Interruptions *)i;

-(Settings *)currentSettings;


@end
