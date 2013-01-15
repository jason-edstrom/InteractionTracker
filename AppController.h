//
//  AppController.h
//  InteractionTracker
//
//  Created by Jason Edstrom on 9/8/12.
//  Copyright (c) 2012 Jason Edstrom. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ReporterWindowController;
@class CountReportController;

@interface AppController : NSObject
{
    ReporterWindowController *reporterController;
    CountReportController *countReportController;
}

- (IBAction)showReporter:(id)sender;

@end
