//
//  HtGlasses.m
//  ObjectPainter
//
//  Created by Ryan Moon on 12. 1. 30..
//  Copyright (c) 2012년 moon@kretone.com. All rights reserved.
//

#import "HtGlasses.h"
#import "ANBeziers.h"
#import "NSObject+Geometry.h"
#import "CALayer+Util.h"
#import "ANObject+Anima.h"
#import "ANBeziers+Geometry.h"

//////////////////////////////////////////////////////////////////////////////////////////
# pragma mark - HtGlasses Implementation   Private methods
@interface HtGlasses()

-(void)initialHtGlasses; 

@end


//////////////////////////////////////////////////////////////////////       [ HtGlasses ]
@implementation HtGlasses
//////////////////////////////////////////////////////////////////////////////////////////

@synthesize mgoInitPo1, mgoInitPo2, mgoFinlPo1, mgoFinlPo2;
@synthesize mgoLeft, mgoRigt;



//////////////////////////////////////////////////////////////////////         [ HtShape ]
#pragma mark - 생성자, 소멸자. 
-(id)init
{
    self = [super init];
    

    
    [self initialHtGlasses];
    return self;
}

-(void)dealloc
{
}


-(void)initialHtGlasses // *** PRIVATE ***
{
    mgoLeft = mgoRigt = nil;
}


-(void)removeAllAnimationsTimers
{
    [mlaBase removeChildren];
    if (mgoLeft) [mgoLeft removeAllAnimationsTimers];
    if (mgoRigt) [mgoRigt removeAllAnimationsTimers];
    [super removeAllAnimationsTimers];
}



-(id)initWithInitPoint:(CGPoint)pPo1 andPoint:(CGPoint)pPo2 andSuperLayer:(id)pSuperLayer
{
    self = [super init];
    [self initialHtGlasses];
    
    //mgoInitPo1 = pPo1; mgoInitPo2 = pPo2; // 터치 시작점.. // 사실 필요 없음..
    
    [pSuperLayer addSublayer:mlaBase];
    return self;
}



-(void)drawUIGlasses:(CGPoint)pPo1 andPoint:(CGPoint)pPo2
{ // 터치 무브 시 Temp 모양  그리기...
    [self logMethodMark:@"HtGlasses#drawUIGlasses" andComment:@"" isStart:YES];
    [mlaBase removeChildren]; // 하위 레이어 제고..

    mgoFinlPo1 = pPo1; mgoFinlPo2 = pPo2;
    
    float totalDist = [self getDistanceBtw:pPo1 And:pPo2];
    float lenzHeigt = totalDist * 0.4;
    float xDif = fabsf(pPo1.x - pPo2.x), yDif = fabsf(pPo1.y - pPo2.y);
    float shrtDist, longDist;
    
    if (xDif > yDif) {  shrtDist = yDif; longDist = xDif; } 
    else             {  shrtDist = xDif; longDist = yDif; }
    
    GLKVector3 pv1, pv2, centV;
    
    pv1 = GLKVector3Make(pPo1.x, pPo1.y, 0); // 좌단.
    pv2 = GLKVector3Make(pPo2.x, pPo2.y, 0); // 우단.

    centV = GLKVector3Lerp(pv1, pv2, 0.5); // 그리는 기준점

    CAShapeLayer *leftLay = [CAShapeLayer layer], *rigtLay = [CAShapeLayer layer];
    
    
    
    leftLay.frame = CGRectMake(pPo1.x, pPo1.y, (centV.x - pPo1.x), (centV.y - pPo1.y));
    rigtLay.frame = CGRectMake(centV.x, centV.y, (pPo2.x - centV.x), (pPo2.y - centV.y));
    
    rigtLay.bounds = leftLay.bounds = CGRectMake(0, 0, lenzHeigt, lenzHeigt);
    rigtLay.anchorPoint = leftLay.anchorPoint = CGPointMake(0.5, 0.5);
    rigtLay.cornerRadius = leftLay.cornerRadius = lenzHeigt*0.5;
    
    rigtLay.backgroundColor = leftLay.backgroundColor = [UIColor whiteColor].CGColor;
    //rigtLay.lineWidth = leftLay.lineWidth = 5;
    //rigtLay.strokeColor = leftLay.strokeColor = [UIColor lightGrayColor].CGColor;

    rigtLay.opacity = leftLay.opacity = 0.4;
    
    rigtLay.borderWidth = leftLay.borderWidth = lenzHeigt*0.1;
    rigtLay.borderColor = leftLay.borderColor = [UIColor lightGrayColor].CGColor;

    [mlaBase addSublayer:leftLay];
    [mlaBase addSublayer:rigtLay];
}


