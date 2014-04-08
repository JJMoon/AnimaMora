//
//  HtGlasses.h
//  ObjectPainter
//
//  Created by Ryan Moon on 12. 1. 30..
////  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mht : hansoo term   mui : UI            mst : state         mtm : Thread/tiMer  
//  mit : integer       mfo : float         mbl : bool          mgo : geometry
//  arr : array         dic : dictionary    mla : Layer         man : ANima         
//  mdd : distance      mpo : point         mcl : color         mpa : path
//  mgn : generateObj   mtp : tempObj       moj : object        mng : manageObj     
//

@class ANBeziers;
#import "ANObject.h"

@interface HtGlasses : ANObject
{
    CGPoint mgoInitPo1, mgoInitPo2;
    CGPoint mgoFinlPo1, mgoFinlPo2;
    
    ANBeziers *mgoLeft, *mgoRigt;
    
}

//////////////////////////////////////////////////////////////////////       [ HtGlasses ]
# pragma mark - property

@property (assign) CGPoint mgoInitPo1, mgoInitPo2, mgoFinlPo1, mgoFinlPo2;
@property (nonatomic, retain) ANBeziers *mgoLeft, *mgoRigt;


-(id)initWithInitPoint:(CGPoint)pPo1 andPoint:(CGPoint)pPo2 andSuperLayer:(id)pSuperLayer;

-(void)drawUIGlasses:(CGPoint)pPo1 andPoint:(CGPoint)pPo2;

-(void)fixPositionAndStartAnimations;

// Anima
-(void)animaLineWidthFromV:(float)pFromThk toV:(float)pToThk forKey:(NSString*)pKey
                   howMany:(int)pNum duration:(float)pDuration autoReverse:(bool)pAutoReverse;

-(void)animaFrameColorFrom:(id)pFrom toV:(id)pTo forKey:(NSString*)pKey
                   howMany:(int)pNum duration:(float)pDuration autoReverse:(bool)pAutoReverse;


@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////       [ HtGlasses ]
