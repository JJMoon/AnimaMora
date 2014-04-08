//
//  ANObject+Geometry.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 6..
//  Copyright (c) 2012년 moon@kretone.com. All rights reserved.
//

#import "DefineStates.h"
#import "NSObject+Geometry.h"
#import "ANObject.h"
#import "NSObject+Util.h"


//#import <GLKit/GLKMath.h>

@interface NSObject()
{
@private
    ;
}

@end



@implementation NSObject (Geometry)

#define SMALL_VAL  0.0000001


-(void)testMethod
{
    float rad2deg = 180.0 / M_PI;


    
    
    CGPoint  a, b, c, d;
    a = CGPointMake(5, 5);
    b = CGPointMake(-5, 5);
    c = CGPointMake(5, 10);

    GLKVector3 aVect = GLKVector3Make(1, 5, 0);
    
    float dist = [self getDistanceOfPoint:a toVector:aVect nBasePo:b];
    
    d = [self getSymetryOf:a btwBasePo:b nDirPo:c];
    
    dist = dist + rad2deg;
    
    
    NSLog(@"..");
    //c = GLKVector3Normalize(d);  단위 벡터 만들기. 
    //d = GLKVector3Maximum(d, b);  각 성분 중 최대값 추리기. 
    
    
    /* 내분 / 외분 
    GLKVector3 a, b, interPo, inter2, inter3;
    a = GLKVector3Make(1.0, 1.0, 0.);
    b = GLKVector3Make(5.0, 5.0, 0.);
    interPo = GLKVector3Lerp(a, b, 0.5); // 중점. 
    inter2 = GLKVector3Lerp(a, b, 0.);  // a 점
    inter3 = GLKVector3Lerp(a, b, -1.5); // -6
    interPo = GLKVector3Lerp(a, b, 1.5); // 7..
     */
    
    //BOOL boo1 = [ is:po1 theSamePointWith:po2];

    /*/ 세점간, 두점간 각도 테스트...
    GLKVector3 base = GLKVector3Make(20, 20, 0);
    GLKVector3 vec1 = GLKVector3Make(30, 20, 0);
    GLKVector3 vec2 = GLKVector3Make(30, 30, 0); 
    GLKVector3 negV = GLKVector3Make(-300, -300, 0); 
    
    float resultFrom0 = rad2deg * [self getRadAngleBtwV:vec1  andV:vec2]; // 11.
    float deg180    = rad2deg * [self getRadAngleBtwV:base andV:negV];
    float deg0 = rad2deg * [self getRadAngleBtwV:negV andV:negV];
    // 3 Points...
    float resultDeg45 = rad2deg * [self getRadAngleBase:base standard:vec1 rotateTo:vec2]; // 45
    float ang00 = rad2deg * [self getRadAngleBase:base standard:vec2 rotateTo:vec1]; // -45
    float ang01 = rad2deg * [self getRadAngleBase:vec1 standard:vec2 rotateTo:base]; // 90
    float ang02 = rad2deg * [self getRadAngleBase:vec1 standard:base rotateTo:vec2]; // -89.99
    float ang03 = rad2deg * [self getRadAngleBase:vec2 standard:vec1 rotateTo:base]; // -45
    float ang04 = rad2deg * [self getRadAngleBase:vec2 standard:base rotateTo:vec1]; // 45
    
    float resFromLong = rad2deg * [self getRadAngleBase:negV standard:vec1 rotateTo:vec2]; // 0.88
    float reverseCase = rad2deg * [self getRadAngleBase:vec1 standard:vec2 rotateTo:negV]; // 134
    float angle00 = rad2deg * [self getRadAngleBase:vec2 standard:vec1 rotateTo:negV]; // 134
     */
    

    /*/ 각도 테스트 코드..
    float rad45 = [self getRadAngleOf:CGPointMake(1.0, 1.0)]; // 45deg, 0.7853...
    float radXp = [self getRadAngleOf:CGPointMake(0., 100.0)]; // 90deg, 1.57
    float radXn = [self getRadAngleOf:CGPointMake(0., -100.0)]; // -90deg, -1.57
    float radYp = [self getRadAngleOf:CGPointMake(50.0, .0)]; // 0deg, 0
    float radYn = [self getRadAngleOf:CGPointMake(-50.0, .0)]; // 185deg, 3.14
    
    float rad89 = [self getRadAngleOf:CGPointMake(1., 100.0)]; // 89deg, 1.56
    float rad91 = [self getRadAngleOf:CGPointMake(-1., 100.0)]; // 91deg, 1.58
    
    float rad120 = [self getRadAngleOf:CGPointMake(-30., 20.0)]; // 120deg, 2.55
    float rad120n = [self getRadAngleOf:CGPointMake(-30., -20.0)]; // 120deg, -2.55
     
     */
    
    NSLog(@"testMethod");
    
}


