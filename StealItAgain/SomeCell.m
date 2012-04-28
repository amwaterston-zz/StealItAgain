//
//  SomeCell.m
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import "SomeCell.h"

@implementation SomeCell

@synthesize box;
@synthesize building;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

- (void)setBuilding:(Building *)newBuilding {
    if (building != newBuilding) {
        [building release];
        building = [newBuilding retain];
        box.fillColor = building.color;
        self.textField.stringValue = building.buildingName;
    }
}


@end
