//
//  Player.h
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPlayerFundingChanged @"PlayerFundingChanged"

@interface Player : NSObject

@property (nonatomic, assign) int funding;

+ (Player*)sharedPlayer;

@end
