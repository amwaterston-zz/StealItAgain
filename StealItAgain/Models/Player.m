//
//  Player.m
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import "Player.h"


@implementation Player
@synthesize funding;

static Player *sharedPlayer;

- (void)setFunding:(int)newFunding {
    funding = newFunding;
    [[NSNotificationCenter defaultCenter] postNotificationName:kPlayerFundingChanged object:nil];

}

+ (Player*)sharedPlayer {
    if (!sharedPlayer) {
        sharedPlayer = [[Player alloc] init];
    }
    return sharedPlayer;
}

@end
