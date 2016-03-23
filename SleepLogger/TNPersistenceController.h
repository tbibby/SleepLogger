//
//  TNPersistenceController.h
//  SleepLogger
//
//  Created by Thomas Bibby on 23/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

//define the block as a variable
typedef void (^TNPersistenceControllerCompletionHandler)(void);

@interface TNPersistenceController : NSObject

@property (strong, readonly) NSManagedObjectContext *mainContext;
//need to expose the model so we can call entitiesByName when we're doing a fetch
@property (strong, readonly) NSManagedObjectModel *mom;

- (id)initWithCompletionHandler:(TNPersistenceControllerCompletionHandler)handler;

- (void)save;

@end
