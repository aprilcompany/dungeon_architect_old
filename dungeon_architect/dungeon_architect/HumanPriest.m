//
//  HumanPriest.m
//  dungeon_architect
//
//  Created by Andre May on 11/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HumanPriest.h"


@implementation HumanPriest

@synthesize mySprite,theGame;

+(id) nodeWithTheGame:(HelloWorldLayer*)_game location:(CGPoint)location
{
    return [[[self alloc] initWithTheGame:_game location:location] autorelease];
}

-(id) initWithTheGame:(HelloWorldLayer *)_game location:(CGPoint)location
{
    if ( (self=[super init])) {
        
        // Setzen der Init-Variablen
        theGame = _game;
        movementrange = 10;
        
        int randomInt;
        randomInt = (arc4random() % 10) + 1;
        movementspeed = 200;
        
        constitution = 1;
        armor = 1;
        damage = 1;
        
        // Setzen des Sprites
        mySprite = [CCSprite spriteWithFile:@"priest.png" rect:CGRectMake(0, 0, 35, 35)];
        int x = location.x;
        int y = location.y;
        mySprite.position = ccp(x,y);
        // Sprite als Kind von CCNode setzen
        [self addChild:mySprite];
        
        // Sprite als Kind des Game-Layers setzen
        [theGame addChild:self];
        
        // Methode zum Bewegen aufrufen
        [self humanpriestStartRandomMoving];
        
    }
    return self;
}

-(void)humanpriestStartRandomMoving
{
    [self humanpriestMoveFinished:self];
}

-(void)humanpriestMoveFinished:(id)sender
{
    CCSprite *target = (CCSprite *)sender;
    // Löschen einer Figure
    ////[self removeChild:sprite cleanup:YES];
    
    // Setzen der Endposition der Bewegung der Figure
    // Bewegung ist geradlinig, für Tile-Map von 35x35 Feldgröße
    //// CGSize winSize = [[CCDirector sharedDirector] winSize];
    //// int maxX = winSize.width;
    //// int maxY = winSize.height;
    //int x = self.position.x;
    //int y = self.position.y;
    //CGPoint test = [target position];
    
    float x = target.position.x;
    float y = target.position.y;
    
    // Eine von 4 Bewegungsrichtungen für Tiles ermitteln
    int direction = (arc4random() % 2)+1;
    switch (direction) {
        case 1:
            x = x + ((arc4random() % 4)+1)*35;
            break;
        case 2:
            x = x - ((arc4random() % 4)+1)*35;
            break;
    }
    
    direction = (arc4random() % 2)+1;
    switch (direction) {
        case 1:
            y = y + ((arc4random() % 4)+1)*35;
            break;
        case 2:
            y = y - ((arc4random() % 4)+1)*35;
            break;
        default:
            y = y + ((arc4random() % 4)+1)*35;
            break;
    }
    
    // Determine speed of the target
    ////int minDuration = 1.0;
    ////int maxDuration = 4.0;
    ////int rangeDuration = maxDuration - minDuration;
    ////int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Nächste Bewegung setzen
    [self humanpriestMoveTo:x :y];
}

-(void)humanpriestMoveTo:(int)x:(int)y
{
    float speed = [self getTimeToTravelPoint:ccp(x, y) fromPoint:self.position speed:movementspeed];
    
    id actionMove = [CCMoveTo actionWithDuration:speed position:ccp(x, y)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(humanpriestMoveFinished:)];
    [self runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    
    
}

-(void)update:(ccTime)dt
{
    
}

-(float)getTimeToTravelPoint:(CGPoint)targetPoint fromPoint:(CGPoint)sourcePoint speed:(int)travelSpeed
{
    return sqrt( pow((targetPoint.x-sourcePoint.x),2) + pow((targetPoint.y-sourcePoint.y),2) ) / travelSpeed;
}

-(void)dealloc
{
	[super dealloc];
}


@end

