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

@implementation AppDelegate

@synthesize window = _window;
@synthesize tableView;

- (void)dealloc
{
    [super dealloc];
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
    
    for (int i = 0; i < controllers_connected; i++)
    {
        NSValue *v = [moveArray objectAtIndex:i];
        PSMove *move = [v pointerValue];
        psmove_set_leds(move, 255, 0, 0);
    }
    
    data = [[DataDAO alloc]init];
    powers = [[data getBuildingPower] retain];
    
    timeT = [powers count] - 1;
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(tappity:) userInfo:nil repeats:YES];
    
    viewLoaded = YES;
    tableView.rowHeight = 140;
    [tableView reloadData];
}

- (IBAction)tappity:(id)sender {
    for (int i = 0; i < controllers_connected; i++)
    {
        PSMove *move;
        NSValue *v = [moveArray objectAtIndex:i];
        move = [v pointerValue];
        psmove_set_leds(move, [[powers objectAtIndex:timeT] intValue] % 255, 0, 0); //arc4random() % 255, arc4random() % 255);
        psmove_update_leds(move);
    }
    timeT--;
}

#pragma mark - TableView

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    if (!viewLoaded) {
        return 0;
    }
    return 1;
}

- (NSView*)tableView:(NSTableView *)aTableView viewForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)row {
    
    NSString *identifier = [aTableColumn identifier];
    
    NSArray *buildings = nil;
    Building *building = [buildings objectAtIndex:row];
    building = [Building loadDummyBuilding];

    if ([identifier isEqualToString:@"Request"]) {

        NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
        // Then setup properties on the cellView based on the column
        cellView.textField.stringValue = [building.request theRequest];;
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
    }
    
    return nil;
}

@end
