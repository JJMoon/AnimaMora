//
//  HtSnow.h
//  ObjectPainter
//
//  Created by Jongwoo Moon on 11. 12. 26..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  NSObject Category
//
//  mht : hansoo term   mui : UI            mst : state         mtm : Thread/tiMer  
//  mit : integer       mfo : float         mbl : bool          mgo : geometry
//  arr : array         dic : dictionary    mla : Layer         man : ANima         
//  mdd : distance      mpo : point         mcl : color         mpa : path
//  mgn : generateObj   mtp : tempObj       moj : object        mng : manageObj     
//

#import <Foundation/Foundation.h>

#import "ANObject.h"

@interface HtSnow : ANObject
{

}

//////////////////////////////////////////////////////////////////////          [ HtSnow ]
# pragma mark - property

-(id) init;
-(void)putAt:(CGPoint)pPosition nSuperLa:(CAShapeLayer *)pSuper;
-(void)drawFlake;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

-(void)touchProcess:(CGPoint)pPosition nSuperView:(UIView *)pView;

@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////          [ HtSnow ]