-(void)fixPositionAndStartAnimations
{
    [self logMethodMark:@"HtGlasses#fixPositionAndStartAnimations" andComment:@"" isStart:YES];
    [mlaBase removeChildren]; // 하위 레이어 제고..
    
    //////////////////////////////////////////////////  Bezier Members
    mgoLeft = [[ANBeziers alloc] init];
    mgoRigt = [[ANBeziers alloc] init];
    [mgoLeft setBezierSuperLayer:mlaBase 
                       fillColor:[UIColor clearColor] strokeColor:[UIColor grayColor]
                       lineWidth:10];
    [mgoRigt setBezierSuperLayer:mlaBase 
                       fillColor:[UIColor clearColor] strokeColor:[UIColor grayColor]
                       lineWidth:10];


    //////////////////////////////////////////////////  Vector / Coordinates 안경 위(+)..
    GLKVector3 pv1, pv2, centV, endV, vDir12, vDir13, vc1, vc2;
    float totalDist = [self getDistanceBtw:mgoFinlPo1 And:mgoFinlPo2];
    float lenzHeigt = totalDist * 0.4, variation;
    float xDif = fabsf(mgoFinlPo1.x - mgoFinlPo2.x), yDif = fabsf(mgoFinlPo1.y - mgoFinlPo2.y);
    float shrtDist, longDist;
    
    if (xDif > yDif) {  shrtDist = yDif; longDist = xDif; } // 장변, 단변 
    else             {  shrtDist = xDif; longDist = yDif; }
    
    pv1 = GLKVector3Make(mgoFinlPo1.x, mgoFinlPo1.y, 0); // 좌단.
    pv2 = GLKVector3Make(mgoFinlPo2.x, mgoFinlPo2.y, 0); // 우단.
    centV = GLKVector3Lerp(pv1, pv2, 0.5); // 중점.
    endV = GLKVector3Lerp(pv1, pv2, 0.48);  // 테의 끝 점..
    vDir12 = GLKVector3Subtract(pv1, pv2); // 시점 --> 종점 : 방향벡터.
    
    GLKMatrix3 rotMat = GLKMatrix3MakeZRotation(M_PI/2); // 회전 매트릭스
    vDir13 = GLKMatrix3MultiplyVector3(rotMat, vDir12);  // 적용.
    vDir13 = GLKVector3Normalize(vDir13); // 단위벡터로... 
    vDir13 = GLKVector3MultiplyScalar(vDir13, lenzHeigt); // 거리 적용.
    
    float xval = pv1.x + vDir13.x, yval = pv1.y + vDir13.y; // Ctrl Po 1.
    vc1 = GLKVector3Make(xval, yval, 0);
    xval = endV.x + vDir13.x, yval = endV.y + vDir13.y;  // Ctrl Po 2.
    vc2 = GLKVector3Make(xval, yval, 0);
        
    //////////////////////////////////////////////////  Left Bezier Object Operations
    [mgoLeft setStaPath:CGPointMake(pv1.x, pv1.y)];
    [mgoLeft addCurveTo:mgoLeft.manPath withStaCtrl:CGPointMake(vc1.x, vc1.y) 
             andEndCtrl:CGPointMake(vc2.x, vc2.y) andEndPo:CGPointMake(endV.x, endV.y) 
                isAnima:NO isVect:NO];
    [mgoLeft mirrorPath]; // 아래로 미러링...
    // Random Point setting....
    variation = 0.2 * lenzHeigt; // 변화의 정도...
    [mgoLeft setRandomANPathOfDegree:0.1 ofDistance:variation ofAngle:15 isPointsPinned:YES];
    
    //////////////////////////////////////////////////  Rigt Bezier Object Operations        
    [mgoRigt copyPathAndArrayFrom:mgoLeft isBezr:YES isCtrl:YES]; // Copy Anima Path... 

    //////////////////////////////////////////////////  Rigt Bezier Layer Mirroring...
    CGAffineTransform xTrans = CGAffineTransformMakeTranslation(-centV.x, -centV.y);
    float rotAngle = [self getRadAngleOf:vDir12];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-rotAngle);
    CGAffineTransform final = CGAffineTransformConcat(xTrans, rotate);
    
    CGAffineTransform xMiror = CGAffineTransformMake(-1, 0, 0, 1, 0, 0); // x mirror
    final = CGAffineTransformConcat(final, xMiror);  // Apply
    rotate = CGAffineTransformMakeRotation(rotAngle);
    final = CGAffineTransformConcat(final, rotate);  // Apply
    xTrans = CGAffineTransformMakeTranslation(centV.x, centV.y);
    final = CGAffineTransformConcat(final, xTrans);  // Apply
    mgoRigt.mlaBase.affineTransform = final;
    
    //////////////////////////////////////////////////  Animation Apply
    [mgoLeft startBasicPathAnima];
    [mgoRigt startBasicPathAnima];

    
}


//////////////////////////////////////////////////////////////////////       [ HtGlasses ]
#pragma mark - Anima

-(void)animaLineWidthFromV:(float)pFromThk toV:(float)pToThk forKey:(NSString *)pKey 
                   howMany:(int)pNum duration:(float)pDuration autoReverse:(_Bool)pAutoReverse
{
    [self.mgoLeft  animaFloatKeypathOf:@"lineWidth" forKey:pKey delegateObj:self
                               howMany:pNum duration:pDuration fromVal:pFromThk
                                 toVal:pToThk autoReverse:pAutoReverse];
    [self.mgoRigt  animaFloatKeypathOf:@"lineWidth" forKey:pKey delegateObj:self
                               howMany:pNum duration:pDuration fromVal:pFromThk
                                 toVal:pToThk autoReverse:pAutoReverse];
    
}

-(void)animaFrameColorFrom:(id)pFrom toV:(id)pTo forKey:(NSString *)pKey
                   howMany:(int)pNum duration:(float)pDuration 
               autoReverse:(_Bool)pAutoReverse
{
    [self.mgoLeft animaValueKeypathOf:@"strokeColor" forKey:pKey
                          delegateObj:self howMany:pNum duration:pDuration 
                              fromVal:pFrom toVal:pTo autoReverse:pAutoReverse];
    [self.mgoRigt animaValueKeypathOf:@"strokeColor" forKey:pKey
                          delegateObj:self howMany:pNum duration:pDuration 
                              fromVal:pFrom toVal:pTo autoReverse:pAutoReverse];
    
}


@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////       [ HtGlasses ]
