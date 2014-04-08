//
//  ANOption.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 19..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mit : integer       mfo : float         mbl : bool      mgo : geometry
//  arr : array         dic : dictionary    mst : state
//  mdd : distance      man : ANima         mla : Layer     
//  mht : hansoo term   mgn : generator
//  AN : Anima          HT : HT Object      GN : Generator  MG : Manager
//


#import "ANOption.h"

//////////////////////////////////////////////////////////////////////        [ ANOption ]
@implementation ANOption
//////////////////////////////////////////////////////////////////////////////////////////

@synthesize mblIsItPAD;
@synthesize manTouchObj, manTouchMoveObj, manTouchEndObj;
@synthesize mfoMinDistance;
@synthesize mgScreenWidth, mgScreenHeight;


-(float)getBiggerLengthOfScreen
{
    if (mgScreenWidth > mgScreenHeight) return mgScreenWidth;
    return mgScreenHeight;
}

@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////        [ ANOption ]
