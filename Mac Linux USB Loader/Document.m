//
//  Document.m
//  Mac Linux USB Loader
//
//  Created by SevenBits on 11/26/12.
//  Copyright (c) 2012 SevenBits. All rights reserved.
//

#import "Document.h"
#import "USBDevice.h"

@implementation Document

@synthesize usbDriveDropdown;

NSMutableDictionary *usbs;
USBDevice *device;

- (id)init
{
    self = [super init];
    if (self) {
        //EMPTY
    }
    return self;
}

- (NSString *)windowNibName
{
    return @"Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    usbs = [[NSMutableDictionary alloc]initWithCapacity:10]; //A maximum capacity of 10 is fine, nobody has that many ports anyway
    device = [USBDevice new];
    [self getUSBDeviceList];
}

- (void)getUSBDeviceList
{
    //Fetch the NSArray of strings of mounted media from the shared workspace
    NSArray *volumes = [[NSWorkspace sharedWorkspace] mountedRemovableMedia];
    
    //Setup target variables for the data to be put into
    BOOL isRemovable, isWritable, isUnmountable;
    NSString *description, *volumeType;
    
    [usbDriveDropdown removeAllItems];
    [usbs removeAllObjects];
    
    //Iterate through the array using fast enumeration
    for (NSString *volumePath in volumes) {
        //Get filesystem info about each of the mounted volumes
        if ([[NSWorkspace sharedWorkspace] getFileSystemInfoForPath:volumePath isRemovable:&isRemovable isWritable:&isWritable isUnmountable:&isUnmountable description:&description type:&volumeType]) {
            if ([volumeType isEqualToString:@"msdos"]) {
                NSString * title = [NSString stringWithFormat:@"Drive type %@ at %@", volumeType, volumePath];
                [usbs setObject:volumePath forKey:title]; //Add the path of the usb to a dictionary so later we can tell what USB
                                                          //they are refering to when they select one from a drop down.
                [usbDriveDropdown addItemWithTitle:title];
            }
        }
    }
    
    // Exit
}

- (IBAction)updateDeviceList:(id)sender {
    [self getUSBDeviceList];
}

- (IBAction)makeLiveUSB:(id)sender {
    if ([usbDriveDropdown numberOfItems] != 0) {
        NSString* directoryName = [usbDriveDropdown titleOfSelectedItem];
        NSString* usbRoot = [usbs valueForKey:directoryName];
        NSString* isoFilePath = [[self fileURL] absoluteString];
        
        if (isoFilePath == nil) {
            return;
        }
        
        // Make the Live USB!
        if ([device prepareUSB:usbRoot] == YES) {
            // If there is no document open, don't copy the ISO file.
            [device copyISO:usbRoot:isoFilePath];
        }
    }
    else {
        // TODO
    }
}

+ (BOOL)autosavesInPlace
{
    return NO;
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
