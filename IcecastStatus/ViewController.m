//
//  ViewController.m
//  IcecastStatus
//
//  Created by Brian Manning on 4/18/12.
//  Copyright (c) 2012 Example Company Inc. All rights reserved.
//

#import "ViewController.h"

// local classes
#import "IcecastServer.h"
#import "IcecastStatusParser.h"

@interface ViewController ()

@end

@implementation ViewController
{
    // implementation variables
    IcecastServer *server;
    NSMutableArray *icecastStreams;
    IcecastStatusParser *parser;
}

@synthesize statusTextView;
NSString *defaultURLString = @"http://stream.xaoc.org:7767/simple.xsl";

// update all of the controls on this view controller
- (void) updateDisplay
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self callXMLParser];
    
}

- (void)viewDidUnload
{
    [self setStatusTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// DISPATCH METHODS
// these will be used by the parser thread
#pragma mark Dispatch Methods


// update the GUI; display the videos by calling the 'description' message
-(void) displayErrorMsg:(id) sender
{
    NSLog(@"displayErrorMsg: error from parser: %@", [sender description]);
    statusTextView.text = [sender description];
}

// update the GUI; display the videos by calling the 'description' message
-(void) updateGUI:(id) sender
{
    //NSLog(@"updateGUI; string from parser: %@", [sender description]);
    statusTextView.text = [sender description];
}

// update the GUI; display the videos by calling the 'description' message
-(void) enableNetworkBusyIcon:(id) sender
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

// update the GUI; display the videos by calling the 'description' message
-(void) disableNetworkBusyIcon:(id) sender
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

// the XML parser, which will be started in it's own thread
// since no URL was supplied, use the default
#pragma mark XML Parsing

-(void)callXMLParser
{
    NSURL *defaultURL = [[NSURL alloc] initWithString:defaultURLString];
    [self callXMLParser:defaultURL];
}

// the XML parser, which will be started in it's own thread
-(void)callXMLParser:(NSURL *) url
{    
    NSLog(@"Creating IcecastStatusParser...");
    parser = [[IcecastStatusParser alloc] init];
    NSLog(@"Calling parser");
    [parser doParseIcecastStatusHTML:self 
                            withData:[parser doFetchIcecastStatusHTML:self withURL:url]];

}


@end
