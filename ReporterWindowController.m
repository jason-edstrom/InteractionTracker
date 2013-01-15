//
//  ReporterWindowController.m
//  InteractionTracker
//
//  Created by Jason Edstrom on 9/8/12.
//  Copyright (c) 2012 Jason Edstrom. All rights reserved.
//

#import "ReporterWindowController.h"

@interface ReporterWindowController ()

@end

@implementation ReporterWindowController
@synthesize helpDeskDisplay;
@synthesize reporterDisplay;
@synthesize transactionDisplay;
@synthesize checkInDisplay;
@synthesize questionsDisplay;
@synthesize timeDisplay9;
@synthesize timeDisplay8;
@synthesize timeDisplay7;
@synthesize timeDisplay6;
@synthesize timeDisplay5;
@synthesize timeDisplay4;
@synthesize timeDisplay3;
@synthesize timeDisplay2;
@synthesize timeDisplay1;

- (id) init{
    self = [super initWithWindowNibName:@"Reporter"];
    return self;
}


- (void)windowDidLoad
{
    [super windowDidLoad];
    NSLog(@"loaded nib");
    
}

@end
