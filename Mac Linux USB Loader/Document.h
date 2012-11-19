//
//  Document.h
//  Mac Linux USB Loader
//
//  Created by Ryan Bowring on 11/16/12.
//  Copyright (c) 2012 Ryan Bowring. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument
- (IBAction)openDiskUtility:(id)sender;
- (void)getUSBDeviceList;
- (IBAction)updateDeviceList:(id)sender;
- (IBAction)makeLiveUSB:(id)sender;
@property (unsafe_unretained) IBOutlet NSPopUpButton *usbDriveDropdown;


@end
