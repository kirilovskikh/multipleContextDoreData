//
//  NewsModel.h
//  coredate
//
//  Created by Maksim Kirilovskikh on 22.06.15.
//  Copyright (c) 2015 kirilovskikh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NewsModel : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * likes;
@property (nonatomic, retain) NSString * country;

@end
