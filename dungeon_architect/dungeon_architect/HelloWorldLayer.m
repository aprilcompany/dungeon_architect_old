//
//  HelloWorldLayer.m
//  dungeon_architect
//
//  Created by Christian May on 03.11.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

//http://www.reigndesign.com/blog/creating-a-simple-menu-with-scene-transition-in-cocos2d/
#import "GameScene.h"

// Barbarian-Klasse implementieren
#import "Barbarian.h"
#import "HumanPriest.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//-(void)spriteMoveFinished:(id)sender {
//    CCSprite *target = (CCSprite *)sender;
//    // Löschen einer Figure
//    ////[self removeChild:sprite cleanup:YES];
//    
//    // Setzen der Endposition der Bewegung der Figure
//    // Bewegung ist geradlinig, für Tile-Map von 35x35 Feldgröße
//    //// CGSize winSize = [[CCDirector sharedDirector] winSize];
//    //// int maxX = winSize.width;
//    //// int maxY = winSize.height;
//    float x = target.position.x;
//    float y = target.position.y;
//    
//    // Eine von 4 Bewegungsrichtungen für Tiles ermitteln
//    int direction = (arc4random() % 4)+1;
//    switch (direction) {
//        case 1:
//            x = x + ((arc4random() % 4)+1)*35;
//            break;
//        case 2:
//            y = y + ((arc4random() % 4)+1)*35;
//            break;
//        case 3:
//            x = x - ((arc4random() % 4)+1)*35;
//            break;
//        case 4:
//            y = y - ((arc4random() % 4)+1)*35;
//            break;
//        default:
//            y = y + ((arc4random() % 4)+1)*35;
//            break;
//    }
//    
//    // Determine speed of the target
//    int minDuration = 1.0;
//    int maxDuration = 4.0;
//    int rangeDuration = maxDuration - minDuration;
//    int actualDuration = (arc4random() % rangeDuration) + minDuration;
//    
//    
//    // Create the actions
//    id actionMove = [CCMoveTo actionWithDuration:actualDuration position:ccp(x, y)];
//    id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)];
//    [target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
//}

-(void)addFigure {
    // Zufallszahl erzeugen
    int randomInt;
    randomInt = (arc4random() % 2);
    
    // Bildgröße ermittlen
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    // Zufällig Figur erstellen
    switch (randomInt) {
        case 0:
            [Barbarian nodeWithTheGame:self location:ccp(size.width/2, size.height/2+50)];
            break;
        case 1:
            [HumanPriest nodeWithTheGame:self location:ccp(size.width/2, size.height/2+50)];
            break;
        default:
             [HumanPriest nodeWithTheGame:self location:ccp(size.width/2, size.height/2+50)];
            break;
    }

}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
        // ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Dungeon Architect Alpha" fontName:@"Marker Felt" fontSize:64];
		CCLabelTTF *vlabel = [CCLabelTTF labelWithString:@"a Andi and Chris Production" fontName:@"Marker Felt" fontSize:32];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		vlabel.position =  ccp( size.width /2 , size.height/3 );
        
        // add the label as a child to this Layer
		[self addChild: label];
        [self addChild: vlabel];
        
        // create Player
        CCSprite *player = [CCSprite spriteWithFile:@"openDoor0.gif" rect:CGRectMake(0, 0, 35, 35)];
        
        // position player on the screen
        player.position = ccp(size.width/2, size.height/2+50);
        
        // add player as a child to this layer
        [self addChild: player];
        
		
        
        // Erstellen einer Instanz der Klasse Barbarian
        [Barbarian nodeWithTheGame:self location:ccp(size.width/2, size.height/2+50)];
        [HumanPriest nodeWithTheGame:self location:ccp(size.width/2, size.height/2+50)];
        
		//
		// Leaderboards and Achievements
		//
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
		
		// Achievement Menu Item using blocks
        //		CCMenuItem *itemAchievement = [CCMenuItemFont itemWithString:@"Achievements" block:^(id sender) {
        //
        //
        //			GKAchievementViewController *achivementViewController = [[GKAchievementViewController alloc] init];
        //			achivementViewController.achievementDelegate = self;
        //
        //			AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
        //
        //			[[app navController] presentModalViewController:achivementViewController animated:YES];
        //
        //			[achivementViewController release];
        //		}
        //									   ];
        //
        //		// Leaderboard Menu Item using blocks
        //		CCMenuItem *itemLeaderboard = [CCMenuItemFont itemWithString:@"Leaderboard" block:^(id sender) {
        //
        //
        //			GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
        //			leaderboardViewController.leaderboardDelegate = self;
        //
        //			AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
        //
        //			[[app navController] presentModalViewController:leaderboardViewController animated:YES];
        //
        //			[leaderboardViewController release];
        //		}
        //									   ];
        //CCMenu *menu = [CCMenu menuWithItems:itemAchievement, itemLeaderboard, nil];
		
        
        //http://www.reigndesign.com/blog/creating-a-simple-menu-with-scene-transition-in-cocos2d/
        CCMenuItem *startGame = [CCMenuItemFont itemWithString:@"START"
                                                        target:self
                                                      selector:@selector(startGame:)
                                 ];        
        CCMenu *menu = [CCMenu menuWithItems:startGame, nil];
        
        
        
        [menu alignItemsHorizontallyWithPadding:20];
        [menu setPosition:ccp( size.width/2, size.height/2 - 50)];
        
        // Add the menu to the layer
        [self addChild:menu];
        
        // Add Schedule to add babarian
        [self schedule:@selector(gameLogic:) interval:3.0];
        
    }
    return self;
}


//http://www.reigndesign.com/blog/creating-a-simple-menu-with-scene-transition-in-cocos2d/
- (void) startGame: (id) sender
{
    CCLOG(@"startGame");
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]];
}

-(void)gameLogic:(ccTime)dt {
    [self addFigure];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    // in case you have something to dealloc, do it in this method
    // in this particular example nothing needs to be released.
    // cocos2d will automatically release all the children (Label)
    [Barbarian release];
    
    // don't forget to call "super dealloc"
    [super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [[app navController] dismissModalViewControllerAnimated:YES];
}
@end
