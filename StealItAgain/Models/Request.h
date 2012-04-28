//
//  Request.h
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject

@property (nonatomic, retain) NSString* poet;
@property (nonatomic, retain) NSString* animal;
@property (nonatomic, retain) NSString* venue;
@property (nonatomic, retain) NSString* item;
@property (nonatomic, retain) NSString* imageName;
@property (nonatomic, retain) NSString* rewardText;
@property (nonatomic, assign) int rewardAmount;

+(Request*)loadRandomRequest;

- (NSString*)theRequest;

@end
