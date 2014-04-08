//
//  HtSimpleHair.h
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 25..
////  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  NSObject Category
//  mht : hansoo term   mui : UI            mst : state         mtm : Thread/tiMer  
//  mit : integer       mfo : float         mbl : bool          mgo : geometry
//  arr : array         dic : dictionary    mla : Layer         man : ANima         
//  mdd : distance      mpo : point         mcl : color         mpa : path
//  mgn : generateObj   mtp : tempObj       moj : object        mng : manageObj     
//


#import "ANBeziers.h"

@interface HtSimpleHair : ANBeziers
{
    float mgoHairWidth;
    
    
    
}

@property (assign) float mgoHairWidth;

// initialize & dealloc related.
-(id)initWithPoints:(NSMutableArray*)pointsArr nSuperLa:(CAShapeLayer *)pSuper 
           withMode:(float)pMode;





@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////    [ HtSimpleHair ]
