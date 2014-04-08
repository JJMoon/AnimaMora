//
//  ANBeziers.h
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

#import "DefineStates.h"
#import "ANObject.h"
#import <GLKit/GLKMath.h>

//#import <QuartzCore/QuartzCore.h>

@interface ANBeziers : ANObject // : NSObject
{
    BOOL mblOpp;
    float mgoKval; // 베지어 단순화할 때 상수.. 0 ~ 1.0 ~ 5.. 
    float mgoTotalLength;
    CGPoint mgoFarthestPo;
    
    GLKVector3 mgoMainVector; // Start Po --> End Po..
    
    NSMutableArray *arrBezrs, *arrCtrls, *arrBezrAni, *arrCtrlAni; // Points, associating Control points..
    // 컨트롤 포인트는 벡터임.. 좌표 아님...
    
    CGMutablePathRef manPathAni; // 베지어 객체, 아니마 타겟 객체. manPath는 ANObject 에..
}
//////////////////////////////////////////////////////////////////////////////////////////
# pragma mark - property  #### Don't forget to ADD synthesize ####

@property (strong) NSMutableArray *arrBezrs, *arrCtrls, *arrBezrAni, *arrCtrlAni;
@property (assign) CGMutablePathRef manPathAni;
@property (assign) BOOL mblOpp; // Control point is opposite ?
@property (assign) GLKVector3 mgoMainVector;
@property (assign) CGPoint mgoFarthestPo;
@property (assign) float mgoKval, mgoTotalLength;

// 생성자..
-(id)init;
-(id)initWithBezierStartPo:(CGPoint)pSta nSuperLa:(id)pSuperLa 
                    nWidth:(float)pWidth nHeight:(float)pHeight;
// 어레이에 추가하려면 CGPoint가 필요하므로 그냥 그렇게 하는 게 좋겠다.
// bezier alloc] init] 한 후 기본 변수 세팅..
-(void)setBezierSuperLayer:(CAShapeLayer*)pSuperLa 
                 fillColor:(UIColor*)pColor strokeColor:(UIColor*)pStrokeColor
                 lineWidth:(float)pWidth ;
// bezier alloc] init] 한 후 기본 변수 세팅..
-(void)setBezierBGColor:(UIColor*)pBGColor borderWidth:(float)pBorderWidth
            borderColor:(UIColor*)pBorderColor;

//////////////////////////////////////////////////////////////////////       [ ANBeziers ]
// Util 
-(void)setStaPath:(CGPoint)pSta; // 초기점 ..
-(void)setStaPathAni:(CGPoint)pSta; // 애니메이션 초기점/벡터 추가..
-(CGPoint)getMeanPoint; // 모든 좌표의 평균(중심) 리턴.


// 3 점을 줘서 커브 1개 추가.  pAnima : 아니마 포인트인지?, pVect : 벡터형식 지정? 그냥 좌표?
-(void)addCurveTo:(CGMutablePathRef)pPath withStaCtrl:(CGPoint)pStaCtrl 
       andEndCtrl:(CGPoint)pEndCtrl andEndPo:(CGPoint)pEnd 
          isAnima:(BOOL)pAnima isVect:(BOOL)pVect; // manPath || manPathAni.. 
// 주어진 점 근처의 랜덤 위치 리턴..
-(CGPoint)randomPosition:(CGPoint)pTarget;


//////////////////////////////////////////////////////////////////////       [ ANBeziers ]
// 안쓰는 함수들....
// 새로운패스를 주어진레이어에 추가.
-(void)addBezierToLayer:(CAShapeLayer*)pLayer nameOf:(NSString*)pName
           withPointArr:(NSMutableArray*)pPoints withCtrlVecters:(NSMutableArray*)pControls;
// ㄴSub routine.. 하나의 유닛 추가.
-(void)addBezierUnitTo:(CGMutablePathRef)pPath withStaPo:(CGPoint)pSta 
       withStaCtrlVect:(CGPoint)pStaCtrl andEndCtrlVect:(CGPoint)pEndCtrl
              andEndPo:(CGPoint)pEnd;


//////////////////////////////////////////////////////////////////////       [ ANBeziers ]
// HTGlasses O^O 관련...
-(void)setRandomANPathOfDegree:(float)pDegree ofDistance:(float)pDistance ofAngle:(float)pAngle
                isPointsPinned:(bool)pIsPoPined;
-(void)copyPathAndArrayFrom:(ANBeziers*)pOtherBezier isBezr:(bool)pBezr isCtrl:(bool)pCtrl;
// pOption [0:ArrBezier + Control] [1:Anima case] [2: Both]


//////////////////////////////////////////////////////////////////////       [ ANBeziers ]
// For Debugging.
-(void)markPointsAndIsAnimaBezier:(bool)pAnimaBezier;


//////////////////////////////////////////////////////////////////////       [ ANBeziers ]
// Animation
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
-(void)startBasicPathAnima;
-(void)setAnimaCurveWithOption:(int)pStartCond endOption:(int)pEndCond withMode:(float)pMode;

-(void)animaStrokeEndFrom:(float)pFrom to:(float)pTo withKey:(NSString*)pKey 
          delegateObj:(id)pDelegate howMany:(int)pNum duration:(float)pDuration 
          autoReverse:(bool)pAutoReverse;

-(void)animaControlPtFromScale:(float)pFrom toScale:(float)pTo withKey:(NSString*)pKey 
                   delegateObj:(id)pDelegate howMany:(int)pNum duration:(float)pDuration 
                   autoReverse:(bool)pAutoReverse;

-(void)animaThicknessFromValue:(id)pFromVal toValue:(id)pToVal withKey:(NSString*)pKey 
                   delegateObj:(id)pDelegate howMany:(int)pNum duration:(float)pDuration 
                   autoReverse:(bool)pAutoReverse;


@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////       [ ANBeziers ]