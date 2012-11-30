//
//  USBDevice.h
//  Mac Linux USB Loader
//
//  Created by SevenBits on 11/26/12.
//  Copyright (c) 2012 SevenBits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface USBDevice : NSObject

- (BOOL)prepareUSB:(NSString *)path;
- (BOOL)copyISO:(NSString *)path:(NSString *)isoFile;
- (void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode
        contextInfo:(void *)contextInfo;

@end
