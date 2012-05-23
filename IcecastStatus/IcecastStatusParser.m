//
//  IcecastStatusParser.m
//  IcecastStatus
//
//  Created by Brian Manning on 4/23/12.
//  Copyright (c) 2012 Example Company Inc. All rights reserved.
//

#import "IcecastStatusParser.h"
#import "ViewController.h"

// enumerated type
enum ParserState { xmlParse, xmlSkip };

@implementation IcecastStatusParser
{
    // implementation variables
    enum ParserState parserState;
    NSString *parsedText;
    NSXMLParser *xmlParser;
    id appDelegate;
    NSMutableData *rawXMLData;
}

// #### Public Methods ####
#pragma mark Public Methods

// launch the status page downloader/HTML parser in it's own thread
- (NSString *) doFetchIcecastStatusHTML:(id)sender withURL:(NSURL *) url
{
    NSString *fetchedHTML = [[NSString alloc] init];
    NSLog(@"doFetchIcecastStatusHTML: Entering, saving appDelegate object...");
    appDelegate = sender;
    [self triggerEnableNetworkBusyIcon:self];
    [self performSelectorInBackground:@selector(doXMLFetchingInThread:)
                           withObject:url];
    // FIXME create a parser class with the XML parser and the status parser in one object
    // then instantiate the XML parser in the below invocation operation
    //NSInvocationOperation * genOp = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(generateKeyPairOperation) object:nil];
    return fetchedHTML;
}

// launch the status page downloader/HTML parser in it's own thread
- (NSString *) doParseIcecastStatusHTML:(id)sender withData:(NSData *) data
{
    NSString *parsedHTML = [[NSString alloc] init];
    NSLog(@"doParseIcecastStatusHTML: Entering, saving appDelegate object...");
    appDelegate = sender;
    [self triggerEnableNetworkBusyIcon:self];
    [self performSelectorInBackground:@selector(doXMLParsingInThread:)
                           withObject:data];
    return parsedHTML;
}

#pragma mark Methods run in separate threads

// the threaded status page downloader/HTML parser
-(NSString *) doXMLFetchingInThread:(id)sender withObject:(NSURL *)url
{
    NSLog(@"doXMLFetchingInThread");
    NSError *error;
    NSString *parsedHTML = [[NSString alloc] initWithContentsOfURL:url
                                                          encoding:NSUTF8StringEncoding
                                                             error:&error];
    // create a parser that reads from the URL object; this can block, which 
    // is why it's in it's own thread
    // set the delegate class to this (self) class
    [xmlParser setDelegate:self];
    // blocking call
    [xmlParser parse];
    // FIXME this is wrong, need to create a dispatch method for this method 
    // to call once processing is complete
    return parsedHTML;
}


// the threaded status page downloader/HTML parser
-(NSString *) doXMLParsingInThread:(NSData *)data
{
    NSString *parsedHTML = [[NSString alloc] init];
    // create a parser that reads from the URL object; this can block, which 
    // is why it's in it's own thread
    NSLog(@"doXMLParsingInThread");
    xmlParser = [[NSXMLParser alloc] initWithData:data];
    // set the delegate class to this (self) class
    [xmlParser setDelegate:self];
    // blocking call
    [xmlParser parse];
    return parsedHTML;
}

/*
 Icecast status page is formatted as follows:
 - First line format: Field name: field value
 - Subseqent lines are formatted as: value|value|value|etc.
 - Semicolon ends signals the end of the info for that mount
*/

- (NSMutableArray *) doParseIcecastStatus:(NSString *)icecastStatus
{
    NSMutableArray *mountPoints = [[NSMutableArray alloc] init];
    // FIXME split the icecastStatus message into individual lines, then parse
    return mountPoints;
}

// #### Trigger Methods ####
#pragma mark Trigger Methods - methods triggered by other objects/threads

-(void)triggerDisableNetworkBusyIcon:(id)object
{
    NSLog(@"triggerDisableNetworkBusyIcon");
    [appDelegate disableNetworkBusyIcon:self];
}

-(void)triggerEnableNetworkBusyIcon:(id)object
{
    NSLog(@"triggerEnableNetworkBusyIcon");
    [appDelegate enableNetworkBusyIcon:self];
}

-(void)triggerDisplayErrorMsg:(NSString *) errorMsg
{
    NSLog(@"triggerDisplayErrorMsg: %@", errorMsg);
    [appDelegate displayErrorMsg:errorMsg];
}

-(void)triggerUpdateGUI:(NSString *) msg
{
    //NSLog(@"triggerUpdateGUI: %@", msg);
    [appDelegate updateGUI:msg];
}

// #### NSXMLParserDelegate callbacks ####
#pragma mark NSXMLParserDelegate callbacks
 
// parsing error occured; notify the GUI running in the main thread
-(void)parser:(NSXMLParser *)aParser parseErrorOccurred:(NSError *)parseError
{
    [self performSelectorOnMainThread:@selector(triggerDisplayErrorMsg:) 
     // localize the error description
                           withObject:[parseError localizedDescription]
                        waitUntilDone:NO];
}

// notify when the parser started
-(void)parserDidStartDocument:(NSXMLParser *)aParser
{
    [self performSelectorOnMainThread:@selector(triggerDisableNetworkBusyIcon:) 
                           withObject:nil
                        waitUntilDone:NO];
}

// we're starting to parse an <element>
-(void)parser:(NSXMLParser *)aParser didStartElement:(NSString *)elementName 
 namespaceURI:(NSString *)namespaceURI 
qualifiedName:(NSString *)qName 
   attributes:(NSDictionary *)attributeDict
{
    // we're only looking for the <pre> element
    if ( [elementName isEqualToString:@"pre"] ) {
        parserState = xmlParse;
        return;
    }
}

// we're starting to parse characters in an <element>
-(void)parser:(NSXMLParser *)aParser foundCharacters:(NSString *)string
{
    // use the current state to decide what to do
    switch (parserState) {
        case xmlParse:
            // if the parse flag is set...
            NSLog(@"Found text in between the <pre> tags...\n");
            parsedText = string;
            // send a message to the main thread at the end of parsing
            // with the contents of the <pre> tags
            parserState = xmlSkip;
            //break;
            return;
        default:
            //break;
            return;
    }
}

// notify when the document is finished parsing
-(void)parserDidEndDocument:(NSXMLParser *)aParser
{
    // FIXME pass back the text in the <pre> tags
    [self performSelectorOnMainThread:@selector(triggerUpdateGUI:) 
                           withObject:parsedText 
                        waitUntilDone:NO];
}

@end
