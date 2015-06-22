//
//  AppDelegate.h
//  coredate
//
//  Created by Maksim Kirilovskikh on 22.06.15.
//  Copyright (c) 2015 kirilovskikh. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSManagedObjectContext *) createContext;
- (NSURL *)applicationDocumentsDirectory;


@end
