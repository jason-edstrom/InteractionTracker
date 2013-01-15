//
//  TrackerDocument.m
//  InteractionTracker
//
//  Created by Jason Edstrom on 8/23/12.
//  Copyright (c) 2012 Jason Edstrom. All rights reserved.
//

#import "TrackerDocument.h"
#import "Interaction.h"
#import "ReporterWindowController.h"
#import "Reporting.h"
#import "CountReportController.h"

@implementation TrackerDocument
{
    NSArray *files;
}

@synthesize autoSave;
@synthesize reporterDisplay;
@synthesize transactionDisplay;
@synthesize checkInDisplay;
@synthesize questionsDisplay;
@synthesize helpDeskDisplay;
@synthesize timeDisplay11;
@synthesize timeDisplay10;
@synthesize timeDisplay9;
@synthesize timeDisplay8;
@synthesize timeDisplay7;
@synthesize timeDisplay6;
@synthesize timeDisplay5;
@synthesize timeDisplay4;
@synthesize timeDisplay3;
@synthesize timeDisplay2;
@synthesize timeDisplay1;
@synthesize description;
@synthesize remove;
@synthesize track;
@synthesize submit;
@synthesize interNumber;
@synthesize intNumberDisplay;
@synthesize formattedTime;
@synthesize tier3Cat;
@synthesize tier2Cat;
@synthesize tier1Cat;
@synthesize interactionType;
@synthesize timeStamp;
@synthesize employeeID;

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"init: array");
        interactionArray = [[NSMutableArray alloc] init];
        reporterController = [[ReporterWindowController alloc] init];
        //daily = [[Reporting alloc] init];
        
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"TrackerDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    /*if (!interactionArray){
        interactionArray = [NSMutableArray array];
    }
    
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:interactionArray format:NSPropertyListXMLFormat_v1_0 options:NSPropertyListMutableContainers error:outError];
    
    return data;*/
 /*
    //End editing
    [[theTable window] endEditingFor:nil];
    
    //Create an NSData object from the employees array
    return [NSKeyedArchiver archivedDataWithRootObject:interactionArray];*/
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    //interactionArray = [NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:outError];
    
    //return (interactionArray != nil);
   /* NSLog(@"About to read data of type %@", typeName);
    NSMutableArray *newArray = nil;
    @try {
        newArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *e) {
        NSLog(@"exception = %@", e);
        if(outError){
            NSDictionary *d = [NSDictionary dictionaryWithObject:@"The data is corrupted" forKey:NSLocalizedFailureReasonErrorKey];
            *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:d];
        }
        return NO;
    }
    [self setInteractionArray:newArray];
    return YES;*/
    return NO;
}
#pragma  mark - Archiving and file operations

-(IBAction)clearDay:(id)sender
{
    [[intController mutableArrayValueForKey:@"content"] removeAllObjects];
    NSMutableArray *clear = [[NSMutableArray alloc] init];
    interactionArray = clear;
    interNumber = 0;
    questionsTotal = 0;
    checkInTotal=0;
    transactionTotal=0;
    time1=0;
    time2=0;
    time3=0;
    time4=0;
    time5=0;
    time6=0;
    time7=0;
    time8=0;
    time9=0;
    time10=0;
    time11=0;
    [autoSave setState:0];
    [autoSave setEnabled:NO];
    
}


