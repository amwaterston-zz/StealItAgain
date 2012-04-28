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

- (void)completeRequest {
    self.request = nil;
}

- (Request*)request {
    if (request == nil) {
        request = [[Request loadRandomRequest] retain];
    }
    return request;
}

+ (Building*)loadDummyBuilding {
    Building *building = [[Building alloc] init];
    building.buildingId = 1;
    building.buildingName = @"The Building";
    building.color = [NSColor redColor];
    return [building autorelease];
}

@end
