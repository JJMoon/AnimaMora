//
//  ANOption.h
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


#import "ANObject.h"

@interface ANOption : ANObject
{
    float mgScreenWidth, mgScreenHeight;
    bool mblIsItPAD;
    Class manTouchObj; // 터치하면 생기는 객체.
    Class manTouchMoveObj; 
    Class manTouchEndObj; // 터치 끝나고 처리해야할 객체.
}

@property (assign) bool mblIsItPAD;
@property (assign) Class manTouchObj, manTouchMoveObj, manTouchEndObj;
@property (assign) float mfoMinDistance; // 너무 촘촘하지 않게. 


// 화면 사이즈 
@property (assign) float mgScreenWidth, mgScreenHeight;

-(float)getBiggerLengthOfScreen;

@end




//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////        [ ANOption ]
