//
//  Request.m
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import "Request.h"
#import "dataDAO.h"
#import "Item.h"
#import "Reward.h"
#import "Player.h"
#import "Building.h"

#define kDefaultRequestDuration 10.0
#define kRespawnTimeInterval 10.0

@interface Request ()

@property (nonatomic, retain) NSTimer *failTimer;
@property (nonatomic, assign) NSTimeInterval respawnInterval;
@property (nonatomic, retain) NSDate *respawnRequestedAt;

@end

@implementation Request

@synthesize delegate;
@synthesize poet;
@synthesize animal;
@synthesize venue;
@synthesize item;
@synthesize imageName;
@synthesize rewardText;
@synthesize rewardAmount;
@synthesize requestStartDate;
@synthesize requestDuration;
@synthesize requestCompleted;
@synthesize requestFailed;
@synthesize failTimer;
@synthesize respawnInterval;
@synthesize respawnRequestedAt;

- (id)init {
    self = [super init];
    if (self) {
        requestDuration = 5.0f + (arc4random() % 25);// kDefaultRequestDuration;
        respawnInterval = 5.0f + (arc4random() % 10);// kRespawnTimeInterval;
        requestStartDate = [[NSDate date] retain];
        failTimer = [[NSTimer scheduledTimerWithTimeInterval:requestDuration target:self selector:@selector(failRequest) userInfo:nil repeats:NO] retain];
    }
    return self;
}

- (NSString*)theRequest {
    if (!self.requestCompleted)
        return [NSString stringWithFormat:@"%@ the %@ says smash the %@ in %@ for %d", poet, animal, item, venue.buildingName, rewardAmount];
    else {
        return [NSString stringWithFormat:@"%@ the %@ is SO HAPPY. Now you can pay for %@", poet, animal, rewardText];
    }
}

- (NSTimeInterval)timeRemaining {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:requestStartDate];
    return requestDuration - timeInterval;
}

- (NSString*)timeRemainingAsString {
    if (self.requestFailed) {
        return @"Request Failed";
    }
    if (self.requestCompleted) {
        return @"Request Smashed!";
    }
    return [NSString stringWithFormat:@"%02.0f seconds remaining", [self timeRemaining]];
}

- (NSTimeInterval)timeUntilRespawn {
    return respawnInterval - [[NSDate date] timeIntervalSinceDate:respawnRequestedAt];
}

- (NSString*)timeUntilRespawnAsString {
    return [NSString stringWithFormat:@"%02.0f seconds until new request available", [self timeUntilRespawn]];
}

- (NSString*)timeString {
    NSString *timeString = self.timeRemainingAsString;
    if (respawnRequestedAt) {
        timeString = [NSString stringWithFormat:@"%@\n%@", timeString, [self timeUntilRespawnAsString]];
    }
    return timeString;
}

- (void)scheduleRespawn {
    self.respawnRequestedAt = [NSDate date];
    [failTimer invalidate];
    self.failTimer = nil;
    [NSTimer scheduledTimerWithTimeInterval:respawnInterval target:venue selector:@selector(respawnRequest) userInfo:nil repeats:NO];
}

- (void)failRequest {
    if (!requestFailed) {
        requestFailed = YES;
        [delegate requestFinished:self];
        [self scheduleRespawn];
    }
}

- (void)completeRequest {
    if (!self.requestFinished) {
        // TODO - ensure that the police haven't arrived in the building....!
        [Player sharedPlayer].funding = rewardAmount + [Player sharedPlayer].funding;
        requestCompleted = YES;
        [delegate requestFinished:self];
        [self scheduleRespawn];
    }
}

- (BOOL)requestFinished {
    return requestCompleted || requestFailed;
}

+(Request*)loadRandomRequest:(DataDAO *)data withBuilding:(Building *)building {
    Request *request = [[Request alloc] init];
    request.poet = [data getRandomPoet];
    request.animal = [data getRandomAnimal];
    Item *i = [data getRandomItem];
    request.item = i.name;
    request.venue = building;
    request.imageName = i.filename;
    Reward *r = [data getRandomReward];
    request.rewardAmount = r.value;
    request.rewardText = r.description;
    return [request autorelease];
}

@end
