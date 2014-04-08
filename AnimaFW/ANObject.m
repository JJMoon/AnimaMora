//
//  ANObject.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 11. 12. 27..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mht : hansoo term   mui : UI            mst : state         mtm : Thread/tiMer  
//  mit : integer       mfo : float         mbl : bool          mgo : geometry
//  arr : array         dic : dictionary    mla : Layer         man : ANima         
//  mdd : distance      mpo : point         mcl : color         mpa : path
//  mgn : generateObj   mtp : tempObj       moj : object        mng : manageObj     
//  mgc : graphic rel.  
//  updated @ : 2012. 3. 21.
//


#import "ANObject.h"

#import "DefineStates.h"
#import "CALayer+Util.h"
#import "NSObject+Geometry.h"

//////////////////////////////////////////////////////////////////////        [ ANObject ]
# pragma mark - ANObject Implementation   Private methods
@interface ANObject ()
{
@private
    ;
}

-(void)initial___ANObject;

@end



# pragma mark - ANObject Implementation 
//////////////////////////////////////////////////////////////////////        [ ANObject ]
@implementation ANObject
//////////////////////////////////////////////////////////////////////////////////////////

@synthesize mstName, mstMode, mblRandom, mblShow, mblAnimaFinished, manAnima, manPath;
@synthesize mlaBase, mlaSuper, mitStep, mgoLineWidth, mgoSizeStand;
@synthesize mpoTarget, mpoPosition, mtmTimer, mitType;
@synthesize mgoWidth, mgoHeight, muiTouchNum;

@synthesize arrTouchPoints, arrPoints;

@synthesize  muiView;

//////////////////////////////////////////////////////////////////////        [ ANObject ]
#pragma mark - 생성자, 소멸자.

-(id)init
{
    self = [super init];
//    [self logMethodMark:@"ANObject#init" andComment:@" .." isStart:YES];

    [self initial___ANObject];
//    [self logMethodMark:@"ANObject#init" andComment:@" .." isStart:NO];
    return self;
}

-(id)initWithSuperLayer:(id)pSuperLay
{
    self = [super init];
    mlaSuper = pSuperLay;
    [self initial___ANObject];
    return self;
}


-(void)dealloc
{
    [self logMethodMark:@"ANObject#dealloc" andComment:@" .." isStart:YES];

    CFRelease(manPath);
    if (mlaBase) {
        [mlaBase removeAllAnimations];
        [mlaBase removeChildren]; // Layer, Anima 모두 삭제...
        mlaBase = nil;
    }
    

//    [self logMethodMark:@"ANObject#dealloc" andComment:@" .." isStart:NO];
}


-(void)removeAllAnimationsTimers
{
    [self stopTimers];
    [mlaBase zapAnimaSublayer];
    mlaBase = nil;
}



-(void)initial___ANObject  // *** PRIVATE ***
{
    mblShow = YES;
    mblAnimaFinished = false;
    mblRandom = NO;
    mlaBase = [CAShapeLayer layer];
    manPath = CGPathCreateMutable();

    mitStep = 100;
    mtmTimer = nil;
    // Super Layer 를 아직 모름... put 할때 지정...
}


- (id)initWithPosition:(CGPoint)pCurPo andSuperLayer:(id)pSuperLayer
{
    self = [super init];
    [self initial___ANObject];
    
    mpoPosition = pCurPo;
    mlaSuper = pSuperLayer;
    //[mlaSuper addSublayer:mlaBase ]; // layer 추가.
    
    return self;
}

-(void)putAt:(CGPoint)pPosition nSuperLa:(CAShapeLayer *)pSuper
{
    mlaSuper = pSuper;
    
    mlaBase.frame = CGRectMake(0, 0, mgoWidth, mgoHeight);
    mlaBase.bounds= CGRectMake(0, 0, mgoWidth, mgoHeight);
    mlaBase.anchorPoint = CGPointMake(0.5, 0.5); 
	mlaBase.position = pPosition;

    if (mlaSuper) {
        [mlaSuper addSublayer:mlaBase ]; // layer 추가.
    }
}

-(void)showMyselfAt:(CGPoint)pPo
{
    
    
}

-(void)hideMyself
{
    
    
}



-(CGPoint)getCenterObj
{
    return mpoTarget;
}



//////////////////////////////////////////////////////////////////////        [ ANObject ]
#pragma mark - Timer.

-(void)stopTimers
{
    if (mtmTimer) {
        [mtmTimer invalidate];
        //mnsTimer = nil;
    }
    
}



-(float)getStep
{
    float rV;
    // 60 % above...
    int v60 = (int)(0.6 * mitStep);
    rV = (float) [self randomIntFrom:v60 To:mitStep];
    return rV;
}

-(void)setTargetWithX:(float)pNewX andY:(float)pNewY
{
//    NSLog(@"setNewPositionX X: %f, Y: %f", pNewX, pNewY);
    mpoTarget = CGPointMake(pNewX, pNewY);
}

-(float)getCurX { return mlaBase.position.x; }
-(float)getCurY { return mlaBase.position.y; }

    
//////////////////////////////////////////////////////////////////////        [ ANObject ]
#pragma mark - Utilities :: Debuging tools

-(void)drawPointAt:(CGPoint)point withColor:(CGColorRef)pColor nSize:(float)pSize
{
    CALayer * aLay = [CALayer layer];
    aLay.backgroundColor = pColor;
    aLay.bounds = CGRectMake(0, 0, pSize, pSize);
    aLay.cornerRadius = pSize * 0.5;
    aLay.position = point;
    [mlaBase addSublayer:aLay];
}

-(void)stopAllAnima
{
    [self freeze];
    ///[mlaBase stopAnima];
}

-(void)restartAllAnima
{
    ///[mlaBase restartAnima];
}

-(void)freeze
{
    CALayer *present = [mlaBase presentationLayer];
    mlaBase.position = present.position;
}



//////////////////////////////////////////////////////////////////////        [ ANObject ]
#pragma mark - Bezier Related ** Only use manPath.

-(void)setRandomBezierStartsAt:(CGPoint)pSta endsAt:(CGPoint)pEnd
{
    float length = 0.2 * [self getDistanceBtw:pSta And:pEnd];
    float delx1 = [self getAround:length anySign:YES];
    float delx2 = [self getAround:length anySign:YES];
    float dely1 = [self getAround:length anySign:YES];
    float dely2 = [self getAround:length anySign:YES];
    // 컨트롤 포인트는 거리의 30% 정도의 편차로 한다..
    CGPathMoveToPoint(manPath, nil, pSta.x, pSta.y); // Start Point..
    
    CGPathAddCurveToPoint(manPath, nil, pSta.x+delx1, pSta.y+dely1,
                          pEnd.x+delx2, pEnd.y+dely2, pEnd.x, pEnd.y);
}




@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////        [ ANObject ]