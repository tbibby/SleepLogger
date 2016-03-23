//
//  AppDelegate.h
//  SleepLogger
//
//  Created by Thomas Bibby on 23/03/2016.
//  Copyright © 2016 Thomas Bibby. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TNPersistenceController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//publicly persistence controller is readonly, the only class that can delete it is the app delegate itself
@property(strong, readonly) TNPersistenceController *persistenceController;


@end