-(IBAction)loadFile:(id)sender
{
    int i;
    // Create the File Open Dialog class.
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Enable the selection of files in the dialog.
    [openDlg setCanChooseFiles:YES];
    
    // Multiple files not allowed
    [openDlg setAllowsMultipleSelection:NO];
    
    // Can't select a directory
    [openDlg setCanChooseDirectories:NO];
    
    // Display the dialog. If the OK button was pressed,
    // process the files.
    if ( [openDlg runModal] == NSOKButton )
    {
        // Get an array containing the full filenames of all
        // files and directories selected.
        files = [openDlg filenames];
        
        // Loop through all the files and process them.
        for( i = 0; i < [files count]; i++ )
        {
            NSString* fileName = [files objectAtIndex:i];
            NSLog(@"%@",fileName);
            NSData *dataFromFile = [[NSData alloc] initWithContentsOfFile:fileName options:NSPropertyListXMLFormat_v1_0 error:nil];
            //NSLog(@"%@", dataFromFile);
            NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:dataFromFile];
            NSLog(@"Opening and Reading %@", fileName);
            for (Interaction *i in array){
                NSLog(@"Interaction %lu Time: %@ Type: %@", [array indexOfObject:i], [i timeStamp],[i interactionType]);
                NSString *hour =[self justTheHour:[i timeStamp]];
                NSLog(@"%@", hour);
                [self reportingDaily:hour type:[i interactionType] tier1:[i tier1Cat]];
                
            }
            NSLog(@"%@", array);
            NSMutableString *reportingDisplayLabel = [[NSMutableString alloc] initWithFormat:@"Daily Reporter for "];
            [reportingDisplayLabel appendString:theDate];
            [reporterDisplay setStringValue:reportingDisplayLabel];
            [intController addObjects:array];
            }
        }
    }


-(void)makeFileName
{
    
    filePath = [[NSMutableString alloc] initWithFormat:@"/Users/Shared/GSInteractions/KeyedArchiverDays/"];
    [filePath appendString:theDate];
    [filePath appendString:@".xml"];
    NSLog(@"Set file path: %@", filePath);
}

-(void)makeFolder
{
    BOOL isDir = YES;
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    NSString *folderPath = [[NSString alloc] initWithFormat:@"/Users/Shared/GSInteractions/KeyedArchiverDays/"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:&isDir]){
        NSFileManager *fileManager = [[NSFileManager alloc]init];
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:NULL];
        NSLog(@"Created Folder: %@", folderPath);
    }
    else if ([[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:&isDir]){
        NSLog(@"Folder exists: %@",folderPath);
        
    }
    else if(![fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:NULL]){
        NSLog(@"Failed to create location: %@", folderPath);
        
    }

}

- (NSString *)justTheHour:(NSString *)timestampString{
    NSArray *test = [[NSArray alloc] init];
    test = [timestampString componentsSeparatedByString:@" "];
    NSString *time = [[NSString alloc] initWithFormat:[test objectAtIndex:3]];
    NSRange closeBracket = [time rangeOfString:@":"];
    NSRange numberRange = NSMakeRange(0, closeBracket.location);
    NSString *numberString = [time substringWithRange:numberRange];
    
    return numberString;
}
- (IBAction)saveFile:(id)sender
{
    //Removes old file from location
    NSFileManager *fm = [[NSFileManager alloc] init];
    [fm removeItemAtPath:filePath error:nil];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:interactionArray];
    [data writeToFile:filePath options:NSPropertyListXMLFormat_v1_0 error:nil];
    
    
}

#pragma  mark - Reporting Logic

