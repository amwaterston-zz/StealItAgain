//
//  Request.m
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import "Request.h"

#define kDefaultRequestDuration 120.0

@implementation Request

@synthesize poet;
@synthesize animal;
@synthesize venue;
@synthesize item;
@synthesize imageName;
@synthesize rewardText;
@synthesize rewardAmount;
@synthesize requestStartDate;
@synthesize requestDuration;

- (id)init {
    self = [super init];
    if (self) {
        requestDuration = kDefaultRequestDuration;
        requestStartDate = [[NSDate date] retain];
    }
    return self;
}

- (NSString*)theRequest {
    return [NSString stringWithFormat:@"%@ the %@ says smash the %@ in the %@ for %d", poet, animal, item, venue, rewardAmount];
}

- (NSTimeInterval)timeRemaining {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:requestStartDate];
    return requestDuration - timeInterval;
}

- (NSString*)timeRemainingAsString {
    return [NSString stringWithFormat:@"%02.0f seconds remaining", [self timeRemaining]];
}

+(Request*)loadRandomRequest {
    Request *request = [[Request alloc] init];
    request.poet = @"Rabbie Burns";
    request.animal = @"Ostrich";
    request.item = @"Ming Vase";
    request.venue = @"Underbelly";
    request.rewardAmount = 42;
    request.imageName = @"p0000033234";
    return [request autorelease];
}

@end
