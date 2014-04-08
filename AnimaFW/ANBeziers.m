//
//  ANBeziers.m
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
#import "NSObject+Util.h"
#import "ANBeziers.h"
#import "UIColor+Util.h"
#import "NSObject+Util.h"
#import "NSObject+Geometry.h"
#import "ANObject+Anima.h"


//////////////////////////////////////////////////////////////////////////////////////////
# pragma mark - ANBeziers Implementation   Private methods
@interface ANBeziers()

{

}

-(void)initial___ANBeziers;

-(CGPoint)get_CtrlPoints_Index_Of:(int)pIdx isEnd:(bool)pIsEnd isAnima:(bool)pAnima ;
-(void)markPoints___Anima:(bool)pAnima; // 디버깅용 Control 점 찍기.
-(void)copyPathAndArray___From:(ANBeziers*)pOtherBezier isAnima:(bool)pIsAnima;


@end



# pragma mark - ANBeziers Implementation 
//////////////////////////////////////////////////////////////////////       [ ANBeziers ]
@implementation ANBeziers
//////////////////////////////////////////////////////////////////////////////////////////

@synthesize arrBezrs, arrCtrls, arrBezrAni, arrCtrlAni;
@synthesize manPathAni;
@synthesize mblOpp;
@synthesize mgoMainVector, mgoFarthestPo;

@dynamic mgoKval, mgoTotalLength;

//////////////////////////////////////////////////////////////////////       [ ANBeziers ]
#pragma mark - 생성자, 소멸자.

-(id) init
{
    [self logMethodMark:@"..#init" andComment:@" .." isStart:YES];
    self = [super init];
    
    [self initial___ANBeziers];
    
//    [self logMethodMark:@"..#init" andComment:@" .." isStart:NO];
    return self;
}



-(void) dealloc
{
//    [self logMethodMark:@"ANBeziers#dealloc" andComment:@" .." isStart:YES];

    if (manPathAni) CFRelease(manPathAni);
    
//    [self logMethodMark:@"ANBeziers#dealloc" andComment:@" .. " isStart:NO];
}


-(void)initial___ANBeziers // *** PRIVATE ***
{
    // 생성자..
    arrBezrs = [[NSMutableArray alloc] init]; // 어레이 초기화
    arrCtrls = [[NSMutableArray alloc] init];
    arrBezrAni = [[NSMutableArray alloc] init];
    arrCtrlAni = [[NSMutableArray alloc] init];
    
    manPathAni = CGPathCreateMutable();

    // 패스 설정..
    mlaBase.path = manPath;
    // 프레임 정보.
    mlaBase.frame = CGRectMake(0, 0, mgoWidth, mgoHeight); // 원점은 왼쪽 위. 
    mlaBase.bounds =CGRectMake(0, 0, mgoWidth, mgoHeight); 
    // 지정 안하면 중심이 원점. 원점은 왼쪽 위.
    mlaBase.anchorPoint = CGPointMake(0.5, 0.5); 
    mlaBase.lineWidth = 0.;

    mlaBase.backgroundColor = [UIColor clearColor].CGColor; // 배경색...
    mlaBase.opacity = 0.9; // 투명도.
    mgoKval = 1.0; // default..
    
    
}


-(id)initWithBezierStartPo:(CGPoint)pSta nSuperLa:(id)pSuperLa
                    nWidth:(float)pWidth nHeight:(float)pHeight
{
    self = [super init];
    [self logMethodMark:@"ANBeziers#initWithBezierStartPo" andComment:@".." isStart:YES];
    mlaSuper = pSuperLa;
    mgoWidth = pWidth; mgoHeight = pHeight;
    
    [self initial___ANBeziers];
    
    // 레이어 기초 사항..
    // 변수 세팅.
    mlaBase.lineWidth = mgoLineWidth = .0f; // 

    [self setStaPath:pSta];
    
    // 수퍼레이어에 malBase 추가.
    [mlaSuper addSublayer:mlaBase ]; // layer 추가.
 
//    [self logMethodMark:@"ANBeziers#initWithBezierStartPo" andComment:@".." isStart:NO];
    return self;
}

