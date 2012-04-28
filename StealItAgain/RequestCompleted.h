//
//  RequestCompleted.h
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Request;

@protocol RequestCompleted <NSObject>

- (void)requestFinished:(Request*)request;

@end
