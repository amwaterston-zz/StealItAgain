//
//  AppDelegate.h
//  StealItAgain
//
//  Created by Alexander Waterston on 27/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "psmove.h"
#import "dataDAO.h"
#import "RequestCompleted.h"

@class Building;

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDelegate, NSTableViewDataSource, RequestCompleted> {
    
    NSMutableArray *moveArray;
    int controllers_connected;
    DataDAO *data;
    
    int timeT;
    
    NSArray *buildings;
    BOOL viewLoaded;
    
    Building *currentPoliceBuilding;
    NSTimer *globeTimer;
    NSTimer *pollTimer;
    float timeRemaining;
}
@property (assign) IBOutlet NSTextField *timerText;

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSView *winLoseScreen;
@property (assign) IBOutlet NSTextField *winLoseText;

@property (assign) IBOutlet NSTableView *tableView;
@property (assign) IBOutlet NSTextField *fundingTextField;

- (IBAction)tappity:(id)sender;
@end