//////////////////////////////////////////////////////////////////////////////////////////
# pragma mark - 생성후 초기에 쓰이는 함수들

-(void)setBezierBGColor:(UIColor *)pBGColor borderWidth:(float)pBorderWidth borderColor:(UIColor *)pBorderColor
{ // bezier alloc] init] 한 후 기본 변수 세팅..
    mlaBase.backgroundColor = pBGColor.CGColor;
    mlaBase.borderWidth = pBorderWidth;
    mlaBase.borderColor = pBorderColor.CGColor;
}
    
-(void)setBezierSuperLayer:(CAShapeLayer *)pSuperLa fillColor:(UIColor *)pColor strokeColor:(UIColor *)pStrokeColor lineWidth:(float)pWidth
{ // bezier alloc] init] 한 후 기본 변수 세팅..
    mlaSuper = pSuperLa;
    
    mlaBase.fillColor = pColor.CGColor;
    mlaBase.strokeColor = pStrokeColor.CGColor;
    mlaBase.lineWidth = pWidth;
    
    [mlaSuper addSublayer:mlaBase];
}
    

//////////////////////////////////////////////////////////////////////       [ ANBeziers ]
#pragma mark - Utilities

-(CGPoint)randomPosition:(CGPoint)pTarget // 상위 함수 이용...
{
    [self logMethodMark:@"ANBeziers#randomMirrorSub" andComment:@" ERROR " isStart:YES];
    
    float ranX, ranY;
    ranX = [self getAround:10 anySign:YES];
    ranY = [self getAround:10 anySign:YES];
    return CGPointMake(pTarget.x + ranX, pTarget.y + ranY);
}

-(void)setStaPath:(CGPoint)pSta
{
    // 초기점 이동... 어레이에 추가. 
    CGPathMoveToPoint(manPath, nil, pSta.x, pSta.y);
    [arrBezrs addObject:[NSValue valueWithCGPoint:pSta] ];
}
-(void)setStaPathAni:(CGPoint)pSta // 애니메이션 초기점/벡터 추가..
{
    // 초기점 이동... 어레이에 추가.
    CGPathMoveToPoint(manPathAni, nil, pSta.x, pSta.y);
    [arrBezrAni addObject:[NSValue valueWithCGPoint:pSta] ];
}


-(CGPoint)getMeanPoint
{
    CGPoint rPoint = CGPointMake(0, 0);
    int i, num = arrBezrs.count;
    float xsum=0, ysum=0;
    for (i=0; i<num; i++) {
        CGPoint curPo = [[arrBezrs objectAtIndex:i] CGPointValue];
        xsum += curPo.x; ysum += curPo.y;
    }
    if (num) {
        rPoint.x = xsum / num; rPoint.y = ysum / num;
    }
    return rPoint;
}


-(void)addCurveTo:(CGMutablePathRef)pPath withStaCtrl:(CGPoint)pStaCtrl 
       andEndCtrl:(CGPoint)pEndCtrl andEndPo:(CGPoint)pEnd 
          isAnima:(BOOL)pAnima isVect:(BOOL)pVect
{
    NSMutableArray *curBezrArr, *curCtrlArr;
    
    if (pAnima) {
        curBezrArr = arrBezrAni; curCtrlArr = arrCtrlAni;
    } else {
        curBezrArr = arrBezrs; curCtrlArr = arrCtrls;
    }
    
    CGPoint prevPo = [[curBezrArr objectAtIndex:(curBezrArr.count-1) ] CGPointValue];

    CGPoint vectSta, vectEnd;
    if (pVect) { // 벡터 형식이면...
        vectSta = pStaCtrl; vectEnd = pEndCtrl;
        pStaCtrl = CGPointMake(prevPo.x+vectSta.x, prevPo.y+vectSta.y);
        pEndCtrl = CGPointMake(pEnd.x+vectEnd.x, pEnd.y+vectEnd.y);
    } else {    
        vectSta = CGPointMake(pStaCtrl.x - prevPo.x, pStaCtrl.y - prevPo.y);
        vectEnd = CGPointMake(pEndCtrl.x - pEnd.x, pEndCtrl.y - pEnd.y);
    }

    // 내부 어레이에 추가. 
    [curBezrArr addObject:[NSValue valueWithCGPoint:pEnd] ];    // 포인트는 하나 추가. 
    [curCtrlArr addObject:[NSValue valueWithCGPoint:vectSta]];  // 컨트롤은 두개 추가. 
    [curCtrlArr addObject:[NSValue valueWithCGPoint:vectEnd]];

    CGPathAddCurveToPoint(pPath, nil, pStaCtrl.x, pStaCtrl.y, pEndCtrl.x, pEndCtrl.y,
                          pEnd.x, pEnd.y); // 패스에 커브 추가..
}


