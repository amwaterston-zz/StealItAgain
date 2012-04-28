//
//  AppDelegate.m
//  StealItAgain
//
//  Created by Alexander Waterston on 27/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import "AppDelegate.h"
#include <stdio.h>
#include <stdlib.h>
#include "dataDAO.h"
#include "SomeCell.h"
#include "Request.h"
#include "Building.h"
#include "Player.h"

@implementation AppDelegate

@synthesize timerText;
@synthesize window = _window;
@synthesize winLoseScreen;
@synthesize winLoseText;
@synthesize tableView;
@synthesize fundingTextField;

- (void)dealloc
{
    [super dealloc];
}

- (void) movePolice {
    Building *nextPoliceBuilding;
    nextPoliceBuilding = [buildings objectAtIndex:arc4random() % [buildings count]];
    while (nextPoliceBuilding == currentPoliceBuilding) {
        nextPoliceBuilding = [buildings objectAtIndex:arc4random() % [buildings count]];
    }
    nextPoliceBuilding.policeArrivalTime = 10.0f;
    nextPoliceBuilding.policeComing = YES;
    NSLog(@"police move");
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    controllers_connected = psmove_count_connected();
    printf("Connected controllers: %d\n", controllers_connected);
    
    moveArray = [[NSMutableArray alloc]initWithCapacity:controllers_connected];
    
    for (int i = 0; i < controllers_connected; i++)
    {
        PSMove *move = psmove_connect_by_id(i);
        [moveArray addObject:[NSValue valueWithPointer:move]];
        if (move == NULL) {
            printf("Could not connect to Move controller %d.\n"
                   "Please connect one via USB or Bluetooth.\n", i);
        } else {
            printf("Connected %d.\n", i);
        }
    }
    
    data = [[DataDAO alloc]init];
    buildings = [[data getBuildings] retain];
    timeT = 0;
    
    currentPoliceBuilding = [buildings objectAtIndex:arc4random() % [buildings count]];
    currentPoliceBuilding.police = YES;
    
    [self movePolice];
    
    timeRemaining = 180.0;
    globeTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(tappity:) userInfo:nil repeats:YES];
    pollTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(poll) userInfo:nil repeats:YES];
	viewLoaded = YES;
    tableView.rowHeight = 140;
    [tableView reloadData];
//    [NSTimer scheduledTimerWithTimeInterval:0.5f target:tableView selector:@selector(reloadData) userInfo:nil repeats:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerFundingChanged) name:kPlayerFundingChanged object:nil];
    [self tappity:nil];
}

- (void) grabit:(NSInteger)controller
{
    Building *b = [buildings objectAtIndex:controller];
    if (b.police) {
        //GAME OVER
        [winLoseScreen setHidden:NO];
        [winLoseText setStringValue:@"THE POLICE CAUGHT YOU. YOU DOOF"];
        [pollTimer invalidate];
        [globeTimer invalidate];
    } else {
        Request *r = [b request];
	    [r completeRequest];    
	}
}

- (void) poll {
    for (int i = 0; i < controllers_connected; i++)
    {
        PSMove *move;
        NSValue *v = [moveArray objectAtIndex:i];
        move = [v pointerValue];
        
        psmove_poll(move);
        if (psmove_get_buttons(move) & Btn_MOVE) 
        {
            psmove_set_leds(move, 0, 0, 0);
            psmove_update_leds(move);
            [self grabit:i];
        }
    }
}

- (IBAction)tappity:(id)sender {
    timeRemaining -= 0.5f;
    timerText.stringValue = [NSString stringWithFormat:@"Time Remaining: %02.0f", timeRemaining];
    
    if (timeRemaining <= 0.0f) {
        [winLoseScreen setHidden:NO];
        [winLoseText setStringValue:[NSString stringWithFormat:@"TIME IS UP. YOU GOT £%d OF FUNDING. SCORE", timeRemaining]];
        [pollTimer invalidate];
        [globeTimer invalidate];
        return;
    }
    
    for (int i = 0; i < controllers_connected; i++)
    {
        Building *b = [buildings objectAtIndex:i];
        
        PSMove *move;
        NSValue *v = [moveArray objectAtIndex:i];
        move = [v pointerValue];
        
        if (b.policeComing) {
            b.policeArrivalTime -= 0.5f;
            if (b.policeArrivalTime <= 0.0f) {
                b.police = YES;
                b.policeComing = NO;
                currentPoliceBuilding.police = NO;
                currentPoliceBuilding = b;
                [self movePolice];
            }
        }
        
        if (b.police) {
            psmove_set_leds(move, 0, 0, 255 * (timeT % 2)); //arc4random() % 255, arc4random() % 255);
            psmove_update_leds(move);
        } else if (!b.request.requestFinished) {
            //NSLog(@"power: %d", [[b.power objectAtIndex:timeT % [b.power count]] intValue]);
            float r = b.color.redComponent * ([[b.power objectAtIndex:timeT % [b.power count]] intValue]) / 2600.0f;
            float g = b.color.greenComponent * ([[b.power objectAtIndex:timeT % [b.power count]] intValue]) / 2600.0f;
            float bl = b.color.blueComponent * ([[b.power objectAtIndex:timeT % [b.power count]] intValue]) / 2600.0f;
            psmove_set_leds(move, r * 255, g * 255, bl * 255); //arc4random() % 255, arc4random() % 255);
            psmove_update_leds(move);
        }
    }
    timeT++;
    
    [tableView reloadData];
}

- (void)playerFundingChanged {
    fundingTextField.stringValue = [NSString stringWithFormat:@"Your Funding Total: %d", [[Player sharedPlayer] funding]];
}

#pragma mark - TableView

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    if (!viewLoaded) {
        return 0;
    }
    return controllers_connected;
}

- (NSView*)tableView:(NSTableView *)aTableView viewForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)row {
    
    NSString *identifier = [aTableColumn identifier];
    
    Building *building = [buildings objectAtIndex:row];
    building.request.delegate = self;

    if ([identifier isEqualToString:@"Request"]) {

        NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
        // Then setup properties on the cellView based on the column
        cellView.textField.stringValue = [building.request theRequest];
        //cellView.imageView.objectValue = [dictionary objectForKey:@"Image"];
        return cellView;
    } else if ([identifier isEqualToString:@"Building"]) {
        
        SomeCell *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
        // Then setup properties on the cellView based on the column
        cellView.building = building;
        return cellView;
    } else if ([identifier isEqualToString:@"Picture"]) {
        NSTableCellView *pictureCell = [tableView makeViewWithIdentifier:identifier owner:self];
        pictureCell.imageView.objectValue = [NSImage imageNamed:building.request.imageName];
        return pictureCell;
    } else if ([identifier isEqualToString:@"Reward"]) {
        NSTableCellView *timeCell = [tableView makeViewWithIdentifier:identifier owner:self];
        timeCell.textField.stringValue = [NSString stringWithFormat:@"%d", building.request.rewardAmount];
        return timeCell;
    } else if ([identifier isEqualToString:@"PoliceCountdown"]) {
        NSTableCellView *timeCell = [tableView makeViewWithIdentifier:identifier owner:self];
        timeCell.textField.stringValue = building.policeArrivalTimeAsString;
        return timeCell;
    } else if ([identifier isEqualToString:@"Time"]) {
        NSTableCellView *timeCell = [tableView makeViewWithIdentifier:identifier owner:self];
        timeCell.textField.stringValue = building.request.timeString;
        return timeCell;
    }
    
    return nil;
}

- (void)requestFinished:(Request*)request {
    [tableView reloadData];
}


@end
