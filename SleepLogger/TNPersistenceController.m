//
//  TNPersistenceController.m
//  SleepLogger
//
//  Created by Thomas Bibby on 23/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import "TNPersistenceController.h"

@interface TNPersistenceController()
//the main context is readwrite only for this class
@property (strong, readwrite) NSManagedObjectContext *mainContext;
@property (strong, readwrite) NSManagedObjectModel *mom;
@property (strong) NSManagedObjectContext *saveContext;
@property (copy) TNPersistenceControllerCompletionHandler completionHandler;
-(void)initializeCoreData;

@end

@implementation TNPersistenceController
@synthesize mainContext;
@synthesize mom;
@synthesize saveContext;
@synthesize completionHandler;

-(id)initWithCompletionHandler:(TNPersistenceControllerCompletionHandler)handler
{
    self = [super init];
    if(self)
    {
        [self setCompletionHandler:handler];
        [self initializeCoreData];
    }
    return self;
}

-(void)initializeCoreData
{
    if(![self mainContext])
    {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataModel" withExtension:@"momd"];
        mom = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
        [self setMainContext:[[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType]];
        [self setSaveContext:[[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType]];
        
        //persistent store coordinator is the private context
        [[self saveContext]setPersistentStoreCoordinator:coordinator];
        //the public context has the private context as a parent.  So when we save the public context (on the main thread)
        //we just save to the parent private context, which will save on a private queue
        [[self mainContext]setParentContext:[self saveContext]];
        
        //Now we have our contexts set up, we need to set up our store.  If we're doing a complex migration
        //or if we have a huge store, there is a danger this will take too long, holding up applicationDidFinishLaunching,
        //and in the worst case scenario, causing the app to be killed by the watchdog.  So we'll do it on a background queue
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSPersistentStoreCoordinator *psc = [[self saveContext]persistentStoreCoordinator];
            NSMutableDictionary *persistentStoreOptions = [NSMutableDictionary dictionary];
            //automatic migration (options take a NSNumber, hence the @)
            persistentStoreOptions[NSMigratePersistentStoresAutomaticallyOption] = @YES;
            persistentStoreOptions[NSInferMappingModelAutomaticallyOption] = @YES;
            //set the SQLite options (takes a NSDictionary)
            //This option disables Write-Ahead-Logging (WAL) which stops you having a single, canonical sqlite file
            //that you can copy between Documents directories
            persistentStoreOptions[NSSQLitePragmasOption] = @{ @"journal_mode":@"DELETE" };
            
            //get the file
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
            NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"DataModel.sqlite"];
            
            NSError *persistentStoreError = nil;
            [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:persistentStoreOptions error:&persistentStoreError];
            if(persistentStoreError != nil)
            {
                NSLog(@"Failed to create persistent store");
            }
            
            //if our completion handler is not set, just return
            if (![self completionHandler])
            {
                return;
            }
            //if our completion handler is set, then run it on the main queue (i.e. tell AppDelegate it's OK to set up user interface)
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self completionHandler]();
            });
            
            
        });
        
    }
}


-(void)save
{
    //check to see if we have any changes, if not then just return
    if(![[self saveContext]hasChanges] && ![[self mainContext]hasChanges])
    {
        return;
    }
    //else we do have changes
    else
    {
        //It's possible that save: will be called from a different thread.  So we call performBlockAndWait on the main context
        //to make sure we're on the main thread
        [[self mainContext] performBlockAndWait:^{
            NSError *error = nil;
            [[self mainContext]save:&error];
            if(error != nil)
            {
                NSLog(@"Failed to save main managed object context");
            }
            
            //private context has its own queue
            
            [[self saveContext]performBlock:^{
                NSError *privateError = nil;
                [[self saveContext]save:&privateError];
                if(privateError != nil)
                {
                    NSLog(@"Failed to save private moc");
                }
                
            }];
            
        }];
        
    }
}

@end
