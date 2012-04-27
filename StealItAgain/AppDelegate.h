//
//  AppDelegate.h
//  StealItAgain
//
//  Created by Alexander Waterston on 27/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "psmove.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    PSMove *moves[6];
    
    NSMutableArray *moveArray;
    int controllers_connected;
}

@property (assign) IBOutlet NSWindow *window;
- (IBAction)tappity:(id)sender;

@end
