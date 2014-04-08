//
//  HtShape.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 10..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mit : integer       mfo : float         mbl : bool      mgo : geometry
//  arr : array         dic : dictionary    mst : state
//  mdd : distance      man : ANima         mla : Layer     
//  mht : hansoo term   mgn : generator
//  AN : Anima          HT : HT Object      GN : Generator  MG : Manager
//


#import "HtShape.h"
#import "DefineStates.h"
#import <GLKit/GLKMath.h>
#import "UIColor+Util.h"
#import "NSObject+Util.h"
#import "NSObject+Geometry.h"
#import "ANBeziers.h"
#import "ANBeziers+Geometry.h"



//////////////////////////////////////////////////////////////////////////////////////////
# pragma mark - ANObject Implementation   Private methods
@interface HtShape ()
{
@private
    ;
}

-(void)initialHtShape;

@end

//////////////////////////////////////////////////////////////////////////////////////////
@implementation HtShape
//////////////////////////////////////////////////////////////////////////////////////////

@synthesize mgoBG, mgoDeco;

//////////////////////////////////////////////////////////////////////         [ HtShape ]
#pragma mark - 생성자, 소멸자. 
-(id)init
{
    self = [super init];
    
    mgoSizeStand = 50;
    
    [self initialHtShape];
    return self;
}

-(void)dealloc
{    
}


-(void)initialHtShape // *** PRIVATE ***
{
    mgoBG = nil; // 생성은 drawHeart, .. 에서.
    mgoDeco = nil;
    mgoWidth = mgoHeight = [self getAround:50 anySign:NO];
    mblRandom = NO; // 기본은 랜덤 없이. ...
}


-(void)removeAllAnimationsTimers
{
    if (mgoBG) [mgoBG removeAllAnimationsTimers];
    if (mgoDeco) [mgoDeco removeAllAnimationsTimers];
    [super removeAllAnimationsTimers];
}



//////////////////////////////////////////////////////////////////////         [ HtShape ]
-(void)putAt:(CGPoint)pPosition nSuperLa:(CAShapeLayer *)pSuper
{
    [super putAt:pPosition nSuperLa:pSuper];
    
    mpoTarget = pPosition;    
    mlaBase.lineWidth = 0.;
    mlaBase.backgroundColor = [UIColor clearColor].CGColor; // 배경색...
    mlaBase.opacity = 0.9; // 투명도.
    mlaBase.position = mpoPosition;

    [self drawHeart];
}


-(id)initWithPosition:(CGPoint)pCurPo andSize:(float)pSize andSuperLayer:(id)pSuperLayer
{
    [self logMethodMark:@"HtShape#initWithPosition" andComment:@".." isStart:YES];
    self = [super initWithPosition:pCurPo andSuperLayer:pSuperLayer];
    mgoSizeStand = pSize;
    [self initialHtShape];

    // 프레임 정보.
    mlaBase.frame = CGRectMake(0, 0, mgoSizeStand, mgoSizeStand); // 원점은 왼쪽 위. 
    mlaBase.bounds =CGRectMake(0, 0, mgoSizeStand, mgoSizeStand); 
    // 지정 안하면 중심이 원점. 원점은 왼쪽 위.
    mlaBase.anchorPoint = CGPointMake(0.5, 0.5); 
    mlaBase.lineWidth = 0.;
    
    mlaBase.backgroundColor = [UIColor clearColor].CGColor; // 배경색...
    mlaBase.opacity = 0.9; // 투명도.
    mlaBase.position = mpoPosition;
    
    
    [self drawHeart];
    
    [mgoBG startBasicPathAnima];  // 아니마 추가..

    //[mlaSuper addSublayer:mlaBase ]; // layer 추가.  ANObject 에서 추가..
    
    //NSArray *tempArr = [mlaSuper sublayers];
    

    [self logMethodMark:@"HtShape#initWithPosition" andComment:@".." isStart:NO];    
    return self;
}


-(CGPoint)randomPosition:(CGPoint)pTarget
{
    float delX = [self getAround:(mgoSizeStand * 0.07) anySign:YES], 
    delY = [self getAround:(mgoSizeStand * 0.07) anySign:YES];
    return CGPointMake(pTarget.x + delX, pTarget.y + delY);
}



