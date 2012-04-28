//
//  FringeDAO.m
//  FringeRobbers
//
//  Created by Alex Waterston on 07/05/2011.
//  Copyright 2011 Haiku Interactive. All rights reserved.
//

#import "DataDAO.h"
#import "Building.h"
#import "Item.h"
#import "Reward.h"

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

- (NSString *) getRandomAnimal {
    EGODatabaseResult* result = [database executeQuery:@"Select common_name from animals ORDER BY random() LIMIT 1"];
    
    EGODatabaseRow *first = [result.rows objectAtIndex:0];
    return [first stringForColumnIndex:0];
}

- (NSString *) getRandomPoet {
    EGODatabaseResult* result = [database executeQuery:@"Select formatted_name from poets ORDER BY random() LIMIT 1"];
    EGODatabaseRow *first = [result.rows objectAtIndex:0];
    NSString *formattedname = [first stringForColumnIndex:0];
    NSArray *parts = [formattedname componentsSeparatedByString:@", "];
    return [NSString stringWithFormat:@"%@ %@", [parts objectAtIndex:1], [parts objectAtIndex:0]];
}

- (Item *) getRandomItem {
    EGODatabaseResult* result = [database executeQuery:@"Select object_name, description, file_name from glass ORDER BY random() LIMIT 1"];
    
    EGODatabaseRow *first = [result.rows objectAtIndex:0];
    Item *item = [Item alloc];
    
    item.name = [first stringForColumnIndex:0];
    item.description = [first stringForColumnIndex:1];
    item.filename = [first stringForColumnIndex:2];
    return [item autorelease];
}

- (Reward *) getRandomReward {
    EGODatabaseResult* result = [database executeQuery:@"Select award_made, short_description from creative ORDER BY random() LIMIT 1"];
    
    EGODatabaseRow *first = [result.rows objectAtIndex:0];
    Reward *reward = [Reward alloc];
    reward.value = [first intForColumnIndex:0];
    reward.description = [first stringForColumnIndex:1];
    return [reward autorelease];
}

@end
