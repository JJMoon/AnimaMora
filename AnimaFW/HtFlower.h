//
//  Hansoo T???
//  HtSnow.h
//  ObjectPainter
//
//  Created by Jongwoo Moon on 11. 12. 26..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mht : hansoo term   mui : UI            mst : state         mtm : Thread/tiMer  
//  mit : integer       mfo : float         mbl : bool          mgo : geometry
//  arr : array         dic : dictionary    mla : Layer         man : ANima         
//  mdd : distance      mpo : point         mcl : color         mpa : path
//  mgn : generateObj   mtp : tempObj       moj : object        mng : manageObj     
//


#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "ANObject.h"
#import "ANBeziers.h"

@interface HtFlower: ANObject
{
    uint mitCnt;

    ANBeziers *manBeziers;
    //float mflTargetX, mflTargetY;
}

//////////////////////////////////////////////////////////////////////////////////////////
# pragma mark - property  #### Don't forget to ADD synthesize ####

@property (assign) uint mitCnt;
@property (nonatomic, retain) ANBeziers *manBeziers;
//@property (assign) float mflTargetX, mflTargetY;


-(id) init;
-(id) initWithCoordX:(float)pX andY:(float)pY andSuperLayer:(id)pSuperLayer;

// 다양한 꽃잎 구현
-(void)drawPetal;

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

-(void)animaTest;

-(void)drawPetal;
//-(BOOL)animationFinished;

@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////        [ HtFlower ]