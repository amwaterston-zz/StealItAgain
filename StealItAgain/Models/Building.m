//
//  Building.m
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import "Building.h"

@implementation Building

@synthesize buildingId;
@synthesize buildingName;
@synthesize color;
@synthesize power;

- (double)powerForT:(NSInteger)t {
    return [[power objectAtIndex:t] doubleValue];
}

@end
