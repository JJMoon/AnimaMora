//
//  HtSnow.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 11. 12. 26..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mit : integer       mfo : float         mbl : bool      mgo : geometry
//  arr : array         dic : dictionary    mst : state
//  mdd : distance      man : ANima         mla : Layer     
//  mht : hansoo term   mgn : generator
//  AN : Anima          HT : HT Object      GN : Generator  MG : Manager
//

#import "HtSnow.h"
#import "UIColor+Util.h"
#import "NSObject+Util.h"
#import "CALayer+Util.h"
#import "ANObject+Anima.h"


//////////////////////////////////////////////////////////////////////        [ ?? ]
# pragma mark - ?? Implementation   Private methods

@interface HtSnow ()
{
@private
    ;
}

-(void)initialHtSnow;


@end


//////////////////////////////////////////////////////////////////////          [ HtSnow ]
@implementation HtSnow
//////////////////////////////////////////////////////////////////////////////////////////

//@synthesize mitCnt;
//@synthesize mflTargetX, mflTargetY;
//////////////////////////////////////////////////////////////////////          [ HtSnow ]
#pragma mark - 생성자, 소멸자.

-(id) init
{
    [self logMethodMark:@"HtSnow#init" andComment:@" .." isStart:YES];
    self = [super init];
    
    [self initialHtSnow];
    
//    [self logMethodMark:@"HtSnow#init" andComment:@" .." isStart:NO];
    return self;
}



-(void) dealloc
{
//    [self logMethodMark:@"HtSnow#dealloc" andComment:@" .." isStart:YES];
    
    //if (mcaLayer) [mcaLayer release];
//    [self logMethodMark:@"HtSnow#dealloc" andComment:@" .. " isStart:NO];
}


-(void)initialHtSnow // *** PRIVATE ***
{
    mgoWidth = mgoHeight = [self getAround:30 anySign:NO];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
 
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
} 

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

-(void)touchProcess:(CGPoint)pPosition nSuperView:(UIView *)pView
{
    [self putAt:pPosition nSuperLa:(CAShapeLayer*)pView.layer];
    [self animaRotationSnow];
    //////////////////////////////////////////////////  Falling Anima
    CGPoint endPo = CGPointMake([self getAround:1800 anySign:NO], 
                                [self getAround:1000 anySign:NO]);
    [self animaFallingSnowFrom:pPosition endsAt:endPo];
}

//////////////////////////////////////////////////////////////////////          [ HtSnow ]
-(void)putAt:(CGPoint)pPosition nSuperLa:(CAShapeLayer *)pSuper
{
    [super putAt:pPosition nSuperLa:pSuper];
    mpoTarget = pPosition;
    [self drawFlake];
}


//////////////////////////////////////////////////////////////////////          [ HtSnow ]
#pragma mark - Delegation 

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //[self logMethodMark:@"HtSnow#animationDidStop:finished" andComment:@"" isStart:YES];
    
    // 어떤 아니마든 멈추면 사라지게 함...
    
    mblShow = NO; // 앞으로 언제고 삭제될 운명....
    
    [self removeAllAnimationsTimers];
    return;
    
}


//////////////////////////////////////////////////////////////////////          [ HtSnow ]
#pragma mark - 그리기.. 관련. 

-(void)drawFlake
{
//    [self logMethodMark:@"HtSnow#drawFlake" andComment:@" .. " isStart:YES];
    UIColor *myColor = [self getBrightColorOverIn255:150];
    UIColor *haloCol = [myColor brighterColor]; // [self brighterColor:myColor];
    CGPoint superCen = CGPointMake(mlaBase.frame.size.width/2, mlaBase.frame.size.height/2);
    float len = mlaBase.frame.size.width * 0.8;
    float haloD = len*0.3;
    for (int i=0; i<3; i++) {
        CALayer *halo   = [CALayer layer];
        halo.bounds = CGRectMake(0, 0, len*0.2+haloD, len+haloD);
        halo.anchorPoint = CGPointMake(0.5, 0.5);
        halo.position = superCen;
        halo.cornerRadius = haloD*0.5;
        halo.backgroundColor = haloCol.CGColor;
        [halo setValue:[NSNumber numberWithInt: M_PI/3 * i] forKeyPath:@"transform.rotation.z"];
        [mlaBase addSublayer:halo];
    }
    for (int i=0; i<3; i++)
    {
        CALayer *aLayer = [CALayer layer];
        //mlaBase.borderColor = [self randomNewColor].CGColor; //[UIColor redColor].CGColor;
        //mlaBase.borderWidth = ;
        aLayer.bounds = CGRectMake(0, 0, len*0.2, len);
        aLayer.anchorPoint = CGPointMake(0.5, 0.5); 
        aLayer.position = superCen;
        aLayer.cornerRadius = len*0.1;
        aLayer.backgroundColor = myColor.CGColor;
        [aLayer setValue:[NSNumber numberWithInt: M_PI/3 * i] forKeyPath:@"transform.rotation.z"];
        [mlaBase addSublayer:aLayer]; // layer 추가.
    }
}



@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////          [ HtSnow ]