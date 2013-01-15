//
//  TrackerDocument.h
//  InteractionTracker
//
//  Created by Jason Edstrom on 8/23/12.
//  Copyright (c) 2012 Jason Edstrom. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Interaction;
@class ReporterWindowController;
@class Reporting;
@class CountReportController;

@interface TrackerDocument : NSPersistentDocument
{
    //Reporting Variables
    Reporting *daily;
    int interNumber;
    int questionsTotal;
    int checkInTotal;
    int transactionTotal;
    int helpDesktotal;
    int time1;
    int time2;
    int time3;
    int time4;
    int time5;
    int time6;
    int time7;
    int time8;
    int time9;
    int time10;
    int time11;
    
   //Array and Table
    NSMutableArray *interactionArray;
    IBOutlet NSTableView *theTable;
    IBOutlet NSArrayController *intController;
    ReporterWindowController *reporterController;
    
    
    //Time Parsing
    NSString *theDate;
    NSString *theTimeHr;
    NSMutableString *filePath;
    NSString *formattedTime;
    //NSString *employeeID;
    
    //Reporting
    __weak NSTextField *employeeID;
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
    __weak NSTextField *timeDisplay10;
    __weak NSTextField *timeDisplay11;
    
    //Tracking
    __weak NSPopUpButton *tier3Cat;
    __weak NSPopUpButton *tier2Cat;
    __weak NSPopUpButton *tier1Cat;
    __weak NSPopUpButton *interactionType;
    __weak NSTextField *intNumberDisplay;
    __weak NSTextField *description;
    __weak NSButton *submit;
    __weak NSButton *track;
    __weak NSButton *remove;
    __weak NSButton *autoSave;
}

- (void) MySQLDatabase: (Interaction *)i;
- (void)setInteractionArray:(NSMutableArray *)a;
- (IBAction)submitInteraction:(id)sender;
- (IBAction)createInteraction:(id)sender;
- (void) resetUI;
- (void)resetUIDuringInt;
- (IBAction)readType:(id)sender;
- (IBAction)readTier1:(id)sender;
- (IBAction)readTier2:(id)sender;
- (IBAction)readTier3:(id)sender;
- (IBAction)readDescription:(id)sender;
- (IBAction)saveFile:(id)sender;
- (IBAction)loadFile:(id)sender;
- (IBAction)clearDay:(id)sender;
- (void)awakeFromNib;

@property (nonatomic) NSString *formattedTime;
@property (nonatomic) int interNumber;
@property (weak, nonatomic) IBOutlet NSTextField *timeStamp;
@property (weak, nonatomic) IBOutlet NSPopUpButton *interactionType;
@property (weak, nonatomic) IBOutlet NSPopUpButton *tier1Cat;
@property (weak, nonatomic) IBOutlet NSPopUpButton *tier2Cat;
@property (weak, nonatomic) IBOutlet NSPopUpButton *tier3Cat;
@property (weak, nonatomic) IBOutlet NSTextField *description;
@property (weak, nonatomic) IBOutlet NSTextField *intNumberDisplay;
@property (weak) IBOutlet NSButton *track;
@property (weak) IBOutlet NSButton *remove;
@property (weak) IBOutlet NSButton *submit;
@property (weak) IBOutlet NSButton *autoSave;
@property (weak) IBOutlet NSTextField *timeDisplay1;
@property (weak) IBOutlet NSTextField *timeDisplay2;
@property (weak) IBOutlet NSTextField *timeDisplay3;
@property (weak) IBOutlet NSTextField *timeDisplay4;
@property (weak) IBOutlet NSTextField *timeDisplay5;
@property (weak) IBOutlet NSTextField *timeDisplay6;
@property (weak) IBOutlet NSTextField *timeDisplay7;
@property (weak) IBOutlet NSTextField *timeDisplay8;
@property (weak) IBOutlet NSTextField *timeDisplay9;
@property (weak) IBOutlet NSTextField *timeDisplay10;
@property (weak) IBOutlet NSTextField *timeDisplay11;
@property (weak) IBOutlet NSTextField *questionsDisplay;
@property (weak) IBOutlet NSTextField *checkInDisplay;
@property (weak) IBOutlet NSTextField *transactionDisplay;
@property (weak) IBOutlet NSTextField *reporterDisplay;
@property (weak) IBOutlet NSTextField *employeeID;
@property (weak) IBOutlet NSTextField *helpDeskDisplay;

@end
