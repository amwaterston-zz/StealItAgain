//
//  FringeDAO.m
//  FringeRobbers
//
//  Created by Alex Waterston on 07/05/2011.
//  Copyright 2011 Haiku Interactive. All rights reserved.
//

#import "DataDAO.h"

@implementation DataDAO

@synthesize database;

-(id)init {
	if ((self = [super init])) {
		database = [[EGODatabase alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"datas" ofType:@""]];
	}
	
	return self;
}

- (NSArray *) getBuildingPower
{
	NSString *query = @"SELECT * from power WHERE power.usage = 'ELECTRICITY'";
	
	EGODatabaseResult* result = [database executeQuery:query];
	NSMutableArray *buildingList = [NSMutableArray arrayWithCapacity:[result count]];
	for(EGODatabaseRow* row in result) 
	{	
        for (int i = 0; i < 48; i++) {
            //double power = [row doubleForColumnIndex:i + 5];
            //[buildingList addObject:[NSNumber numberWithDouble:power]];
        }
        
        double power = [row doubleForColumn:@"daily_total"];
        [buildingList addObject:[NSNumber numberWithDouble:power]];
        
//		NSString *building = [row stringForColumn:@"building"];
//		[buildingList addObject:building];
	}
	
	return buildingList;
}

@end
