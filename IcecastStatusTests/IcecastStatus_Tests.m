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
    STAssertTrue([statusArray isMemberOfClass:[NSMutableArray class]],
                 @"doParseIcecastStatus returned array of IcecastStatus objects");
    for (IcecastStream *stream in statusArray) {
        STAssertTrue([stream isMemberOfClass:[IcecastStream class]],
                     @"Member of IcecastStatus array is an IcecastStream object");
    }
}

@end
