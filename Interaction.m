//
//  Interaction.m
//  InteractionTracker
//
//  Created by Jason Edstrom on 8/8/12.
//  Copyright (c) 2012 Jason Edstrom. All rights reserved.
//

#import "Interaction.h"


@implementation Interaction

@synthesize intNumber;
@synthesize timeStamp;
@synthesize interactionType;
@synthesize tier1Cat;
@synthesize tier2Cat;
@synthesize tier3Cat;
@synthesize intDescription;
@synthesize employeeID;

-(id) init
{
    if (self){
        intNumber = 1;
        timeStamp = @"RIGHT NOW!!!";
        interactionType = @"KITTIES";
        tier1Cat = @"PUPPIES!";
        tier2Cat = @"STUFF";
        tier3Cat = @"Things!";
        intDescription = @"default test values to test posting to array and tableView";
    }
    
    return self;
}

- (id) initWithIntNumber:(int)i time:(NSString *)tempStamp type:(NSString *)intType employee:(NSString *) empID tier1:(NSString *)t1c tier2:(NSString *)t2c tier3:(NSString *)t3c intDes:(NSString *)des{
    self = [super init];
    if (self){
        intNumber = i;
        timeStamp = tempStamp;
        interactionType = intType;
        tier1Cat = t1c;
        tier2Cat = t2c;
        tier3Cat = t3c;
        employeeID = empID;
        intDescription = des;
    }
    return self;
}

#pragma  mark - NSCoder methods

- (void) encodeWithCoder:(NSCoder *)coder
{
    
    [coder encodeInt:intNumber forKey:@"intNumber"];
    [coder encodeObject:timeStamp forKey:@"timeStamp"];
    [coder encodeObject:interactionType forKey:@"interactionType"];
    [coder encodeObject:employeeID forKey:@"employeeID"];
    [coder encodeObject:tier1Cat forKey:@"tier1Cat"];
    [coder encodeObject:tier2Cat forKey:@"tier2Cat"];
    [coder encodeObject:tier3Cat forKey:@"tier3Cat"];
    [coder encodeObject:intDescription forKey:@"intDescription"];
}

- (id) initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self){
        intNumber = [coder decodeIntForKey:@"intNumber"];
        timeStamp = [coder decodeObjectForKey:@"timeStamp"];
        interactionType = [coder decodeObjectForKey:@"interactionType"];
        employeeID = [coder decodeObjectForKey:@"employeeID"];
        tier1Cat = [coder decodeObjectForKey:@"tier1Cat"];
        tier2Cat = [coder decodeObjectForKey:@"tier2Cat"];
        tier3Cat = [coder decodeObjectForKey:@"tier3Cat"];
        intDescription = [coder decodeObjectForKey:@"intDescription"];
    }
    return self;
}
 
@end
