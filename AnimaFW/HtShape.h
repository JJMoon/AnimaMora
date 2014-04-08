//
//  HtShape.h
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 10..
////  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mht : hansoo term   mui : UI            mst : state         mtm : Thread/tiMer  
//  mit : integer       mfo : float         mbl : bool          mgo : geometry
//  arr : array         dic : dictionary    mla : Layer         man : ANima         
//  mdd : distance      mpo : point         mcl : color         mpa : path
//  mgn : generateObj   mtp : tempObj       moj : object        mng : manageObj     
//

#import "ANBeziers.h"

@interface HtShape : ANObject
{
    int mitKind; // 0:Heart 1:Diamond 2:Spade 3:Clover
    
    ANBeziers *mgoBG, *mgoDeco;
    
    
    
}
//////////////////////////////////////////////////////////////////////////////////////////
# pragma mark - property  #### Don't forget to ADD synthesize ####

@property (nonatomic, retain) ANBeziers *mgoBG, *mgoDeco;


// initialize & dealloc related.
-(id)init;
-(id)initWithPosition:(CGPoint)pCurPo andSize:(float)pSize andSuperLayer:(id)pSuperLayer;
-(CGPoint)randomPosition:(CGPoint)pTarget;

-(void)putAt:(CGPoint)pPosition nSuperLa:(CAShapeLayer *)pSuper;

// draw Shapes
-(void)drawHeart;



@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////         [ HtShape ]