-(CGPoint)get_CtrlPoints_Index_Of:(int)pIdx isEnd:(bool)pIsEnd isAnima:(_Bool)pAnima  // *** PRIVATE ***
{ // 인덱스는 베지어 어레이의 인덱스.. 끝점Yes. 시작점No.. . 실제 좌표를 리턴함.
    int index = pIdx * 2;
    if (pIsEnd) index -- ;
    
    NSMutableArray *bezierArr, *controlArr;
    if (pAnima) {
        bezierArr = arrBezrAni;
        controlArr = arrCtrlAni;
    } else {
        bezierArr = arrBezrs;
        controlArr = arrCtrls;
    }
    
    if (index < 0 || index >= bezierArr.count) return CGPointMake(0, 0);
    
    CGPoint basePo = [[bezierArr objectAtIndex:pIdx] CGPointValue] ;
    CGPoint vect = [[controlArr objectAtIndex:index] CGPointValue];
    
    return CGPointMake(basePo.x + vect.x , basePo.y + vect.y);    
}



//////////////////////////////////////////////////////////////////////       [ ANBeziers ]
#pragma mark - 안쓰는 함수들...

-(void)addBezierToLayer:(CAShapeLayer *)pLayer nameOf:(NSString *)pName withPointArr:(NSMutableArray *)pPoints withCtrlVecters:(NSMutableArray *)pControls
{ // 새로운패스를 주어진레이어에 추가.
    CGMutablePathRef aPath = CGPathCreateMutable(); 
    if (pPoints.count < 2) return;
    if (pControls.count < 2) return;
    CGPoint sta = [[pPoints objectAtIndex:0] CGPointValue] ;
    CGPoint endPo, staCtrV, endCtrV;
    CGPathMoveToPoint(aPath, nil, sta.x, sta.y);
    
    for (int i=1; i<pPoints.count; i++) {
        endPo = [[pPoints objectAtIndex:i] CGPointValue];
        
        staCtrV = [[pControls objectAtIndex:(i*2-2)] CGPointValue];
        endCtrV = [[pControls objectAtIndex:(i*2-1)] CGPointValue];
        [self addBezierUnitTo:aPath withStaPo:sta withStaCtrlVect:staCtrV 
               andEndCtrlVect:endCtrV andEndPo:endPo];  // 여기서 곡선 넣음...
        sta = endPo;
    }
    pLayer.path = aPath;
}

-(void)addBezierUnitTo:(CGMutablePathRef)pPath withStaPo:(CGPoint)pSta withStaCtrlVect:(CGPoint)pStaCtrl
        andEndCtrlVect:(CGPoint)pEndCtrl andEndPo:(CGPoint)pEnd
{ // 시점, 종점, 벡터의 컨트롤 포인트를 넣으면 CGPathAddCurveToPoint 수행..
    CGPoint ctrSta, ctrEnd;
    ctrSta = CGPointMake(pSta.x + pStaCtrl.x, pSta.y + pStaCtrl.y);
    ctrEnd = CGPointMake(pEnd.x + pEndCtrl.x, pEnd.y + pEndCtrl.y);
    
    CGPathAddCurveToPoint(pPath, nil, ctrSta.x, ctrSta.y, ctrEnd.x, ctrEnd.y,
                          pEnd.x, pEnd.y); // 패스에 커브 추가..
}


