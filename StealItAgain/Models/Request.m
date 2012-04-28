//
//  Request.m
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import "Request.h"
#import "dataDAO.h"

@implementation Request

@synthesize poet;
@synthesize animal;
@synthesize venue;
@synthesize item;
@synthesize imageName;
@synthesize rewardText;
@synthesize rewardAmount;

- (NSString*)theRequest {
    return [NSString stringWithFormat:@"%@ the %@ says smash the %@ in the %@ for %d", poet, animal, item, venue, rewardAmount];
}

+(Request*)loadRandomRequest:(DataDAO *)data {
    Request *request = [[Request alloc] init];
    request.poet = [data getRandomPoet];
    request.animal = [data getRandomAnimal];
    request.item = @"Ming Vase";
    request.venue = @"Underbelly";
    request.rewardAmount = 42;
    request.imageName = @"p0000033234";
    return [request autorelease];
}

@end
