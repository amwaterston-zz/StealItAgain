//
//  Building.h
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Request.h"
#import "DataDAO.h"

@interface Building : NSObject

@property (nonatomic, assign) int buildingId;
@property (nonatomic, retain) NSString* buildingName;
@property (nonatomic, retain) NSColor* color;
@property (nonatomic, retain, readonly) Request* request;
@property (nonatomic, retain) NSArray* power;
@property (nonatomic, assign) BOOL police;
@property (nonatomic, assign) NSTimeInterval policeArrivalTime;
@property (nonatomic, assign) BOOL policeComing;

- (void)completeRequest;
+ (Building*)loadDummyBuilding;
- (double)powerForT:(NSInteger)t;

- (NSString*)policeArrivalTimeAsString;

@end
