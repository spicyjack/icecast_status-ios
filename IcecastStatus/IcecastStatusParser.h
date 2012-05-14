//
//  IcecastStatusParser.h
//  IcecastStatus
//
//  Created by Brian Manning on 4/23/12.
//  Copyright (c) 2012 Example Company Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IcecastStatusParser : NSObject <NSXMLParserDelegate>

// fetches the remote status page
- (NSData *) doFetchIcecastStatusHTML:(id)sender withURL:(NSURL *) url;

// parse out the plaintext status from the HTML fetched using doFetchIcecastStatusHTML
- (NSString *) doParseIcecastStatusHTML:(id)sender withData:(NSData *)statusHTML;

// parses the plaintext status
- (NSMutableArray *) doParseIcecastStatus:(NSString *)icecastStatus;

@end
