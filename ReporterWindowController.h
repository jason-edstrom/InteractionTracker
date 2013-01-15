//
//  ReporterWindowController.h
//  InteractionTracker
//
//  Created by Jason Edstrom on 9/8/12.
//  Copyright (c) 2012 Jason Edstrom. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Reporter;

@interface ReporterWindowController : NSWindowController
{
    __weak NSTextField *reporterDisplay;
    __weak NSTextField *questionsDisplay;
    __weak NSTextField *checkInDisplay;
    __weak NSTextField *transactionDisplay;
    __weak NSTextField *helpDeskDisplay;
    __weak NSTextField *timeDisplay1;
    __weak NSTextField *timeDisplay2;
    __weak NSTextField *timeDisplay3;
    __weak NSTextField *timeDisplay4;
    __weak NSTextField *timeDisplay5;
    __weak NSTextField *timeDisplay6;
    __weak NSTextField *timeDisplay7;
    __weak NSTextField *timeDisplay8;
    __weak NSTextField *timeDisplay9;
}

@property (weak) IBOutlet NSTextField *timeDisplay1;
@property (weak) IBOutlet NSTextField *timeDisplay2;
@property (weak) IBOutlet NSTextField *timeDisplay3;
@property (weak) IBOutlet NSTextField *timeDisplay4;
@property (weak) IBOutlet NSTextField *timeDisplay5;
@property (weak) IBOutlet NSTextField *timeDisplay6;
@property (weak) IBOutlet NSTextField *timeDisplay7;
@property (weak) IBOutlet NSTextField *timeDisplay8;
@property (weak) IBOutlet NSTextField *timeDisplay9;
@property (weak) IBOutlet NSTextField *helpDeskDisplay;
@property (weak) IBOutlet NSTextField *questionsDisplay;
@property (weak) IBOutlet NSTextField *checkInDisplay;
@property (weak) IBOutlet NSTextField *transactionDisplay;
@property (weak) IBOutlet NSTextField *reporterDisplay;

@end
