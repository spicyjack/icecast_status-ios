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

-(void) callXMLParser;
-(void) callXMLParser:(NSURL *) url;
-(void) enableNetworkBusyIcon:(id) sender;
-(void) disableNetworkBusyIcon:(id) sender;
-(void) displayErrorMsg:(NSString *) errorMsg;
-(void) updateGUI:(NSString *) msg;


@end
