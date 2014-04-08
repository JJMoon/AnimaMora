//
//  ANObject+Geometry.h
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 6..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  NSObject Category
//
//  mit : integer       mfo : float         mbl : bool      mgo : geometry
//  arr : array         dic : dictionary    
//  mdd : distance      man : ANima         mla : Layer     
//  mht : hansoo term   mgn : generator
//  AN : Anima          HT : HT Object      GN : Generator  


//#import "NSObject.h"
#import <GLKit/GLKMath.h>

@interface NSObject (Geometry)
{
    
}
-(void)testMethod;

// Error Check :::
-(BOOL)isZeroVec:(GLKVector3)pVec; // 0 Vector?
-(BOOL)is:(CGPoint)p1 theSamePointWith:(CGPoint)p2; // 두점 일치 확인..
-(BOOL)is:(GLKVector3)p1 theSameVectorWith:(GLKVector3)p2; // 두점 일치 확인..

// Utilities
-(GLKVector3)vectorFromSta:(CGPoint)pSta to:(CGPoint)pEnd; // 방향벡터 
-(CGPoint)    pointFromSta:(CGPoint)pSta to:(CGPoint)pEnd; // 방향벡터 
// pVector 를 Z 축을 기준으로 회전시킨 벡터를 리턴. 오른손 방향 +
-(GLKVector3)rotateVector3:(GLKVector3)pVector degreeAngle:(float)pDegree;

-(CGPoint)multiply:(float)pValue toPoint:(CGPoint)pPoint;
-(CGPoint)addPoint:(CGPoint)pBase nPnt:(CGPoint)pPoint wScale:(float)pScaleFactor;
-(CGPoint)addVector:(GLKVector3)pVector toCGPoint:(CGPoint)pCGPoint;
-(GLKVector3)transFrom:(CGPoint)pPoint;


// Base Calculations
-(float)getDistanceBtw:(CGPoint)p1 And:(CGPoint)p2;
-(float)getDistanceOfPoint:(CGPoint)point toVector:(GLKVector3)pVec nBasePo:(CGPoint)pBase;

// Angle Related..
-(float)getRadAngleRandom;
-(float)getRadAngleOf:(GLKVector3)pVec; // 벡터의 각도 (-pi < <= +pi..
-(float)getRadAngleBtwV:(GLKVector3)pBase andV:(GLKVector3)pOther; // 두 벡터간 각도. 
-(float)getRadAngleBase:(GLKVector3)pBase standard:(GLKVector3)pStand // 각도 구하기. 
               rotateTo:(GLKVector3)pTarget; 
// Get Point
-(CGPoint)getPointFrom:(CGPoint)pBasePo toDirection:(float)pDirectRad ofDistance:(float)pDistance;
-(CGPoint)getPointFrom:(CGPoint)pBase toDirVect:(GLKVector3)pVect ofDistance:(float)pDist;
-(CGPoint)getSymetryOf:(CGPoint)pPoint accordingTo:(GLKVector3)pVec;
-(CGPoint)getSymetryOf:(CGPoint)pPoint btwBasePo:(CGPoint)pPo1 nDirPo:(CGPoint)pPo2;

-(CGPoint)getRandomPointFrom:(CGPoint)pBasePo 
                 toDirection:(float)pDirectRad inPrecision:(NSRange)pAnglePrecision
                  ofDistance:(float)pDistance inPrecision:(NSRange)pDistPrecision;
// pDirectRad [-M_PI ~ M_PI] [ 10 < : No Direction Set]


@end
