//
//  IcecastStatusParser.h
//  IcecastStatus
//
//  Created by Brian Manning on 4/23/12.
//  Copyright (c) 2012 Example Company Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IcecastStatusParser : NSObject <NSXMLParserDelegate>

// fetches the remote status page and digs out the plaintext status
- (void) doFetchAndParseIcecastStatusHTML:(id)sender withURL:(NSURL *) url;

// parses the plaintext status
- (NSMutableArray *) doParseIcecastStatus:(NSString *)icecastStatus;

@end
