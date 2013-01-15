//
//  AppController.m
//  InteractionTracker
//
//  Created by Jason Edstrom on 9/8/12.
//  Copyright (c) 2012 Jason Edstrom. All rights reserved.
//

#import "AppController.h"
#import "ReporterWindowController.h"
#import "CountReportController.h"
@implementation AppController

- (IBAction)showReporter:(id)sender{
    //Is ReporterController nil?
    if(!reporterController){
        reporterController = [[ReporterWindowController alloc] init];
    }
    NSLog(@"showing %@", reporterController);
    [reporterController showWindow:self];
}

- (IBAction)showCountReporter:(id)sender{
    //Is CountReporter nil?
    if(!countReportController){
        countReportController = [[CountReportController alloc] init];
    }
    NSLog(@"showing %@", countReportController);
    [countReportController showWindow:self];

}

@end
