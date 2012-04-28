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
@synthesize glassImageName;
@synthesize rewardText;
@synthesize rewardAmount;

- (NSString*)theRequest {
    return [NSString stringWithFormat:@"Grab the %@", animal];
}

+(Request*)loadRandomRequest:(DataDAO *)data {
    Request *request = [[Request alloc] init];
    request.poet = [data getRandomPoet];
    request.animal = [data getRandomAnimal];
    request.glassImageName = @"p0000033234";
    return [request autorelease];
}

@end
