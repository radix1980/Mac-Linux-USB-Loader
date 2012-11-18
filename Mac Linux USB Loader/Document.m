//
//  Document.m
//  Mac Linux USB Loader
//
//  Created by Ryan Bowring on 11/16/12.
//  Copyright (c) 2012 Ryan Bowring. All rights reserved.
//

#import "Document.h"

@implementation Document

@synthesize usbDriveDropdown;

- (id)init
{
    self = [super init];
    if (self) {
        // EMPTY
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    [self getUSBDeviceList];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (void)getUSBDeviceList
{
    //Fetch the NSArray of strings of mounted media from the shared workspace
    NSArray *volumes = [[NSWorkspace sharedWorkspace] mountedRemovableMedia];
    
    //Setup target variables for the data to be put into
    BOOL isRemovable, isWritable, isUnmountable;
    NSString *description, *volumeType;
    
    [usbDriveDropdown removeAllItems];
    
    //Iterate through the array using fast enumeration
    for (NSString *volumePath in volumes) {
        //Get filesystem info about each of the mounted volumes
        if ([[NSWorkspace sharedWorkspace] getFileSystemInfoForPath:volumePath isRemovable:&isRemovable isWritable:&isWritable isUnmountable:&isUnmountable description:&description type:&volumeType]) {
            //Write out to stdout
            //printf("%s\n", [[NSString stringWithFormat:@"%@ %@      %@      %d      %d      %d", volumePath, description, volumeType, isRemovable, isWritable, isUnmountable] UTF8String]);
            NSString * title = [NSString stringWithFormat:@"Drive 1: %@",volumePath];
            [usbDriveDropdown addItemWithTitle:title];
        }
    }
    
    //Exit
}

- (IBAction)updateDeviceList:(id)sender {
    [self getUSBDeviceList];
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    return YES;
}

- (IBAction)openDiskUtility:(id)sender {
    [[NSWorkspace sharedWorkspace] launchApplication:@"/Applications/Utilities/Disk Utility.app"];
}
@end
