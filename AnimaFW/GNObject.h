//
//  GNObject.h
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 6..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mht : hansoo term   mui : UI            mst : state         mtm : Thread/tiMer  
//  mit : integer       mfo : float         mbl : bool          mgo : geometry
//  arr : array         dic : dictionary    mla : Layer         man : ANima         
//  mdd : distance      mpo : point         mcl : color         mpa : path
//  mgn : generateObj   mtp : tempObj       moj : object        mng : manageObj     
//

#import "ANObject.h"
#import <GLKit/GLKMath.h>
#import "ANBeziers.h"


//////////////////////////////////////////////////////////////////////        [ GNObject ]
@interface GNObject : ANObject
//////////////////////////////////////////////////////////////////////////////////////////

{
    ANObject *mhtCurrent;
    
}

@property (nonatomic, retain) ANObject *mhtCurrent;

// initialize & dealloc related.
- (id)init;
- (id)initWithHtObject:(ANObject*)pObject;

// animation



@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////        [ GNObject ]