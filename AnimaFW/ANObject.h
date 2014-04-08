//
//  ANObject.h
//  ObjectPainter
//
//  Created by Jongwoo Moon on 11. 12. 27..
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

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import "DefineStates.h"
#import "NSObject+Util.h"

/*

#import "UIColor+Util.h"
#import "NSArray+Util.h"
#import "NSMutableArray+Util.h"
#import "NSMutableDictionary+Util.h"


*/

//////////////////////////////////////////////////////////////////////        [ ANObject ]
@interface ANObject : NSObject
//////////////////////////////////////////////////////////////////////////////////////////

{
    NSString *mstName, *mstMode;
    
    bool mblShow, mblAnimaFinished, mblRandom; // 랜덤 모드.. 
    float mgoLineWidth, mgoSizeStand;
    float mgoWidth, mgoHeight; // 프레임 폭/높이.. 별 상관 없음. 
    CAShapeLayer* mlaSuper;  
    CAShapeLayer * mlaBase;  // position 은 항상 움직임..  건들면 좌표가 뛰어감...
    CGPoint mpoPosition;
    CGPoint mpoTarget;  // 아니마의 최종값 설정...
    
    CGMutablePathRef manPath;
    CABasicAnimation *manAnima; // 외부에서 지정한 아니마. 

    NSTimer* mtmTimer;
    int mitStep; // 이동 시 최대 값..
    int mitType; 
    int muiTouchNum; // Touch Serial Number
    float muiTouchPos[TOUCH_COORD_NUM][2];
    
    NSMutableArray *arrTouchPoints, *arrPoints; // 단순화 된 점.
     
    UIView* muiView;
}
//////////////////////////////////////////////////////////////////////////////////////////
# pragma mark - property  #### Don't forget to ADD synthesize ####

@property (nonatomic, retain) NSMutableArray *arrTouchPoints, *arrPoints;

@property (strong) NSString *mstName, *mstMode;
@property (assign) bool mblRandom, mblShow, mblAnimaFinished;

@property (assign) CGMutablePathRef manPath;
@property (assign) int mitStep, muiTouchNum, mitType;
@property (assign) float mgoLineWidth, mgoSizeStand, mgoWidth, mgoHeight;
//@property (nonatomic, assign) float *muiTouchPos;
@property (assign) CGPoint mpoTarget, mpoPosition;

@property (strong) CAShapeLayer *mlaBase, *mlaSuper;
@property (strong) NSTimer* mtmTimer;
@property (strong) CABasicAnimation *manAnima;

@property (strong) UIView *muiView;

// initialize & dealloc related.
- (id)init;
- (id)initWithSuperLayer:(id)pSuperLay;
- (id)initWithPosition:(CGPoint)pCurPo andSuperLayer:(id)pSuperLayer;

-(void)stopTimers;
-(void)removeAllAnimationsTimers;

-(void)putAt:(CGPoint)pPosition nSuperLa:(CAShapeLayer*)pSuper;
-(void)showMyselfAt:(CGPoint)pPo ;
-(void)hideMyself;


// Basic Get/Set Methods
-(float)getCurX;
-(float)getCurY;
-(CGPoint)getCenterObj;

-(void)setTargetWithX:(float)pNewX andY:(float)pNewY;

// Util
-(void)drawPointAt:(CGPoint)point withColor:(CGColorRef)pColor nSize:(float)pSize;




-(void)stopAllAnima;
-(void)restartAllAnima;
-(void)freeze;
// Timer Methods




// Bezier related
-(void)setRandomBezierStartsAt:(CGPoint)pSta endsAt:(CGPoint)pEnd;
// manPath를 세팅함..


@end


//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////        [ ANObject ]
