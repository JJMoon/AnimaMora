//
//  MNObject.h
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
//  mgc : graphic rel.  
//  updated @ : 2012. 3. 21.
//



@class ANOption;
@class ANObjectSet;
@class MNPencil;
@class MNPaintView;

#import "DefineStates.h"
#import "ANObject.h"


//////////////////////////////////////////////////////////////////////        [ MNObject ]
@interface MNObject : ANObject
//////////////////////////////////////////////////////////////////////////////////////////
{
    ANOption *mOption;

    uint64_t mitCounter; // 타이머의 카운트.
    float mflBaseSize; // 크기의 기준.
    MNPaintView *muiPallete; // 그리는 판..

}

@property (assign) ANOption *mOption;
@property (assign) uint64_t mitCounter;
@property (assign) float mflBaseSize;

@property (strong) NSMutableDictionary *dicObjects; // 객체 총괄 Dictionary
@property (strong) NSArray *arrObjSet;  // 세트 어레이.
@property (strong) ANObjectSet *muiCurObjSet; // 현재 진행중인 객체 세트.
@property (strong) ANObject *manCornerObj, *manUIObj; // 코너, 안경 임시 그리기.
@property (nonatomic, retain) MNPaintView *muiPallete;

// initialize & dealloc related.
- (id)initWithView:(UIView*)pView nOption:(ANOption*)pOption;

// Timer / Lock Related
@property (strong) NSLock *mstLock;
-(void)timerStop;
-(void)timerFireMethod:(NSTimer*)pTimer;

// UI/UX
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEndedMN:(NSSet *)touches withEvent:(UIEvent *)event;

// Animations
-(void)performSelector4ObjectsInDisplay:(SEL)aSelector;



@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////        [ MNObject ]