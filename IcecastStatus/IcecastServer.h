//
//  IcecastServer.h
//  \brief IcecastServer, an object that encapsulates info about an IcecastServer
//
//  \author Brian Manning 
//  \date Created on 3/1/12.
//  \copyright Copyright (c) 2012 Brian Manning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IcecastServer : NSObject

// attributes
@property (nonatomic, strong) NSDate *serverStart;
@property (nonatomic, strong) NSURL *serverURL;
@property (nonatomic) int currentConnections;
@property (nonatomic) int currentSources;
@property (nonatomic) unsigned int totalConnections;
@property (nonatomic) unsigned int totalClientConnections;
@property (nonatomic) unsigned int totalSourceConnections;
// current list of streams parsed from the status message
@property (nonatomic, strong) NSMutableArray *currentStreams;

// methods
-(NSString *) description;

// How to create this object?
// 1) Use the parseIcecastStatus class method below?
// 2) Create an 'initWithIcecastStatusMessage' method?
// either method should also call/create the IcecastStream objects when it is called

// class init method
//+(IcecastServer *) parseIcecastStatus;

// instance init method
//-(IcecastServer *) initWithIcecastStatusMessage:(NSString *) statusMsg;

@end