//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////       [ ANBeziers ]





//////////////////////////////////////////////////////////////////////       [ ANBeziers ]
#pragma mark - 안경 관련 함수들...

-(void)setRandomANPathOfDegree:(float)pDegree ofDistance:(float)pDistance ofAngle:(float)pAngle 
                isPointsPinned:(_Bool)pIsPoPined
{ // pDegree 0 ~ 1.0 ...   HTGlasses 에서 쓰임...
    int curvN = arrBezrs.count, ctrN = arrCtrls.count;
    float variation = pDegree * 30, direction;
    if ( (curvN-1)*2 != ctrN )   return;
    if ( arrBezrAni.count > 0 || arrCtrlAni.count > 0 ) return;
    
    NSRange distRange = NSMakeRange(100-0.5*variation, 100+0.5*variation);
    NSRange ctrRange = NSMakeRange(100-variation, 100+variation);
    
    if (pDegree > 0.8) {
        direction = 15; // Random
    } else {
        direction = pAngle;
    }
    
    for (int i=0; i<curvN; i++) {
        if (i == 0) {
            CGPoint sta = [[arrBezrs objectAtIndex:i] CGPointValue];
            if (!pIsPoPined) {
                sta = [self getRandomPointFrom:sta toDirection:15 inPrecision:distRange 
                                    ofDistance:pDistance inPrecision:distRange];
            }
            [self setStaPathAni:sta];
            continue;
        }
        
        CGPoint epo = [[arrBezrs objectAtIndex:i] CGPointValue], staCtr, endCtr;
        staCtr = [[arrCtrls objectAtIndex:(i*2 -2)] CGPointValue];
        endCtr = [[arrCtrls objectAtIndex:(i*2 -1)] CGPointValue];
        
        if (!pIsPoPined) {
            epo = [self getRandomPointFrom:epo toDirection:15 inPrecision:distRange 
                                ofDistance:pDistance inPrecision:distRange];
        }
        
        staCtr = [self getRandomPointFrom:staCtr toDirection:15 inPrecision:distRange 
                            ofDistance:pDistance inPrecision:ctrRange];
        endCtr = [self getRandomPointFrom:endCtr toDirection:15 inPrecision:distRange 
                               ofDistance:pDistance inPrecision:ctrRange];

        [self addCurveTo:manPathAni withStaCtrl:staCtr andEndCtrl:endCtr andEndPo:epo 
                 isAnima:YES isVect:YES];
    }
    
}


-(void)copyPathAndArray___From:(ANBeziers*)pOtherBezier isAnima:(bool)pIsAnima  // *** PRIVATE ***
{ // 다른 베지어 객체로 부터 복사..
    NSMutableArray *fromBezrArr, *fromCtrlArr;
    CGMutablePathRef curLay;
    if (pIsAnima) {
        fromBezrArr = pOtherBezier.arrBezrAni; fromCtrlArr = pOtherBezier.arrCtrlAni;
        curLay = manPathAni;
    } else {
        fromBezrArr = pOtherBezier.arrBezrs; fromCtrlArr = pOtherBezier.arrCtrls;
        curLay = manPath;
    }
    
    for (int i=0; i<fromBezrArr.count; i++) {
        if (i == 0) { // 초기점 세팅..
            CGPoint sta = [[fromBezrArr objectAtIndex:i] CGPointValue];
            if (pIsAnima) [self setStaPathAni:sta];
            else [self setStaPath:sta];
            continue;
        }
        
        CGPoint epo = [[fromBezrArr objectAtIndex:i] CGPointValue], staCtr, endCtr;
        staCtr = [[fromCtrlArr objectAtIndex:(i*2 -2)] CGPointValue];
        endCtr = [[fromCtrlArr objectAtIndex:(i*2 -1)] CGPointValue];
        // 중간점 들 세팅...
        [self addCurveTo:curLay withStaCtrl:staCtr andEndCtrl:endCtr andEndPo:epo 
                 isAnima:pIsAnima isVect:YES];
    }
}



