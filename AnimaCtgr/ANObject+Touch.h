//
//  ANObject+Touch.h
//  AnimaPainter
//
//  Created by James Moon on 12. 3. 26..
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

///////////////////////////////////////////////////////////////////   [ ANObject + Touch ]
@interface ANObject (Touch)
//////////////////////////////////////////////////////////////////////////////////////////

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

-(void)touchProcess:(CGPoint)pPosition nSuperView:(UIView*)pView;

-(id)touchProcessWithObject:(ANObject*)pTObject wOption:(id)pOption;
// 터치 정보를 갖는 TObject 를 받아서 후속 작업 처리. Child 객체에서 주로 수행. ... 추상 함수??

-(void)pointSimplify:(float)pLimitDist;

@end


//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
///////////////////////////////////////////////////////////////////   [ ANObject + Touch ]
