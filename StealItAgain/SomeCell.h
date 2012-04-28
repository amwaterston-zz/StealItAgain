//
//  SomeCell.h
//  StealItAgain
//
//  Created by Nicholas Street on 28/04/2012.
//  Copyright (c) 2012 Haiku Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SomeCell : NSTableCellView {
    IBOutlet NSTextField *subTitleTextField;
}

@property(assign) NSTextField *subTitleTextField;

@end
