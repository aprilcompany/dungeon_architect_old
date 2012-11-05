//
//  Barbarian.m
//  dungeon_architect
//
//  Created by Andre May on 11/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Barbarian.h"


@implementation Barbarian

@synthesize mySprite,theGame;

+(id) nodeWithTheGame:(HelloWorldLayer*)_game location:(CGPoint)location
{
    return [[[self alloc] initWithTheGame:_game location:location] autorelease];
}

-(id) initWithTheGame:(HelloWorldLayer *)_game location:(CGPoint)location
{
    if ( (self=[super init])) {
        theGame = _game;
        movementrange = 4;
        movementspeed = 1;
        
        constitution = 1;
        armor = 1;
        damage = 1;
        
        mySprite = [CCSprite spriteWithFile:@"barbarian.png" rect:CGRectMake(0, 0, 35, 35)];
        [self addChild:mySprite];
        [theGame addChild:self];
        [self scheduleUpdate];
        
    }
    return self;
}

-(void)update:(ccTime)dt
{
    
}

-(void)dealloc
{
	[super dealloc];
}


@end