-(void)reportingDaily:(NSString *)hourReport type:(NSString *)reportedType tier1:(NSString *)reportedTier1
{
    //Time interval reporting
    if([hourReport isEqualToString:@"07"] ^ [hourReport isEqualToString:@"7"]){
        time10++;
        [timeDisplay10 setIntValue:time10];
    }
    else if([hourReport isEqualToString:@"08"] ^ [hourReport isEqualToString:@"8"]){
        time1++;
        //[daily num]
        [timeDisplay1 setIntValue:time1];
    }
    else if([hourReport isEqualToString:@"09"] ^ [hourReport isEqualToString:@"9"]){
        time2++;
        [timeDisplay2 setIntValue:time2];
    }
    else if([hourReport isEqualToString:@"10"]){
        time3++;
        [timeDisplay3 setIntValue:time3];
    }
    else if([hourReport isEqualToString:@"11"]){
        time4++;
        [timeDisplay4 setIntValue:time4];
        [reporterController.timeDisplay4 setIntValue:time4];
    }
    else if([hourReport isEqualToString:@"12"]){
        time5++;
        [timeDisplay5 setIntValue:time5];
    }
    else if([hourReport isEqualToString:@"13"] ^ [hourReport isEqualToString:@"1"]){
        time6++;
        [timeDisplay6 setIntValue:time6];
    }
    else if([hourReport isEqualToString:@"14"] ^ [hourReport isEqualToString:@"2"]){
        time7++;
        [timeDisplay7 setIntValue:time7];
    }
    else if([hourReport isEqualToString:@"15"] ^ [hourReport isEqualToString:@"3"]){
        time8++;
        [timeDisplay8 setIntValue:time8];
        [reporterController.timeDisplay8 setIntValue:time8];
    }
    else if([hourReport isEqualToString:@"16"] ^ [hourReport isEqualToString:@"4"]){
        time9++;
        [timeDisplay9 setIntValue:time9];
        [reporterController.timeDisplay9 setIntValue:time9];
    }
    else if([hourReport isEqualToString:@"17"] ^ [hourReport isEqualToString:@"5"]){
        time11++;
        [timeDisplay11 setIntValue:time11];
    }


    if (reportedType)
    {
        if([reportedType isEqualToString:@"Check - in"]){
            if ([reportedTier1 isEqualToString:@"L2 Help Desk"]) {
                NSLog(@"posting Help Desk");
                helpDesktotal++;
                [helpDeskDisplay setIntValue:helpDesktotal];
            }
            else{
            NSLog(@"posting Check-in");
            checkInTotal++;
            [checkInDisplay setIntValue:checkInTotal];
            }
        }
        else if([reportedType isEqualToString:@"Question"]){
            if ([reportedTier1 isEqualToString:@"L2 Help Desk"]) {
                NSLog(@"posting Help Desk");
                helpDesktotal++;
                [helpDeskDisplay setIntValue:helpDesktotal];
            }
            else{
            NSLog(@"posting Question");
            questionsTotal++;
            [questionsDisplay setIntValue:questionsTotal];
        }
        }
        else if([reportedType isEqualToString:@"Transaction"]){
            NSLog(@"posting Transaction");
            transactionTotal++;
            [transactionDisplay setIntValue:transactionTotal];
        }
        else if([reportedType isEqualToString:@"Help Desk"]){
            NSLog(@"posting Help Desk");
            helpDesktotal++;
            [helpDeskDisplay setIntValue:helpDesktotal];
        }
        
    }
    else{
        
    if([interactionType indexOfSelectedItem] == 0) {
        NSLog(@"posting Check-in");
        checkInTotal++;
        [checkInDisplay setIntValue:checkInTotal];
    }
    else if([interactionType indexOfSelectedItem] == 1){
        NSLog(@"interactiontype index: %ld", [interactionType indexOfSelectedItem]);
        NSLog(@"posting Help Desk");
        helpDesktotal++;
        [helpDeskDisplay setIntValue:helpDesktotal];
    }
    else if([interactionType indexOfSelectedItem] == 2){
        NSLog(@"interactiontype index: %ld", [interactionType indexOfSelectedItem]);
        NSLog(@"posting Question");
        questionsTotal++;
        [questionsDisplay setIntValue:questionsTotal];
    }
    else if([interactionType indexOfSelectedItem] == 3){
        NSLog(@"posting Transaction");
        transactionTotal++;
        [transactionDisplay setIntValue:transactionTotal];
    }
    }
}

-(void) setInteractionArray:(NSMutableArray *)a
{
    if (a == interactionArray)
        return;
    
    interactionArray = a;
    
}

#pragma mark - NSButton Interactions

- (IBAction)createInteraction:(id)sender
{
    
    interNumber=[interactionArray count]+1;
    [intNumberDisplay setIntValue:interNumber];
    [timeStamp setStringValue:[self makeTimeStamp]];
    NSLog(@"Posting Time Stamp to UI");
    NSLog(@"Enabling options");
    [interactionType setEnabled:YES];
    [tier1Cat setEnabled:YES];
    [tier2Cat setEnabled:YES];
    [tier3Cat setEnabled:YES];
    [description setEnabled:YES];
    
    [track setEnabled:NO];
    [remove setEnabled:NO];
}