//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Error Check Util Functions.


-(BOOL)isZeroVec:(GLKVector3)pVec // 0 Vector?
{
    if ( fabs(pVec.x) < SMALL_VAL && fabs(pVec.y) < SMALL_VAL && fabs(pVec.z) < SMALL_VAL) {
        return YES; // Error Case
    }
    return NO;
}



-(BOOL)is:(CGPoint)p1 theSamePointWith:(CGPoint)p2 // 두점 일치 확인..
{
    if ( SMALL_VAL > fabs(p1.x-p2.x) && SMALL_VAL > fabs(p1.y-p2.y) ) {
        return YES;
    } else {
        return NO;
    }
}

-(BOOL)is:(GLKVector3)p1 theSameVectorWith:(GLKVector3)p2 // 두점 일치 확인..
{
    if ( SMALL_VAL > fabs(p1.x-p2.x) && SMALL_VAL > fabs(p1.y-p2.y) && 
         SMALL_VAL > fabs(p1.z-p2.z)) {
        return YES;
    } else {
        return NO;
    }
    
}


//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Utilities

-(GLKVector3)vectorFromSta:(CGPoint)pSta to:(CGPoint)pEnd
{ // 방향 벡터
    return GLKVector3Make(pEnd.x-pSta.x, pEnd.y-pSta.y, 0.);
}

-(CGPoint)pointFromSta:(CGPoint)pSta to:(CGPoint)pEnd
{ // 방향 벡터 : CGPoint 형태.. 
    return CGPointMake(pEnd.x-pSta.x, pEnd.y-pSta.y);
}

-(CGPoint)multiply:(float)pValue toPoint:(CGPoint)pPoint
{
    return CGPointMake(pPoint.x * pValue, pPoint.y * pValue);
}

-(GLKVector3)rotateVector3:(GLKVector3)pVector degreeAngle:(float)pDegree
{
    float radAng = degreesToRadians(pDegree);
    GLKMatrix3 rotMat = GLKMatrix3MakeZRotation(radAng);
    return GLKMatrix3MultiplyVector3(rotMat, pVector);
}

// 단순 덧셈...
-(CGPoint)addPoint:(CGPoint)pBase nPnt:(CGPoint)pPoint wScale:(float)pScaleFactor
{
    return CGPointMake(pBase.x + pPoint.x * pScaleFactor,
                       pBase.y + pPoint.y * pScaleFactor);
}

-(CGPoint)addVector:(GLKVector3)pVector toCGPoint:(CGPoint)pCGPoint
{ // 단순 덧셈. 소스 길이를 줄이자.
    return CGPointMake(pVector.x + pCGPoint.x, pVector.y + pCGPoint.y);
}

-(GLKVector3)transFrom:(CGPoint)pPoint
{
    return GLKVector3Make(pPoint.x, pPoint.y, 0);
}

//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Basic Calculations

-(float)getDistanceBtw:(CGPoint)p1 And:(CGPoint)p2
{
    return sqrtf( powf((p1.x-p2.x),2) + powf((p1.y-p2.y),2)  );
}


-(float)getDistanceOfPoint:(CGPoint)point toVector:(GLKVector3)pVec nBasePo:(CGPoint)pBase
{ // pBase 에서 pVec 방향으로 나가는 벡터.. 에 까지의 수선의 발의 길이. 
    float rDist;
    
    GLKVector3 vect = [self vectorFromSta:pBase to:point];
        //GLKVector3Make(point.x - pBase.x, point.y - pBase.y, 0);
    GLKVector3 proVect = GLKVector3Project(vect, pVec);
    
    GLKVector3 rVect = GLKVector3Subtract(proVect, vect);
    
    rDist = sqrtf( powf(rVect.x, 2.) + powf(rVect.y, 2.) );
    
    return rDist;
}

/////////////////////////////////////////////////////////////////  [ ANObject + Geometry ]
#pragma mark - Angle Related..

-(float)getRadAngleRandom;
{
    return 0.01 * ((float)[self randomIntFrom:0 To:315]);
}

