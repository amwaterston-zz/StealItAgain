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
	NSString *query = @"SELECT power.building as building from power WHERE power.usage = 'ELECTRICITY'";
	
	EGODatabaseResult* result = [database executeQuery:query];
	NSMutableArray *buildingList = [NSMutableArray arrayWithCapacity:[result count]];
	for(EGODatabaseRow* row in result) 
	{	
		NSString *building = [row stringForColumn:@"building"];
		[buildingList addObject:building];
	}
	
	return buildingList;
}

@end