- (IBAction)submitInteraction:(id)sender {
    if ([[employeeID stringValue] isEqualToString:@"Employee ID"]){
        [employeeID setStringValue:@""];
    }
    Interaction *current = [[Interaction alloc] initWithIntNumber:interNumber time:[timeStamp stringValue] type:[interactionType titleOfSelectedItem] employee: [employeeID stringValue] tier1:[tier1Cat titleOfSelectedItem] tier2:[tier2Cat titleOfSelectedItem] tier3:[tier3Cat titleOfSelectedItem] intDes:[description stringValue]];
    [self MySQLDatabase:current];
   [intController addObject:current];
    if ([autoSave state]==1){
        //Removes old file from location
        NSFileManager *fm = [[NSFileManager alloc] init];
        [fm removeItemAtPath:filePath error:nil];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:interactionArray];
        [data writeToFile:filePath options:NSPropertyListXMLFormat_v1_0 error:nil];

    }
    //[self MySQLDatabase:current];
    [self reportingDaily:theTimeHr type:nil tier1:nil];
    [self resetUI];
    
    
    //NSLog(@"Print out: %@", [intController ])
}

-(IBAction)removeSelectedInteraction:(id)sender
{
    NSArray *items = [intController selectedObjects];
    if([items count] ==0){
        NSBeep();
    }
    [intController removeObjects:items];
    
    [remove setEnabled:YES];
}

#pragma mark - Web transmissions

- (void) MySQLDatabase:(Interaction *)i
{
    
    // create string contains url address for php file, the file name is phpFile.php, it receives parameter :name
    NSMutableString *strURL = [NSMutableString stringWithFormat:@"http://23.30.231.141/Geek_Squad_Development/InteractionTracker/post.php?"];
    [strURL appendFormat:@"timestamp=%@&",[i timeStamp]];
    [strURL appendFormat:@"type=%@&",[i interactionType]];
    [strURL appendFormat:@"tier1=%@&",[i tier1Cat]];
    [strURL appendFormat:@"tier2=%@",[i tier2Cat]];
    //[strURL appendFormat:@"description=%@",[i description];
    NSLog(@"strURL:%@", strURL);
     NSString *send = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"send:%@", send);
    
    // to execute php code
    NSData *dataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:send]];
    //StringbyAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding
    
    // to receive the returend value
    NSString *strResult = [[NSString alloc] initWithData:dataURL encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", strResult);

}

#pragma mark - UI resets

- (void)resetUIDuringInt{
    //[tier1Cat removeAllItems];
    [tier2Cat removeAllItems];
    [tier3Cat removeAllItems];
    [employeeID setEnabled:NO];
}

- (void)resetUI
{
    [timeStamp setStringValue:@"Time Stamp Here"];
    [interactionType selectItemWithTitle:@"Help Desk"];
    [tier1Cat removeAllItems];
    [tier2Cat removeAllItems];
    [tier3Cat removeAllItems];
    [employeeID setStringValue:@"Employee ID"];
    [description setStringValue:@""];
    NSLog(@"Disabling options");
    [interactionType setEnabled:NO];
    [tier1Cat setEnabled:NO];
    [tier2Cat setEnabled:NO];
    [tier3Cat setEnabled:NO];
    [description setEnabled:NO];
    [employeeID setEnabled:NO];
    [submit setEnabled:NO];
    [track setEnabled:YES];
    [remove setEnabled:YES];
}


#pragma mark - NSPopUpButton

- (IBAction)readType:(id)sender
{
    NSString *selected = [interactionType titleOfSelectedItem];
    NSLog(@"Selected type of interaction is %@", selected);
    [submit setEnabled:YES];
    [self resetUIDuringInt];
    [tier1Cat addItemsWithTitles:[self setTier1Cat]];
}

