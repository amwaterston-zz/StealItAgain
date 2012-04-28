//
//  Request.h
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestCompleted.h"

@class DataDAO;
@interface Request : NSObject

@property (nonatomic, assign) NSObject<RequestCompleted> *delegate;
@property (nonatomic, retain) NSString* poet;
@property (nonatomic, retain) NSString* animal;
@property (nonatomic, retain) NSString* venue;
@property (nonatomic, retain) NSString* item;
@property (nonatomic, retain) NSString* imageName;
@property (nonatomic, retain) NSString* rewardText;
@property (nonatomic, assign) int rewardAmount;
@property (nonatomic, retain) NSDate *requestStartDate;
@property (nonatomic, assign) NSTimeInterval requestDuration;
@property (nonatomic, assign, readonly) BOOL requestCompleted;
@property (nonatomic, assign, readonly) BOOL requestFailed;
@property (nonatomic, assign, readonly) BOOL requestFinished;

+(Request*)loadRandomRequest:(DataDAO *)data withBuilding:(NSString *)name;

- (NSString*)theRequest;

- (NSTimeInterval)timeRemaining;
- (NSString*)timeRemainingAsString;

- (void)failRequest;
- (void)completeRequest;

@end
