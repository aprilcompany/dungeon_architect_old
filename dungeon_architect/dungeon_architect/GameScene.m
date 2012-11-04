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
// Constants.m
NSString *const TILEMAP = @"tilemap.tmx";

NSString *const PLAYER = @"sage.gif";



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
    
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    
    
    [self setPlayerPosition:touchLocation];
    
	return YES;
}

-(void)setPlayerPosition:(CGPoint)position {
    _player.position = position;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    CCLOG(@"ccTouchEnded");
    
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    
    
    //!!!!code kann man nutzen um tile
    //    CGPoint playerPos = _player.position;
//    CGPoint diff = ccpSub(touchLocation, playerPos);
//    if (abs(diff.x) > abs(diff.y)) {
//        if (diff.x > 0) {
//            playerPos.x += _tileMap.tileSize.width;
//        } else {
//            playerPos.x -= _tileMap.tileSize.width;
//        }
//    } else {
//        if (diff.y > 0) {
//            playerPos.y += _tileMap.tileSize.height;
//        } else {
//            playerPos.y -= _tileMap.tileSize.height;
//        }
//    }
    //player.position = playerPos; // Todo: Trymove
//    
//    if (playerPos.x <= (_tileMap.mapSize.width * _tileMap.tileSize.width) &&
//        playerPos.y <= (_tileMap.mapSize.height * _tileMap.tileSize.height) &&
//        playerPos.y >= 0 &&
//        playerPos.x >= 0 ) {
//        [self setPlayerPosition:playerPos];
//    }
//    
//    [self setViewpointCenter:_player.position];
    
    [self setPlayerPosition:touchLocation];
    
    
    CCTMXLayer* backgroundLayer = [self.tileMap layerNamed:@"background"];
    
    
    unsigned int gid1 = [backgroundLayer tileGIDAt:ccp(1,50)];
    
    unsigned int gid = [backgroundLayer tileGIDAt:ccp(10,50)];
    
    
    CCTMXLayer* layer = [self.tileMap layerNamed:@"Kachelebene 2"];
    
    //todo positiin touch auf kachel positionen mappen
    [backgroundLayer setTileGID: 4 at: ccp(10, 50)];
    
    
    
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
    [self setPlayerPosition:touchLocation];

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