- (IBAction)readTier1:(id)sender
{
    NSString *selected = [tier1Cat titleOfSelectedItem];
    NSLog(@"Selected tier 1 is %@", selected);
    [tier2Cat addItemsWithTitles:[self setTier2Cat]];
    
}

- (IBAction)readTier2:(id)sender
{
    NSString *selected = [tier2Cat titleOfSelectedItem];
    NSLog(@"Selected tier 2 is %@", selected);
    [self setTier3Cat];
}

- (IBAction)readTier3:(id)sender
{
    NSString *selected = [tier3Cat titleOfSelectedItem];
    NSLog(@"Selected tier 3 is %@", selected);
   
}

-(void) readDescription:(id)sender
{
    NSString *input = [description stringValue];
    NSLog(@"setting Current Interaction's description to %@", input);
    
}

#pragma  mark - Opening, Loading Logic

- (void) awakeFromNib
{
    //Initialize select box components
    [interactionType removeAllItems];
    NSArray *intTypeArray = [[NSArray alloc] initWithObjects:@"Check - in", @"Help Desk", @"Question", @"Transaction", nil];
    [interactionType addItemsWithTitles:intTypeArray];
    [interactionType selectItemWithTitle:@"Help Desk"];
    [tier1Cat removeAllItems];
    [tier2Cat removeAllItems];
    [tier3Cat removeAllItems];
        
    //Making timestamp and resulting filename
    [self makeTimeStamp];
    [self makeFolder];
    [self makeFileName];
    
    //loading dynamic file name
    NSData *dataFromFile = [[NSData alloc] initWithContentsOfFile:filePath options:NSPropertyListXMLFormat_v1_0 error:nil];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:dataFromFile];
    for (Interaction *i in array){
        NSLog(@"Interaction %lu Time: %@ Type: %@", [array indexOfObject:i], [i timeStamp],[i interactionType]);
        NSString *hour =[self justTheHour:[i timeStamp]];
        NSLog(@"%@", hour);
        [self reportingDaily:hour type:[i interactionType] tier1:[i tier1Cat]];

    }
    NSLog(@"%@", array);
    NSMutableString *reportingDisplayLabel = [[NSMutableString alloc] initWithFormat:@"Daily Reporter for "];
    [reportingDisplayLabel appendString:theDate];
    [reporterDisplay setStringValue:reportingDisplayLabel];
    [intController addObjects:array];
     
}


