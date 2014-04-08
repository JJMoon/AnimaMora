//
//  DefineStates.h
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 2..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  NSObject Category
//  mht : hansoo term   mui : UI            mst : state         mtm : Thread/tiMer  
//  mit : integer       mfo : float         mbl : bool          mgo : geometry
//  arr : array         dic : dictionary    mla : Layer         man : ANima         
//  mdd : distance      mpo : point         mcl : color         mpa : path
//  mgn : generateObj   mtp : tempObj       moj : object        mng : manageObj     
//  mgc : graphic rel.  
//  updated @ : 2012. 3. 21.

#ifndef ObjectPainter_DefineStates_h
#define ObjectPainter_DefineStates_h


//#define LOG_STATE 0 // 0: 모두 프린트.. 1: 특정 함수만 프린트.

#define degreesToRadians(x) (M_PI * x / 180.0)
//#define P(x,y) CGPointMake(x, y)

#define TOUCH_COORD_NUM 15
#define CLEAR_COL [UIColor clearColor]
#define MAGENTA_COL [UIColor magentaColor]

enum { CONTROL_VECTER_SCALE, SPREADING_FROM_CENTER, PUMPING_OUTSIDE };
enum { PENCIL_ANM_NORMAL, PENCIL_ANM_STROKE, PENCIL_ANM_BOLD };
enum { HEART_DEVIL, HEART_BUTTERFLY };
enum { BEZIER_CURVE, BEZIER_ARC, BEZIER_LINE };
enum { HAIR_CRAZY, HAIR_MODERATE };
enum { TL_GRASS, TL_TOOTHPICK }; // Thick Line


bool gbooSpecial;

NSString *bEndMarkerString; // ">>. START .<<"

#define SMALL_FLOAT 0.0000000001


#endif

/*
self.prop1 = obj;     // obj 의 retain count 1 증가
self.prop1 = nil;      // obj 의 retain count 1 감소
prop1 = obj;           // 포인터 복사이며 retain count는 변화없음 (property setter가 호출되지 않음)
self.prop2 = obj;     // assign으로 설정된 프로퍼티이므로 변화없음
*/