//////////////////////////////////////////////////////////////////////          [ HtSnow ]
#pragma mark - Delegation 

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self logMethodMark:@"HtShape#animationDidStop" andComment:@"" isStart:YES];

    mblShow = NO; // 앞으로 언제고 삭제될 운명....
    
    if (mgoBG) [mgoBG removeAllAnimationsTimers];
    if (mgoDeco) [mgoDeco removeAllAnimationsTimers];
    
    [self removeAllAnimationsTimers];
    [self logMethodMark:@"HtShape#animationDidStop" andComment:@"" isStart:NO];
    return;
}



-(void)drawHeart
{
    CGPoint midPo, sPo, ePo, staCpo, endCpo, aniSpo, aniEpo, aniSpoCtrl, aniEpoCtrl;
    midPo = CGPointMake(mgoSizeStand/2, mgoSizeStand/2);
    float quater = mgoSizeStand/4, half = mgoSizeStand/2, del=mgoSizeStand*0.1;

    // 도형 그리기...
    if ( mitType == HEART_DEVIL) {
        mblRandom = YES;
    } else if ( mitType == HEART_BUTTERFLY ) {
        ; // ###
    }

    // 출발점..
    sPo = CGPointMake(half, half-quater);    ePo = CGPointMake(half*2, half-quater);
    staCpo = CGPointMake(half, 0.); endCpo = CGPointMake(half*2, 0.);
    
    float aniYroot = sPo.y - del, aniYctrl =  -0.1*quater ;
    aniSpo = CGPointMake(half, aniYroot);
    aniEpo = CGPointMake(half*2.1,  aniYroot);
    aniSpoCtrl = CGPointMake(half, aniYctrl);
    aniEpoCtrl = CGPointMake(half*2.1, aniYctrl);
    
    if (mblRandom) {
        sPo = [self randomPosition:sPo]; ePo = [self randomPosition:ePo];
        staCpo = [self randomPosition:sPo]; staCpo = [self randomPosition:ePo];
        aniSpo = [self randomPosition:aniSpo]; aniEpo = [self randomPosition:aniEpo];
        aniEpoCtrl = [self randomPosition:aniEpoCtrl]; aniEpoCtrl = [self randomPosition:aniEpoCtrl];
    }
    // 베지어 객체 생성..
    mgoBG = [[ANBeziers alloc] initWithBezierStartPo:sPo nSuperLa:mlaBase // 시작점 세팅
                                              nWidth:mgoSizeStand nHeight:mgoSizeStand];
    
    mgoBG.mlaBase.fillColor = [UIColor getRedishColorDarkness:0.9 nAlpha:1.0].CGColor;
    //mgoBG.mlaBase.fillColor = [UIColor yellowColor].CGColor;

    [mgoBG setStaPathAni:aniSpo]; // 시작점 세팅
    
    // First Bezier 위의 봉긋한 부분..
    [mgoBG addCurveTo:mgoBG.manPath withStaCtrl:staCpo 
           andEndCtrl:endCpo andEndPo:ePo isAnima:NO isVect:NO];
    [mgoBG addCurveTo:mgoBG.manPathAni withStaCtrl:aniSpoCtrl 
           andEndCtrl:aniEpoCtrl andEndPo:aniEpo isAnima:YES isVect:NO];
    
    // Second Bezier 아래까지 내려가는 부분..
    staCpo = CGPointMake(mgoSizeStand, half); endCpo = CGPointMake(half+quater, half+quater);
    ePo = CGPointMake(half, mgoSizeStand*0.9);
    
    aniSpoCtrl = CGPointMake(half*2.2, half*1.1);
    aniEpoCtrl = CGPointMake(half+quater+del, half+quater+del);
    aniEpo = CGPointMake(half, mgoSizeStand);

    [mgoBG addCurveTo:mgoBG.manPath withStaCtrl:staCpo
           andEndCtrl:endCpo andEndPo:ePo isAnima:NO isVect:NO];
    [mgoBG addCurveTo:mgoBG.manPathAni withStaCtrl:aniSpoCtrl 
           andEndCtrl:aniEpoCtrl andEndPo:aniEpo isAnima:YES isVect:NO];
    
    // Symmetry..
    [mgoBG mirrorPath]; // manPath, manPathAni 모두 대칭 복사. 
    // Close
    [mgoBG closePath];
}



@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////         [ HtShape ]