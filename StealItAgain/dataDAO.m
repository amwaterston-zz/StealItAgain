//
//  FringeDAO.m
//  FringeRobbers
//
//  Created by Alex Waterston on 07/05/2011.
//  Copyright 2011 Haiku Interactive. All rights reserved.
//

#import "DataDAO.h"
#import "Building.h"

@implementation DataDAO

@synthesize database;

-(id)init {
	if ((self = [super init])) {
		database = [[EGODatabase alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"datas" ofType:@""]];
	}
	
	return self;
}

- (NSArray *) getBuildings
{
    NSMutableArray *arrayOfBuildings = [NSMutableArray arrayWithCapacity:7];
    
    Building *b = [Building alloc];
    b.color = [NSColor redColor];
    b.buildingName = @"Building 1";
    b.power = [self getBuildingPowerFor:b.buildingName up:NO];
    [arrayOfBuildings addObject:b];
    [b release];
    
    b = [Building alloc];
    b.color = [NSColor greenColor];
    b.buildingName = @"Building 2";
    b.power = [self getBuildingPowerFor:b.buildingName up:NO];
    [arrayOfBuildings addObject:b];
    [b release];

    b = [Building alloc];
    b.color = [NSColor blueColor];
    b.buildingName = @"Building 3";
    b.power = [self getBuildingPowerFor:b.buildingName up:NO];
    [arrayOfBuildings addObject:b];
    [b release];

    b = [Building alloc];
    b.color = [NSColor cyanColor];
    b.buildingName = @"Building 4";
    b.power = [self getBuildingPowerFor:b.buildingName up:NO];
    [arrayOfBuildings addObject:b];
    [b release];

    b = [Building alloc];
    b.color = [NSColor magentaColor];
    b.buildingName = @"Building 1";
    b.power = [self getBuildingPowerFor:b.buildingName up:YES];
    [arrayOfBuildings addObject:b];
    [b release];
    
    b = [Building alloc];
    b.color = [NSColor yellowColor];
    b.buildingName = @"Building 2";
    b.power = [self getBuildingPowerFor:b.buildingName up:YES];
    [arrayOfBuildings addObject:b];
    [b release];
    
    b = [Building alloc];
    b.color = [NSColor purpleColor];
    b.buildingName = @"Building 3";
    b.power = [self getBuildingPowerFor:b.buildingName up:YES];
    [arrayOfBuildings addObject:b];
    [b release];
    
    return arrayOfBuildings;
}

-(NSArray *) getBuildingPowerFor:(NSString *)name up:(BOOL)up {
    NSString *sql = [NSString stringWithFormat:@"Select * from power where power.usage = 'ELECTRICITY' AND power.building = '%@' order by date %@", name, up ? @"asc" : @"desc"];
    EGODatabaseResult* result = [database executeQuery:sql];
	NSMutableArray *buildingList = [NSMutableArray arrayWithCapacity:[result count]];
	for(EGODatabaseRow* row in result) 
	{	
        double power = [row doubleForColumn:@"daily_total"];
        [buildingList addObject:[NSNumber numberWithDouble:power]];
    }
    
return buildingList;
}

@end
