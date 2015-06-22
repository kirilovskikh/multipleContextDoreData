//
//  ViewController.m
//  coredate
//
//  Created by Maksim Kirilovskikh on 22.06.15.
//  Copyright (c) 2015 kirilovskikh. All rights reserved.
//


#import "ViewController.h"
#import "AppDelegate.h"
#import "NewsModel.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self threadReader];
    [self threadWriter];
}

- (void)threadReader {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSManagedObjectContext *context = [self getDefaultContext];
        while (true) {
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            [request setEntity:[NSEntityDescription entityForName:@"NewsModel" inManagedObjectContext:context]];
            [request setPredicate:[NSPredicate predicateWithFormat:@"likes = %d", 1]];
            NSError *error;
            NSArray *result = [context executeFetchRequest:request error:&error];

            if (error) {
                NSLog(@"reader error = %@", [error localizedDescription]);
            } else {
                NSLog(@"reader result count = %d", [result count]);
            }
        }
    });


}

- (void)threadWriter {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appDelegate createContext];
        while (true) {
            NewsModel *model = [NSEntityDescription insertNewObjectForEntityForName:@"NewsModel" inManagedObjectContext:context];
            model.name = @"name1";
            model.likes = @1;
            model.country = @"ru1";

            NSError *error;
            [context save:&error];

            if (error) {
                NSLog(@"writer = %@", [error localizedDescription]);
            } else {
                [context mergeChangesFromContextDidSaveNotification:nil];

                NSLog(@"save success");
            };

        }
    });

}

- (NSManagedObjectContext *)getDefaultContext {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    return context;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end