-(NSString *)makeTimeStamp
{
    //Time Stamp
    NSDate *now = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    formattedTime = [dateFormatter stringFromDate:now];
    NSLog(@"%@",formattedTime);
    
    //For interaction reporting
    NSDateFormatter *timeFormat=[[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH"];
    theTimeHr = [timeFormat stringFromDate:now];
    NSLog(@"hour of interaction: %@",theTimeHr);
    
    //For file naming
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    theDate = [dateFormat stringFromDate:now];
    NSLog(@"date of interaction: %@",theDate);
    
    //Normal return
    return formattedTime;
}

#pragma  mark - Tier PopUpButton Logic

- (NSArray *) setTier1Cat
{
    NSInteger selectedType = [interactionType indexOfSelectedItem];
    NSLog(@"setTier1Cat:selectedType:%ld",selectedType);
    NSArray *tier1Array;
    [tier1Cat removeAllItems];
    switch (selectedType) {
        case 0:
            tier1Array = [[NSArray alloc] initWithObjects:@"Hardware", @"Software", @"Mobile", @"Diag and Repair", @"Data", @"Apple", @"Laptop Repair", nil];
            [tier1Cat setEnabled:YES];
            [tier2Cat setEnabled:YES];
            [tier3Cat setEnabled:YES];
            break;
        case 1:
            [tier1Cat removeAllItems];
            [tier1Cat addItemWithTitle:@"None"];
            [tier2Cat addItemWithTitle:@"None"];
            [tier3Cat addItemWithTitle:@"None"];
            [employeeID setEnabled:YES];
            [tier1Cat setEnabled:NO];
            [tier2Cat setEnabled:NO];
            [tier3Cat setEnabled:NO];
            break;
        case 2:
            tier1Array = [[NSArray alloc] initWithObjects:@"Hardware", @"Software", @"Mobile", @"Diag and Repair", @"Data", @"Apple", @"Laptop Repair", @"On-Site", nil];
            [tier1Cat setEnabled:YES];
            [tier2Cat setEnabled:YES];
            [tier3Cat setEnabled:YES];
            break;
        case 3:
            tier1Array = [[NSArray alloc] initWithObjects:@"FMS", @"OMS", @"POS", nil];
            [tier1Cat setEnabled:YES];
            [tier2Cat setEnabled:YES];
            [tier3Cat setEnabled:YES];
            break;
        default:
            break;
            
    }
    return tier1Array;
}

- (NSArray *) setTier2Cat
{
    NSInteger selectedTier1 = [tier1Cat indexOfSelectedItem];
    NSArray *none = [[NSArray alloc] initWithObjects:@"None", nil];
    NSArray *tier2Array;
    [tier2Cat removeAllItems];
    
    NSLog(@"type: %ld tier1: %ld", [interactionType indexOfSelectedItem], [tier1Cat indexOfSelectedItem]);
    if ([interactionType indexOfSelectedItem] == 3){
        switch (selectedTier1) {
            case 0:
                tier2Array = [[NSArray alloc] initWithObjects:@"HNMS", @"HT", @"DNR", @"HEA Consult", nil];
                [tier3Cat addItemWithTitle:@"None"];
                [tier3Cat setEnabled:NO];
                break;
                
            case 2:
                
                [tier2Cat setEnabled:NO];
                [tier3Cat addItemWithTitle:@"None"];
                [tier3Cat setEnabled:NO];
                return none;
                break;
                
            case 3:
                [tier3Cat addItemWithTitle:@"None"];
                [tier2Cat setEnabled:NO];
                [tier3Cat setEnabled:NO];
                return none;
                break;
        }
    }
    else {
        switch (selectedTier1) {
            case 0:
                tier2Array = [[NSArray alloc] initWithObjects:@"Hard Drive", @"Motherboard", @"Heatsink/Fan", @"Power Supply", @"Video Card",@"Memory",@"Optical Drive",@"Sound Card",@"Other", nil];
                break;
                
            case 1:
                tier2Array = [[NSArray alloc] initWithObjects:@"AntiVirus", @"Productivity", @"Drivers", @"Email", @"Web Browser",@"Operating System",@"Backup",@"User Account",@"Other", nil];
                break;
                
            case 2:
                tier2Array = [[NSArray alloc] initWithObjects:@"App Crash", @"Syncing", @"Email", @"Hardware Repair", @"Updates",@"Other", nil];
                break;
                
            case 3:
                tier2Array = [[NSArray alloc] initWithObjects:@"BSOD", @"KSOD", @"Malware", @"Boot Loop", @"OS Error",@"Operating System",@"Backup",@"User Account",@"Other", nil];
                break;
                
            case 4:
                tier2Array = [[NSArray alloc] initWithObjects:@"Recovery", @"Transfer", @"Backup", @"Cloud",@"Other", nil];
                break;
                
            case 5:
                tier2Array = [[NSArray alloc] initWithObjects:@"Hardware", @"Software", @"Operating System", @"iCloud",@"Mobile Device", @"Other", nil];
                break;
                
            case 6:
                tier2Array = [[NSArray alloc] initWithObjects:@"Keyboard", @"Heatsink/Fan", @"Inverter", @"LCD Screen",@"Case", @"Other", nil];
                break;
                
            case 7:
                tier2Array = [[NSArray alloc] initWithObjects:@"HNMS", @"DNR", @"HT", @"GSR",@"Diag", @"Other", nil];
                break;
                
                
            default:
                break;
        }
        
    }
    
    return tier2Array;
    
    
}

- (void) setTier3Cat
{
    
}



@end

