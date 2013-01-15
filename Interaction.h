//
//  Interaction.h
//  InteractionTracker
//
//  Created by Jason Edstrom on 8/8/12.
//  Copyright (c) 2012 Jason Edstrom. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Interaction : NSObject <NSCoding>
{
    int intNumber;
    NSString *interactionType;
    NSString *tier1Cat;
    NSString *tier2Cat;
    NSString *tier3Cat;
    NSString *timeStamp;
    NSString *intDescription;
    NSString *employeeID;
    
}

@property int intNumber;
@property (readwrite, copy) NSString *timeStamp;
@property (readwrite) NSString *interactionType;
@property (readwrite) NSString *tier1Cat;
@property (readwrite) NSString *tier2Cat;
@property (readwrite) NSString *tier3Cat;
@property (readwrite) NSString *intDescription;
@property (readwrite) NSString *employeeID;



- (id) initWithIntNumber:(int)i time:(NSString *)tempStamp type:(NSString *)intType employee:(NSString *) empID tier1:(NSString *)t1c tier2:(NSString *)t2c tier3:(NSString *)t3c intDes:(NSString *)des;

@end
