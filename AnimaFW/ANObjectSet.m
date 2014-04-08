//
//  ANObjectSet.m
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

#import "ANObjectSet.h"
#import "ANThickline.h"
#import "HtSimpleHair.h"
#import "HtSnow.h"
#import "HtGlasses.h"
#import "HtShape.h"


//////////////////////////////////////////////////////////////////////     [ ANObjectSet ]
@implementation ANObjectSet
//////////////////////////////////////////////////////////////////////////////////////////

@synthesize mojGenerate, mojDisplay, mojTemp, muiGenObj, muiTmpObj, muiDspObj;
//@synthesize muiObjType;

-(id)initWithGenClass:(Class)pGenClass typeOf:(int)pGenType
           displayCls:(Class)pDisplay typeOf:(int)pDisType
             tmpClass:(Class)pTemp typeOf:(int)pTmpType view:(UIView *)pView
{
    self = [super init];
    
    //muiObjType = pType; 
    muiTmpObj = pTemp;
    muiGenObj = pGenClass;
    muiDspObj = pDisplay;
    
    if (pGenClass) {
        mojGenerate = [[pGenClass alloc] init];
        mojGenerate.mitType = pGenType;
    }
    if (pDisplay) {
        mojDisplay = [[pDisplay alloc] init];
        mojDisplay.mitType = pDisType;
    }
    if (pTemp) {
        mojTemp = [[pTemp alloc] init];
        mojTemp.mitType = pTmpType;
    }

    [mojGenerate setMuiView:pView];
    [mojDisplay setMuiView:pView];
    [mojTemp setMuiView:pView];
    muiView = pView;
    
    return self;
}

/*
-(NSString*)getObject
{
    NSString* rStr;
    rStr = [self getStringAt:0 divider:@"#" inString:muiObjType];
    return rStr;    
}

-(NSString*)getMode
{
    NSString* rStr;
    rStr = [self getStringAt:1 divider:@"#" inString:muiObjType];
    return rStr;
}
*/

-(id)newTempObj
{
    if (self.muiTmpObj == nil) return nil;
    
    Class tmpClass = self.muiTmpObj;
    ANObject *newObj = [[tmpClass alloc] init];
    newObj.mitType = mojTemp.mitType;
    return newObj;
}



@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////     [ ANObjectSet ]
