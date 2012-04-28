//
//  FringeDAO.h
//  FringeRobbers
//
//  Created by Alex Waterston on 07/05/2011.
//  Copyright 2011 Haiku Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGODatabase.h"
#import <CoreLocation/CoreLocation.h>

@class Item;
@interface DataDAO : NSObject 
{
	EGODatabase *database;
}

@property (nonatomic, readonly) EGODatabase *database; 

- (NSArray *) getBuildings;
- (NSString *) getRandomAnimal;
- (NSString *) getRandomPoet;
- (Item *) getRandomItem;
- (NSString *) getRandomReward;

@end
