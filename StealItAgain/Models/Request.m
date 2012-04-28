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

#define kDefaultRequestDuration 30.0

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

- (id)init {
    self = [super init];
    if (self) {
        requestDuration = kDefaultRequestDuration;
        requestStartDate = [[NSDate date] retain];
        [NSTimer scheduledTimerWithTimeInterval:requestDuration target:self selector:@selector(failRequest) userInfo:nil repeats:NO];
    }
    return self;
}

- (NSString*)theRequest {
    if (!self.requestCompleted)
        return [NSString stringWithFormat:@"%@ the %@ says smash the %@ in the %@ for %d", poet, animal, item, venue, rewardAmount];
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

- (void)failRequest {
    requestFailed = YES;
    [delegate requestFinished:self];
}

- (void)completeRequest {
    if (!self.requestFinished) {
        // TODO - ensure that the police haven't arrived in the building....!
        [Player sharedPlayer].funding = rewardAmount + [Player sharedPlayer].funding;
        requestCompleted = YES;
        [delegate requestFinished:self];
    }
}

- (BOOL)requestFinished {
    return requestCompleted || requestFailed;
}

+(Request*)loadRandomRequest:(DataDAO *)data withBuilding:(NSString *)name {
    Request *request = [[Request alloc] init];
    request.poet = [data getRandomPoet];
    request.animal = [data getRandomAnimal];
    Item *i = [data getRandomItem];
    request.item = i.name;
    request.venue = name;
    request.imageName = i.filename;
    Reward *r = [data getRandomReward];
    request.rewardAmount = r.value;
    request.rewardText = r.description;
    return [request autorelease];
}

@end
