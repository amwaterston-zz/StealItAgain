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

@implementation Request

@synthesize poet;
@synthesize animal;
@synthesize venue;
@synthesize item;
@synthesize imageName;
@synthesize rewardText;
@synthesize rewardAmount;

- (NSString*)theRequest {
    return [NSString stringWithFormat:@"%@ the %@ says smash the %@ in %@ for %d", poet, animal, item, venue, rewardAmount];
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
    return [request autorelease];
}

@end
