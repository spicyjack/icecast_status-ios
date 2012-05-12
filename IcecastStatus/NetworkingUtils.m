//
//  NetworkingUtils.m
//  IcecastStatus
//
//  Created by Brian Manning on 3/16/12.
//  Copyright (c) 2012 Brian Manning. All rights reserved.
//

#import "NetworkingUtils.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#import <netinet/in.h>
//#import <arpa/inet.h>
//#import <ifaddrs.h>
#import <netdb.h>


@implementation NetworkingUtils

+(BOOL) isNetworkingAvailable
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability;
    reachability = 
    SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, 
                                           (const struct sockaddr *) &zeroAddress);
    
    if (reachability) {
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if (flags & kSCNetworkReachabilityFlagsReachable) {
                if (flags & kSCNetworkReachabilityFlagsIsWWAN) {
                    NSLog(@"on cell network");
                }
                NSLog(@"reachable");
                return YES;
            }
        }
    }
    
    return NO;
}

@end
