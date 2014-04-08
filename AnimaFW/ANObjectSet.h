//
//  ANObjectSet.h
//  ObjectPainter
//
//  Created by Ryan Moon on 12. 2. 3..
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


//////////////////////////////////////////////////////////////////////     [ ANObjectSet ]
@interface ANObjectSet : ANObject
//////////////////////////////////////////////////////////////////////////////////////////
{

}

@property (nonatomic, retain) ANObject *mojGenerate, *mojDisplay, *mojTemp;
@property (strong) Class muiGenObj, muiTmpObj, muiDspObj;
//@property (strong) NSString *muiObjType;  /// "Hair#Moderate"

-(id)initWithGenClass:(Class)pGenClass typeOf:(int)pGenType
           displayCls:(Class)pDisplay typeOf:(int)pDisType
             tmpClass:(Class)pTemp typeOf:(int)pTmpType view:(UIView *)pView;




-(id)newTempObj;
//  @"Hair#Moderate"  "Object # Mode # ?? "

//-(NSString*)getObject;
//-(NSString*)getMode;


@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////     [ ANObjectSet ]