-(float)getRadAngleOf:(GLKVector3)pVec // 벡터의 각도 (-pi < <= +pi..
{
    if ([self isZeroVec:pVec]) {
        return -10;
    }
    float innerProdWithXaxis = pVec.x ; // y * 0.0 ...
    float length = GLKVector3Length(pVec);
    float rVal = acosf(innerProdWithXaxis / length ); // ab cos(theta)

    if (pVec.y < 0.0) {
        return -rVal;
    }
    return rVal;
}

-(float)getRadAngleBtwV:(GLKVector3)pBase andV:(GLKVector3)pOther // 두 벡터간 각도. 
// pBase 만큼 반대로 돌려서 각도 측정..
{
    // 회전 행렬 구하기  Negation ... - 
    GLKMatrix3 rotMat = GLKMatrix3MakeZRotation( -[self getRadAngleOf:pBase] );
    
    // 회전 행렬 적용.
    GLKVector3 resultV = GLKMatrix3MultiplyVector3(rotMat, pOther);
    
    // 리턴.
    return [self getRadAngleOf:resultV];
}

                                   
-(float)getRadAngleBase:(GLKVector3)pBase standard:(GLKVector3)pStand // 각도 구하기. 
               rotateTo:(GLKVector3)pTarget 
{
    GLKVector3 standV = GLKVector3Make(pStand.x-pBase.x, pStand.y-pBase.y, pStand.z-pBase.z);    
    GLKVector3 second = GLKVector3Make(pTarget.x-pBase.x, pTarget.y-pBase.y, pTarget.z-pBase.z);

    return [self getRadAngleBtwV:standV andV:second];
}


/////////////////////////////////////////////////////////////////  [ ANObject + Geometry ]
#pragma mark - Get Point ..
-(CGPoint)getPointFrom:(CGPoint)pBasePo toDirection:(float)pDirectRad ofDistance:(float)pDistance
{
    GLKVector3 aVec = GLKVector3Make(pDistance, 0, 0);
    GLKMatrix3 rotMat = GLKMatrix3MakeZRotation( pDirectRad );
    
    GLKVector3 rValue = GLKMatrix3MultiplyVector3(rotMat, aVec); // 벡터를 회전. 
    
    return CGPointMake(pBasePo.x + rValue.x, pBasePo.y + rValue.y); // 적용시켜 리턴. 
}

-(CGPoint)getPointFrom:(CGPoint)pBase toDirVect:(GLKVector3)pVect ofDistance:(float)pDist
{
    GLKVector3 normal = GLKVector3Normalize(pVect);
    return CGPointMake(pBase.x + normal.x * pDist, pBase.y + normal.y * pDist);
}



/////////////////////////////////////////////////////////////////  [ ANObject + Geometry ]
-(CGPoint)getSymetryOf:(CGPoint)pPoint accordingTo:(GLKVector3)pVec  // *** PRIVATE ***
{
    CGPoint rPoint;
    
    GLKVector3 projVect, vect2po, rVal;
    vect2po = GLKVector3Make(pPoint.x, pPoint.y, 0.);
    projVect = GLKVector3Project(vect2po, pVec);
    rVal = GLKVector3Add(projVect, GLKVector3Subtract(projVect, vect2po) );
    
    rPoint = CGPointMake(rVal.x, rVal.y);
    return rPoint;
}


/////////////////////////////////////////////////////////////////  [ ANObject + Geometry ]
-(CGPoint)getSymetryOf:(CGPoint)pPoint btwBasePo:(CGPoint)pPo1 nDirPo:(CGPoint)pPo2
{
    GLKVector3 dirVect = [self vectorFromSta:pPo1 to:pPo2];
    CGPoint tarPo = CGPointMake(pPoint.x - pPo1.x, pPoint.y - pPo1.y);
    
    CGPoint rPo = [self getSymetryOf:tarPo accordingTo:dirVect];
    return CGPointMake(rPo.x + pPo1.x, rPo.y + pPo1.y);
}


-(CGPoint)getRandomPointFrom:(CGPoint)pBasePo 
                 toDirection:(float)pDirectRad inPrecision:(NSRange)pAnglePrecision
                  ofDistance:(float)pDistance inPrecision:(NSRange)pDistPrecision
{ // 
    float directRad, distance = [self getAround:pDistance inPrecision:pDistPrecision];
    // 거리 설정. 
    if (pDirectRad > 10) { // 방향 설정 
        directRad = [self getRadAngleRandom];
    } else {
        directRad = [self getAround:pDirectRad inPrecision:pAnglePrecision];
    }
    
    return [self getPointFrom:pBasePo toDirection:directRad ofDistance:distance];    
}


@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
/////////////////////////////////////////////////////////////////  [ ANObject + Geometry ]