-(void)copyPathAndArrayFrom:(ANBeziers *)pOtherBezier isBezr:(_Bool)pBezr isCtrl:(_Bool)pCtrl
{ // pOption [0:ArrBezier + Control] [1:Anima case] [2: Both]   HTGlasses 에서 쓰임...
    
    if (pBezr) [self copyPathAndArray___From:pOtherBezier isAnima:NO]; // Bezier Case.
    if (pCtrl) [self copyPathAndArray___From:pOtherBezier isAnima:YES]; // Control Case.            
}


//////////////////////////////////////////////////////////////////////       [ ANBeziers ]
#pragma mark - Generate Control Points  ### Private ###

#define Assign_StaCtrl [[arrCtrls objectAtIndex:(i*2 -2)] CGPointValue]
#define Assign_EndCtrl [[arrCtrls objectAtIndex:(i*2 -1)] CGPointValue]
#define SET_StaPathAni_ToCurr_InitialJob  if (i==0) {[self setStaPathAni:curr]; continue;}

-(void)generateControlPoint___ScaleFactor:(float)pScale option:(int)pOption
{ // 현재 패스로부터 컨트롤 벡터만 튀겨서 아니마 패스 생성.
    [self logMethodMark:@"ANBezier#scale___Vector" andComment:@"" isStart:YES];
    
    CGPoint curr, prev, staCtr, endCtr, center, direct, sclCur, sclStaCtr, sclEndCtr; // Scaled..
    bool isLeft = true;
    center = [self getMeanPoint];
    int i, num = arrBezrs.count; float ranSc;
    for (i=0; i<num; i++) {
        curr = [[arrBezrs objectAtIndex:i] CGPointValue];
        switch (pOption) {
            case CONTROL_VECTER_SCALE:
                SET_StaPathAni_ToCurr_InitialJob
                staCtr = Assign_StaCtrl; endCtr = Assign_EndCtrl; 
                sclCur = curr;
                sclStaCtr = [self multiply:pScale toPoint:staCtr]; // Scale 적용
                sclEndCtr = [self multiply:pScale toPoint:endCtr]; 
                break;
            case SPREADING_FROM_CENTER:
                ranSc = [self getAround:pScale anySign:NO];
                direct = [self pointFromSta:curr to:center];
                if (i==0) {
                    sclCur = [self addPoint:curr nPnt:direct wScale:ranSc];
                    [self setStaPathAni:sclCur];
                    continue;
                }
                staCtr = Assign_StaCtrl; endCtr = Assign_EndCtrl;
                sclCur = [self addPoint:curr nPnt:direct wScale:ranSc]; // Scale 적용
                sclStaCtr = [self addPoint:staCtr nPnt:direct wScale:ranSc]; // Scale 적용
                sclEndCtr = [self addPoint:endCtr nPnt:direct wScale:ranSc]; // Scale 적용
                break;
            case PUMPING_OUTSIDE: // 왼쪽 오른쪽으로 ... 
                SET_StaPathAni_ToCurr_InitialJob
                staCtr = Assign_StaCtrl; endCtr = Assign_EndCtrl;
                float sign = isLeft? 1.0: -1.0; // 왼쪽이면 +..
                // 벡터 세팅.. 시점 --> 종점 ; 90도 회전 ; scale 적용
                GLKVector3 dirVect = [self vectorFromSta:prev to:curr];
                dirVect = [self rotateVector3:dirVect degreeAngle:90 * sign];
                dirVect = GLKVector3MultiplyScalar(dirVect, pScale); // scale 적용
                
                NSLog(@"Sign is %f", sign);
                
                // 세점 세팅..
                sclStaCtr = CGPointMake(dirVect.x, dirVect.y);   // 법선 벡터만 적용...
                    //[self addVector:dirVect toCGPoint:staCtr]; // 기존 벡터에 더하기..
                sclEndCtr = CGPointMake(dirVect.x, dirVect.y); 
                    //[self addVector:dirVect toCGPoint:endCtr];
                sclCur = curr; // 종점은 변하지 않음.
                break;
            default:
                break;
        }        
        
        
        //NSLog(@"staCtr : %f, %f, endCtr : %f, %f", staCtr.x, staCtr.y, endCtr.x, endCtr.y);
        //[self log2points:prev nPoint2:curr andComment:@"Prev and Curr Points"];

        prev = curr;
        isLeft = !isLeft; // Left Right Switch..
        [self addCurveTo:manPathAni withStaCtrl:sclStaCtr andEndCtrl:sclEndCtr
                andEndPo:sclCur isAnima:YES isVect:YES];
    }
}



