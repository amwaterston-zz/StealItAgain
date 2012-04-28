//
//  Reward.h
//  StealItAgain
//
//  Created by Alexander Waterston on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reward : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic) int value;
@property (nonatomic, retain) NSString *description;
@end
