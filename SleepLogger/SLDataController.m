//
//  SLDataController.m
//  SleepLogger
//
//  Created by Thomas Bibby on 23/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import "SLDataController.h"
#import "TNPersistenceController.h"
#import "Sleeps.h"
#import "Interruptions.h"
#import "Settings.h"

@interface SLDataController()

-(NSManagedObject *)createManagedObjectForEntityNamed:(NSString *)entityName;
-(NSArray *)allItemsForEntityName:(NSString *)entityName;
-(NSManagedObject *)lastItemForEntityName:(NSString *)entityName;
-(void)deleteManagedObject:(NSManagedObject *)managedObject;

//settings can only be created in this class
-(Settings *)createSettings;

@end

@implementation SLDataController
@synthesize persistenceController;

#pragma mark initialisation

//This is a singleton, which is A Bad Thing(TM)
// if you wanted to be a better person you could use dependency injection
//by setting the SLDataController of the first VC you create and then
//passing it along to each subsequent VC that you create

+(id)sharedController
{
    static SLDataController *sharedMyController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyController = [[self alloc] init];
    });
    return sharedMyController;
}

- (id)init {
    self = [super init];
    if (self)
    {
        
    }
    return self;
}


#pragma mark save

-(void)save
{
    //call the save method of our persistence controller
    [[self persistenceController]save];
}

#pragma mark generic create objects

-(NSManagedObject *)createManagedObjectForEntityNamed:(NSString *)entityName
{
    NSManagedObject *managedObjectToReturn = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[persistenceController mainContext]];

    return managedObjectToReturn;
}

-(NSArray *)allItemsForEntityName:(NSString *)entityName
{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //we want to retrieve all things
    NSEntityDescription *e = [[[persistenceController mom]entitiesByName]objectForKey:entityName];
    //set the entity description to the fetch request
    [request setEntity:e];
    //Create a new sort descriptor and add it to the request
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"locallyCreatedDate" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sd]];
    //predicate, if needed
    /*
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@""];
     [request setPredicate:predicate];
     */
    //prepare an error if our fetch request doesn't work
    NSError *error;
    //execute the fetch request and store it in an array
    NSArray *result = [[persistenceController mainContext] executeFetchRequest:request error:&error];
    //if not successful, throw an exception with the error
    if(!result)
    {
        [NSException raise:@"Fetch failed" format:@"Reason: %@",[error localizedDescription]];
    }
    
    //return a copy of the result
    return  result;
}

-(NSManagedObject *)lastItemForEntityName:(NSString *)entityName
{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //we want to retrieve all things
    NSEntityDescription *e = [[[persistenceController mom]entitiesByName]objectForKey:entityName];
    //set the entity description to the fetch request
    [request setEntity:e];
    //Create a new sort descriptor and add it to the request
    //We want this to be descending as we're just going to limit the fetch to one object
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"locallyCreatedDate" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sd]];
    //limit to one result
    [request setFetchLimit:1];
    
    NSError *error;
    //execute the fetch request and store it in an array
    NSArray *result = [[persistenceController mainContext] executeFetchRequest:request error:&error];
    //if not successful, throw an exception with the error
    if(!result)
    {
        [NSException raise:@"Fetch failed" format:@"Reason: %@",[error localizedDescription]];
    }
    
    //return the only object in the array
    return [result lastObject];
}

-(void)deleteManagedObject:(NSManagedObject *)managedObject
{
    [[persistenceController mainContext]deleteObject:managedObject];
}




#pragma mark Sleeps
-(NSInteger)numberOfSleeps
{
    return [[self allSleeps]count];
}

-(Sleeps *)createSleep
{
    Sleeps *sleepToReturn = (Sleeps *)[self createManagedObjectForEntityNamed:NSStringFromClass([Sleeps class])];
    [sleepToReturn setLocallyCreatedDate:[NSDate date]];
    return sleepToReturn;
}

-(NSArray *)allSleeps
{
    return [self allItemsForEntityName:NSStringFromClass([Sleeps class])];
}

-(void)deleteSleep:(Sleeps *)s
{
    [self deleteManagedObject:s];
}

#pragma mark Interruptions
-(NSInteger)numberOfInterruptions
{
    return [[self allInterruptions]count];
}

-(Interruptions *)createInterruption
{
    Interruptions *interruptionToReturn = (Interruptions *)[self createManagedObjectForEntityNamed:NSStringFromClass([Interruptions class])];
    [interruptionToReturn setLocallyCreatedDate:[NSDate date]];
    return interruptionToReturn;
}

-(NSArray *)allInterruptions
{
    return [self allItemsForEntityName:NSStringFromClass([Interruptions class])];
}

-(void)deleteInterruption:(Interruptions *)i
{
    [self deleteManagedObject:i];
}



#pragma mark settings
-(Settings *)currentSettings
{
    Settings *settingsToReturn = (Settings *)[self lastItemForEntityName:NSStringFromClass([Settings class])];
    if(!settingsToReturn)
    {
        settingsToReturn = [self createSettings];
    }
    
    //we have to do a tiny bit of setup here
    [settingsToReturn setLocallyCreatedDate:[NSDate date]];
    
    return settingsToReturn;
}

-(Settings *)createSettings
{
    return (Settings *)[self createManagedObjectForEntityNamed:NSStringFromClass([Settings class])];
}



@end
