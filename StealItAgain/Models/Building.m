//
//  Building.m
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import "Building.h"

@interface Building ()
@property (nonatomic, retain, readwrite) Request* request;
@end

@implementation Building

@synthesize buildingId;
@synthesize buildingName;
@synthesize color;
@synthesize request;
@synthesize power;
@synthesize police;
@synthesize policeArrivalTime;
@synthesize policeComing;

- (void)completeRequest {
    self.request = nil;
}

- (double)powerForT:(NSInteger)t {
    return [[power objectAtIndex:t] doubleValue];
}

- (Request*)request {
    if (request == nil) {
        request = [[Request loadRandomRequest:[DataDAO sharedDataDAO] withBuilding:self] retain];
    }
    return request;
}

- (NSString*)policeArrivalTimeAsString {
    if (police) {
        return @"POLICE!";
    } else if (policeComing) {
        return [NSString stringWithFormat:@"In %02.0f seconds", policeArrivalTime];
    } else {
        return @"Smash on!";
    }
}

- (void)respawnRequest {
    self.request = nil;
}

+ (Building*)loadDummyBuilding {
    Building *building = [[Building alloc] init];
    building.buildingId = 1;
    building.buildingName = @"The Building";
    building.color = [NSColor redColor];
    return [building autorelease];
}

@end
