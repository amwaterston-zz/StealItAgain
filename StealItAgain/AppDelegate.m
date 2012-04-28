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

@implementation AppDelegate

@synthesize window = _window;

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
    NSArray *array = [data getBuildingPower];
    for (NSString *blah in array) {
        NSLog(@"%@", blah);
    }
}

- (IBAction)tappity:(id)sender {
    for (int i = 0; i < controllers_connected; i++)
    {
        PSMove *move;
        NSValue *v = [moveArray objectAtIndex:i];
        move = [v pointerValue];
        psmove_set_leds(move, arc4random() % 255, arc4random() % 255, arc4random() % 255);
        psmove_update_leds(move);
    }
    
}
@end