//////////////////////////////////////////////////////////////////////       [ ANBeziers ]
#pragma mark - For Debugging

-(void)markPointsAndIsAnimaBezier:(bool)pAnimaBezier
{
    NSLog(@"\n\n\nWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW");
    NSLog(@"  arrBezrs :: %d, arrCtrls :: %d, arrBezrAni :: %d, arrCtrlAni :: %d", 
          arrBezrs.count, arrCtrls.count, arrBezrAni.count, arrCtrlAni.count);
    [self markPoints___Anima:YES];  
    [self markPoints___Anima:NO];
    
    if (!pAnimaBezier) return;

    // New Layer
    CAShapeLayer *newLayer = [CAShapeLayer layer];
    
    newLayer.lineWidth = 5;
    newLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    newLayer.fillColor = [UIColor clearColor].CGColor;
        
    [self addBezierToLayer:newLayer nameOf:@"Anima4Debug" 
              withPointArr:arrBezrAni withCtrlVecters:arrCtrlAni];
    [mlaBase addSublayer:newLayer];
}

-(void)markPoints___Anima:(_Bool)pAnima  // *** PRIVATE ***
{
    // New Layer
    CALayer *newLayer = [CALayer layer];
    newLayer.name = @"mark";
    
    CGColorRef ptColor, ctrColor;
    NSMutableArray *bezierArr;
    float size=10;
    if (pAnima) {
        bezierArr = arrBezrAni;
        ctrColor = [UIColor redColor].CGColor;
        ptColor = [UIColor orangeColor].CGColor;
        size=15;
    }
    else {
        bezierArr = arrBezrs;
        ctrColor = [UIColor blueColor].CGColor;
        ptColor = [UIColor cyanColor].CGColor;
    }
    
    for (int i=0; i < bezierArr.count; i++) {
        CALayer * aLay = [CALayer layer];
        aLay.backgroundColor = ptColor;
        aLay.bounds = CGRectMake(0, 0, size, size);
        aLay.cornerRadius = 5;
        aLay.position = [[bezierArr objectAtIndex:i] CGPointValue];
        [newLayer addSublayer:aLay];
        
        if (i != bezierArr.count-1) {
            CGPoint ctrlSta = [self get_CtrlPoints_Index_Of:i isEnd:NO isAnima:pAnima];
            CALayer * aLay = [CALayer layer];
            aLay.backgroundColor = ctrColor;
            aLay.bounds = CGRectMake(0, 0, size, size);
            aLay.cornerRadius = 5;
            aLay.position = ctrlSta;
            [newLayer addSublayer:aLay];
        }
        if (i != 0) {
            CGPoint ctrlEnd = [self get_CtrlPoints_Index_Of:i isEnd:YES isAnima:pAnima];
            CALayer * aLay = [CALayer layer];
            aLay.backgroundColor = ctrColor;
            aLay.bounds = CGRectMake(0, 0, size, size);
            aLay.cornerRadius = 5;
            aLay.position = ctrlEnd;
            [newLayer addSublayer:aLay];
        }        
    }

    [mlaBase addSublayer:newLayer];
}






