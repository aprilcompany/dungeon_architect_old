//
//  GameScene.m
//  dungeon_architect
//
//  Created by Christian May on 04.11.12.
//
//
//http://www.raywenderlich.com/1163/how-to-make-a-tile-based-game-with-cocos2d
//



// Import the interfaces
#import "GameScene.h"

// HelloWorld implementation
@implementation GameScene
@synthesize tileMap = _tileMap;
@synthesize background = _background;
@synthesize player = _player;


//http://stackoverflow.com/questions/538996/constants-in-objective-c
// Constants
NSString *const TILEMAP = @"tilemap.tmx";
NSString *const PLAYER = @"sage.gif";

int tilegid = 0;

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)setViewpointCenter:(CGPoint) position {
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    int x = MAX(position.x, winSize.width / 2);
    int y = MAX(position.y, winSize.height / 2);
    x = MIN(x, (_tileMap.mapSize.width * _tileMap.tileSize.width)
            - winSize.width / 2);
    y = MIN(y, (_tileMap.mapSize.height * _tileMap.tileSize.height)
            - winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    self.position = viewPoint;
    
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init] )) {
        
        self.isTouchEnabled = YES;
        self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:TILEMAP];
        self.background = [_tileMap layerNamed:@"Background"];
        
        //        CCTMXObjectGroup *objects = [_tileMap objectGroupNamed:@"Objects"];
        //        NSAssert(objects != nil, @"'Objects' object group not found");
        //        NSMutableDictionary *spawnPoint = [objects objectNamed:@"SpawnPoint"];
        //        NSAssert(spawnPoint != nil, @"SpawnPoint object not found");
        //        int x = [[spawnPoint valueForKey:@"x"] intValue];
        //        int y = [[spawnPoint valueForKey:@"y"] intValue];
        //
        
        int x =0;
        int y = 0;
        
        
        self.player = [CCSprite spriteWithFile:PLAYER];
        _player.position = ccp(x, y);
        [self addChild:_player];
        
        [self setViewpointCenter:_player.position];
        
        [self addChild:_tileMap z:-1];
        
    }
    return self;
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self
                                                     priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"ccTouchBegan");
       
	return YES;
}

-(void)setPlayerPosition:(CGPoint)position {
    _player.position = position;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"ccTouchEnded");
    
    CGPoint touchLocation = [self getNodeSpaceLocation:touch];
    
    CGPoint tilePos= [self tileCoordForPosition:touchLocation];    
    
    CCTMXLayer* backgroundLayer = [self.tileMap layerNamed:@"background"];
    
    
    CCLOG(@"%i", tilegid);
    [backgroundLayer setTileGID: 34 at: tilePos];
    tilegid++;
    
}

//berchnet die NodeSpace Position von einem UITouc Event. Der NodeSpace ist sozusagen die Ansicht, in die Cocos2d zeichnet. Diese Ansicht hat ein eigenes Koordinatensystem
-(CGPoint) getNodeSpaceLocation:(UITouch *)touch{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    return touchLocation;
}

// berechnet für die x,y Koordinaten 'position' die Tilenummer. Die Tiles sind mit (x,y) startend mit (0,0), (1,0), (2,0) von oben links im Bild startend durchnummeriert. Die Koordinaten x,y müssen vorher in den 'Nodespace' (das sind die Koordinaten der Cocos2d Ansicht) umberechent werden. 
- (CGPoint)tileCoordForPosition:(CGPoint)position {
    int x = position.x / _tileMap.tileSize.width;
    int y = ((_tileMap.mapSize.height * _tileMap.tileSize.height) - position.y) / _tileMap.tileSize.height;
    return ccp(x, y);
}

//TODO: man darf nicht ausserhalb der map zoomen, code von ccTouchedEnd nehmen, um das zu verhindern
//Methode ermöglicht das navigiere auf der karte indem man ein touch macht und die karte hin  und her zieht
-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    CCLOG(@"ccTouchMoved");
    
    CGPoint touchLocation = [touch locationInView: [touch view]];
    CGPoint prevLocation = [touch previousLocationInView: [touch view]];
    
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    prevLocation = [[CCDirector sharedDirector] convertToGL: prevLocation];
    
    CGPoint diff = ccpSub(touchLocation,prevLocation);    
    
    [self setPosition: ccpAdd([self position], diff)];

}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	self.tileMap = nil;
    self.background = nil;
    self.player = nil;
	[super dealloc];
}
@end
