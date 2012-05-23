//
//  IcecastStream.m
//  IcecastStatus
//
//  Created by Brian Manning on 3/27/12.
//  Copyright (c) 2012 Brian Manning. All rights reserved.
//

#import "IcecastMount.h"

@implementation IcecastMount

@synthesize mountPoint;
@synthesize streamName;
@synthesize streamStart;
@synthesize currentListeners;
@synthesize streamDescription;
@synthesize currentlyPlayingSong;
@synthesize streamURL;

-(NSString *) description
{
    NSLog(@"description method");
    return @"return value";
}

@end
