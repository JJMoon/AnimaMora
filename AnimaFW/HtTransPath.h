//
//  HtTransPath.h
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 12..
////  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mht : hansoo term   mui : UI            mst : state         mtm : Thread/tiMer  
//  mit : integer       mfo : float         mbl : bool          mgo : geometry
//  arr : array         dic : dictionary    mla : Layer         man : ANima         
//  mdd : distance      mpo : point         mcl : color         mpa : path
//  mgn : generateObj   mtp : tempObj       moj : object        mng : manageObj     
//

#import "ANBeziers.h"

//////////////////////////////////////////////////////////////////////////////////////////
@interface HtTransPath : ANBeziers
//........................................................................................
// Ht Object 의 멤버로 갖고 있슴.. 처음에 세팅한 후 새로운 CGPath를 계속 공급함..
// 이동 경로에 쓰이는 객체.. 스스로도 움직이면서 CGPath 객체를 리턴함..
{
    //CGMutablePathRef manPath, manPathAni; // 베지어 객체, 아니마 타겟 객체.

    // int mitType; // 0:S curve 1:arc 2:linear
    float mddLength; // ovall distance
    float mraDirect; // M_PI < 현재의 방향.  < - M_PI
    float mvlRotate; // 회전 각속도..
    
}

//////////////////////////////////////////////////////////////////////////////////////////
# pragma mark - property  #### Don't forget to ADD synthesize ####


@property (assign) float mddLength, mraDirect, mvlRotate;

//////////////////////////////////////////////////////////////////////////////////////////
# pragma mark - public methods

// initialize & dealloc related.
-(id)init;
-(id)initPathInitialDirection:(float)pInitAngle nRotateDelta:(float)pvlRotate
                      nLength:(float)pddLength 
                        staPo:(CGPoint)pStaPo endPo:(CGPoint)pEndPo
                    staCtrlPo:(CGPoint)pStaCtr endCtrlPo:(CGPoint)pEndCtr;
//-(void)stopTimers;


// CGPath 공급 메소드.
-(CGPathRef)getCurrentPath;

@end
//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890