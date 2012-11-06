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

static int name;

+(id) nodeWithTheGame:(HelloWorldLayer*)_game location:(CGPoint)location
{
    return [[[self alloc] initWithTheGame:_game location:location] autorelease];
}

-(id) initWithTheGame:(HelloWorldLayer *)_game location:(CGPoint)location
{
    if ( (self=[super init])) {
        
        // Setzen der Init-Variablen
        theGame = _game;
        movementrange = 4;
        
        int randomInt;
        randomInt = (arc4random() % 10) + 1;
        movementspeed = 50;
        
        constitution = 1;
        armor = 1;
        damage = 1;
        barbarname = name;
        name++;
        
        // Setzen des Sprites
        mySprite = [CCSprite spriteWithFile:@"barbarian.png" rect:CGRectMake(0, 0, 35, 35)];
        int x = location.x;
        int y = location.y;
        mySprite.position = ccp(x,y);
        // Sprite als Kind von CCNode setzen
        [self addChild:mySprite];
        
        // Sprite als Kind des Game-Layers setzen
        [theGame addChild:self];
        
        // Methode zum Bewegen aufrufen
        [self barbarianStartRandomMoving];
        
        ////CCLabelTTF *label = [[CCLabelTTF alloc] initWithString:[[NSNumber numberWithInt:barbarname] stringValue] dimensions:CGSizeMake([mySprite contentSize].width, [mySprite contentSize].height) alignment:UITextAlignmentCenter fontName:@"verdana" fontSize:20.0f];

        NSString *namedesbarbar = [[NSNumber numberWithInt:barbarname] stringValue];
        
        label = [[CCLabelTTF alloc] initWithString:namedesbarbar dimensions:CGSizeMake([mySprite contentSize].width, [mySprite contentSize].height) alignment:UITextAlignmentLeft fontName:@"verdana" fontSize:10.0f];
        
        [mySprite addChild:label z: 10];
        [self schedule:@selector(update:) interval:0.1];
    }
    return self;
}

-(void)barbarianStartRandomMoving
{
    [self barbarianMoveFinished:self];
}

-(void)barbarianMoveFinished:(id)sender
{
    CCSprite *target = (CCSprite *)sender;
    
    // Setzen der Endposition der Bewegung der Figure
    // Bewegung ist geradlinig, für Tile-Map von 35x35 Feldgröße
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    int maxX = winSize.width;
    int maxY = winSize.height;
    
    float x = target.position.x;
    float y = target.position.y;
    
    // Eine von 4 Bewegungsrichtungen für Tiles ermitteln
    int direction = (arc4random() % 4)+1;
    switch (direction) {
        case 1:
            x = x + ((arc4random() % 4)+1)*35;
            break;
        case 2:
            y = y + ((arc4random() % 4)+1)*35;
            break;
        case 3:
            x = x - ((arc4random() % 4)+1)*35;
            break;
        case 4:
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
    [self barbarianMoveTo:x :y];
}

-(void)barbarianMoveTo:(int)x:(int)y
{
    float speed = [self getTimeToTravelPoint:ccp(x, y) fromPoint:self.position speed:movementspeed];
    
    id actionMove = [CCMoveTo actionWithDuration:speed position:ccp(x, y)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(barbarianMoveFinished:)];
    [self runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}

-(void)update:(ccTime)dt
{
    //[label setPosition:spriteObj.position];
    NSString *andre = [[NSNumber numberWithFloat:self.position.x] stringValue];
    
    label.string = andre;
    
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
