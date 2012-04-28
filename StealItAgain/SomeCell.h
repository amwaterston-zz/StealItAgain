//
//  SomeCell.h
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Building.h"

@interface SomeCell : NSTableCellView {
    IBOutlet NSBox *box;
}

@property(assign) NSBox *box;
@property(nonatomic, retain) Building *building;

@end
