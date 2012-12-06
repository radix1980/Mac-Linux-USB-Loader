//
//  Document.h
//  Mac Linux USB Loader
//
//  Created by SevenBits on 11/26/12.
//  Copyright (c) 2012 SevenBits. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument
@property (strong) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSPanel *prefsWindow;
@property (unsafe_unretained) IBOutlet NSButton *makeUSBButton;
- (IBAction)showApplicationPrefs:(id)sender;
@property (unsafe_unretained) IBOutlet NSProgressIndicator *spinner;
- (IBAction)openDiskUtility:(id)sender;
- (IBAction)eraseLiveBoot:(id)sender;
- (void)getUSBDeviceList;
- (IBAction)updateDeviceList:(id)sender;
- (IBAction)makeLiveUSB:(id)sender;
- (IBAction)openGithubPage:(id)sender;
@property (unsafe_unretained) IBOutlet NSPopUpButton *usbDriveDropdown;


@end
