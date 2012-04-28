//
//  Building.h
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Request.h"

@interface Building : NSObject

@property (nonatomic, assign) int buildingId;
@property (nonatomic, retain) NSString* buildingName;
@property (nonatomic, retain) NSColor* color;
@property (nonatomic, retain, readonly) Request* request;

- (void)completeRequest;
+ (Building*)loadDummyBuilding;

@end
