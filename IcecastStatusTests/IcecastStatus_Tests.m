//
//  IcecastStatus_Tests.m
//  IcecastStatusTests
//
//  Created by Brian Manning on 4/18/12.
//  Copyright (c) 2012 Example Company Inc. All rights reserved.
//

#import "IcecastStatus_Tests.h"
#import "IcecastStatusParser.h"
#import "IcecastStream.h"

@implementation IcecastStatus_Tests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    // FIXME add calls to NSBundle to retrieve Icecast HTML status, and 
    // Icecast plaintext status (sample_icecast_status_output.txt)
    // See D51Tab for NSBundle usage
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

/* FIXME
 - Split doFetchAndParseIcecastStatusPage into two different methods so you
 can test it better
 - Rename IcecastStream to IcecastMount
*/

- (void)testDoParseIcecastStatus
{
    NSMutableArray *statusArray = [[NSMutableArray alloc] init];
    NSString *statusMsg = [[NSString alloc] init];
    IcecastStatusParser *parser = [[IcecastStatusParser alloc] init];
    statusArray = [parser doParseIcecastStatus:statusMsg];
    NSMutableArray *streamArray = [parser doParseIcecastStatus:statusMsg];
    STAssertTrue([streamArray isKindOfClass:[NSMutableArray class]], 
                 @"doParseIcecastStatus did not return an NSMutableArray");
    for (IcecastStream *stream in streamArray) {
        STAssertTrue([stream isKindOfClass:[IcecastStream class]], 
                     @"doParseIcecastStatus did not return an IcecastStream object"
                     @"invalid object returned is: %@", [stream description]);
    }
}

@end