//////////////////////////////////////////////////////////////////////       [ ANBeziers ]
#pragma mark - Animations.

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self logMethodMark:@"ANBeziers#animationDidStop" andComment:@" .. " isStart:YES];
    
    mblShow = NO; // 앞으로 언제고 삭제될 운명....
    
    [self removeAllAnimationsTimers];

    return;
    
    CABasicAnimation *size = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    size.duration = .50;
    size.autoreverses = YES;
    size.fromValue = [NSNumber numberWithFloat:1.0];
    size.toValue = [NSNumber numberWithFloat:2.0];
    size.removedOnCompletion = YES;
    
    size.repeatCount = HUGE_VAL;
    //[connectorAnimation setDelegate:self]; // animationDidStop 기동시키기...
    
    [mlaBase addAnimation:size forKey:@"ScaleAnima"]; //animatePath"]; 
    [self logMethodMark:@"ANBeziers#animationDidStop" andComment:@" .. " isStart:NO];    
}


-(void)startBasicPathAnima
{
    
    CABasicAnimation *connectorAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    connectorAnimation.duration = 2.0; //duration need to be less than the time it takes to fire handle timer again
    connectorAnimation.autoreverses = YES;
    connectorAnimation.fillMode = kCAFillModeForwards;
    connectorAnimation.fromValue = (__bridge id)manPath; 
    connectorAnimation.toValue = (__bridge id)manPathAni;
    connectorAnimation.removedOnCompletion = YES;
    //[connectorAnimation setValue:YES forKey:@"isRemovedOnCompletion"];
    
    connectorAnimation.repeatCount = 8; //HUGE_VAL;
    
    [connectorAnimation setDelegate:self]; // animationDidStop 기동시키기...
    //[self autorelease];
    
    [mlaBase addAnimation:connectorAnimation forKey:@"AnimaDelegate"]; //animatePath"]; 
    //CFRelease(connectorAnimation); 뒤진다..
    
    /*
     CABasicAnimation *size = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
     size.duration = 2.30; //duration need to be less than the time it takes to fire handle timer again
     size.autoreverses = YES;
     size.fromValue = [NSNumber numberWithFloat:1.0];
     size.toValue = [NSNumber numberWithFloat:1.5];
     
     size.repeatCount = 12; //HUGE_VAL;
     //[connectorAnimation setDelegate:self]; // animationDidStop 기동시키기...
     
     [mlaBase addAnimation:size forKey:@"ScaleAnima"]; //animatePath"]; 
     
     */
    
    /*
    CABasicAnimation *rot = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rot.duration = .5; //duration need to be less than the time it takes to fire handle timer again
    rot.fromValue = [NSNumber numberWithFloat:.0];
    rot.toValue = [NSNumber numberWithFloat:M_PI*2];
    
    rot.repeatCount = 5; //HUGE_VAL;
    //[connectorAnimation setDelegate:self]; // animationDidStop 기동시키기...
    
    [mlaBase addAnimation:rot forKey:@"Rotation"]; //animatePath"]; 
    */
    mblAnimaFinished = NO;
}


