//
//  ViewController.h
//  IcecastStatus
//
//  Created by Brian Manning on 4/18/12.
//  Copyright (c) 2012 Example Company Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *statusTextView;

// call the XML parser built into IcecastStatusParser
- (void) callXMLParser;
- (void) callXMLParser:(NSURL *)url;

// to be used by the parser to turn on and off the network busy icon
- (void) enableNetworkBusyIcon:(id)sender;
- (void) disableNetworkBusyIcon:(id)sender;

// to be used by the parser to indicate an error of some sort
- (void) displayErrorMsg:(NSString *)errorMsg;

// returns some text to be put into the gui
- (void) updateGUI:(NSString *)msg;

// lets the view controller know that fetching of the status is done;
// update a progress bar?
- (void) fetchIcecastStatusHTMLDone:(NSString *)statusHTML;

// lets the view controller know that parsing of the status is done;
// update a progress bar?
- (void) parseIcecastStatusHTMLDone:(NSString *)statusHTML;


@end
