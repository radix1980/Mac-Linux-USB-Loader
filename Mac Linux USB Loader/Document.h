//
//  Document.h
//  Mac Linux USB Loader
//
//  Created by SevenBits on 11/26/12.
//  Copyright (c) 2012 SevenBits. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument
- (IBAction)openDiskUtility:(id)sender;
- (void)getUSBDeviceList;
- (IBAction)updateDeviceList:(id)sender;
- (IBAction)makeLiveUSB:(id)sender;
@property (unsafe_unretained) IBOutlet NSPopUpButton *usbDriveDropdown;


@end
