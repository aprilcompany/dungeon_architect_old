//
//  HumanPriest.h
//  dungeon_architect
//
//  Created by Andre May on 11/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HelloWorldLayer.h"

@interface HumanPriest : CCNode {
    // Variablen bezüglich der Bewegung
    int movementspeed;
    int movementrange;
    
    // Variablen bezüglich der Eigenschaften
    int constitution;
    int armor;
    int damage;
    
    CCSprite * mySprite;
    HelloWorldLayer * theGame;
}


@property (nonatomic,assign) HelloWorldLayer *theGame;
@property (nonatomic,assign) CCSprite *mySprite;


+(id)nodeWithTheGame:(HelloWorldLayer*)_game location:(CGPoint)location;
-(id)initWithTheGame:(HelloWorldLayer *)_game location:(CGPoint)location;


@end