-(void)setAnimaCurveWithOption:(int)pStartCond endOption:(int)pEndCond withMode:(float)pMode
{ // pCond : [0:Free][8:Spring][10:Fixed][11:Pinned]
  // pMode : [0.0:Crazy ~ Slow:1.0]
    int cntPnt = arrBezrs.count, cntCtl = arrCtrls.count; // 점의 수..
    if (cntPnt < 2 || cntCtl < 2) return; // 예외 처리.
    
    CGPoint anmSta, anmEnd, sta, end, anmCtrSta, anmCtrEnd;
    sta = [[arrBezrs objectAtIndex:0] CGPointValue];  // 기존 베지어의 시점.
    end = [[arrBezrs objectAtIndex:cntPnt-1] CGPointValue]; // 종점.

    float length = [self getDistanceBtw:sta And:end]; // 전체 길이.
    float ctrLen = length * pMode * 0.5; // 정도 조절...
    float minPer = 100 - pMode * 50, maxPer = 100 + pMode * 50;
    NSRange lenPrecision = NSMakeRange(minPer, maxPer), nilRange = NSMakeRange(0, 0);
    
    
    // 여러점이면 루프안에 넣어야 함...  나중에...
    
    switch (pStartCond) { // 시작점..
        case 0: // Free
            anmSta = [self getRandomPointFrom:sta toDirection:11 inPrecision:nilRange
                                   ofDistance:ctrLen inPrecision:lenPrecision];
            break;
        case 11: // Pin
            anmSta = sta;
            break;
        default:
            break;
    }

    switch (pEndCond) {
        case 0: // Free
            anmEnd = [self getRandomPointFrom:end toDirection:11 inPrecision:nilRange 
                                   ofDistance:ctrLen inPrecision:lenPrecision];
            break;
        case 11:
            anmEnd = end;
            break;
        default:
            break;
    }
    
    // Control " Vectors "  ..

    anmCtrSta = [self getRandomPointFrom:[[arrCtrls objectAtIndex:0] CGPointValue]
                             toDirection:11 inPrecision:nilRange 
                           ofDistance:ctrLen inPrecision:lenPrecision];
    
    anmCtrEnd = [self getRandomPointFrom:[[arrCtrls objectAtIndex:cntCtl - 1 ] CGPointValue]
                             toDirection:11 inPrecision:nilRange
                              ofDistance:ctrLen inPrecision:lenPrecision];
    
    /*[arrBezrAni release]; [arrCtrlAni release];

    
    arrBezrAni = [[NSMutableArray alloc] initWithObjects:[NSValue valueWithCGPoint:anmSta], 
                  [NSValue valueWithCGPoint:anmEnd], nil];
    arrCtrlAni = [[NSMutableArray alloc] initWithObjects:[NSValue valueWithCGPoint:anmCtrSta],
                  [NSValue valueWithCGPoint:anmCtrEnd], nil];
     */
    
    [self setStaPathAni:anmSta];
    [self addCurveTo:manPathAni withStaCtrl:anmCtrSta andEndCtrl:anmCtrEnd andEndPo:anmEnd isAnima:YES isVect:YES];
}


-(void)animaPath:(float)pFrom toScale:(float)pTo withKey:(NSString*)pKey 
                   delegateObj:(id)pDelegate howMany:(int)pNum duration:(float)pDuration 
                   autoReverse:(bool)pAutoReverse
{
    
}


-(void)animaStrokeEndFrom:(float)pFrom to:(float)pTo withKey:(NSString*)pKey 
              delegateObj:(id)pDelegate howMany:(int)pNum duration:(float)pDuration 
              autoReverse:(bool)pAutoReverse
{
    [self animaValueKeypathOf:@"strokeEnd" forKey:pKey delegateObj:pDelegate 
                      howMany:pNum duration:pDuration 
                      fromVal:[NSNumber numberWithFloat:pFrom]
                        toVal:[NSNumber numberWithFloat:pTo] 
                  autoReverse:pAutoReverse];
}



-(void)animaControlPtFromScale:(float)pFrom toScale:(float)pTo withKey:(NSString*)pKey 
                   delegateObj:(id)pDelegate howMany:(int)pNum duration:(float)pDuration 
                   autoReverse:(bool)pAutoReverse
{ // from/to 둘중 하나는 (-) 여야 함...
    if (pFrom >= 0. && pTo >= 0.)         return;

    float scale;
    if (pFrom >= 0.) scale = pFrom;
    if (pTo >= 0.) scale = pTo;
    
    //[self generateControlPoint___ScaleFactor:scale option:CONTROL_VECTER_SCALE];
    [self generateControlPoint___ScaleFactor:scale option:PUMPING_OUTSIDE];
    [self startBasicPathAnima];
}

-(void)animaThicknessFromValue:(id)pFromVal toValue:(id)pToVal withKey:(NSString*)pKey 
                   delegateObj:(id)pDelegate howMany:(int)pNum duration:(float)pDuration 
                   autoReverse:(bool)pAutoReverse
{
    [self animaValueKeypathOf:@"lineWidth" forKey:pKey delegateObj:pDelegate howMany:pNum duration:pDuration fromVal:pFromVal toVal:pToVal autoReverse:pAutoReverse];
}



@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////       [ ANBeziers ]