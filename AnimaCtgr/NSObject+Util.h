//
//  NSObject+Util.h
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 2..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  NSObject Category
//
//  mit : integer       mfo : float         mbl : bool      mgo : geometry
//  arr : array         dic : dictionary    
//  mdd : distance      man : ANima         mla : Layer     
//  mht : hansoo term   mgn : generator
//  AN : Anima          HT : HT Object      GN : Generator  



#import <Foundation/Foundation.h>


@interface NSObject (Util)



#pragma mark - Log Functions

// Utilities.
-(NSString*)getSpace:(int)pSpaceNum; // 사이띄기 스트링 리턴..
-(void)specialMark:(NSString*)pComment ; // 

// NSLog, String related Functions.
-(NSString*)getStringAt:(int)pIndex divider:(NSString*)pDivider inString:(NSString*)pStr;
// "12#34#56"  0:12, 1:34 returns.

-(void)logSpecialComment:(NSString*)pComment withSpace:(int)pSpaceNum;
-(void)logComment:(NSString*)pComment withSpace:(int)pSpaceNum;
-(void)logComment:(NSString*)pComment withInteger:(int)pInt of:(NSString*)pIntCmt 
        withSpace:(int)pSpaceNum;
-(void)logComment:(NSString*)pComment withFloat:(float)pVal of:(NSString*)pValCmt
        withSpace:(int)pSpaceNum;

-(void)logMethodMark:(NSString*)pClassMethod andComment:(NSString*)pComment 
             isStart:(BOOL)pStart; // 함수 앞 뒤에서 마킹..
-(void)log2points:(CGPoint)pPt1 nPoint2:(CGPoint)pPt2 andComment:(NSString*)pComment ;

//-(void)logRetainCount:(NSString*)pComment withSpace:(int)pSpaceNum ;


// Random Utilities
-(int)randomIntFrom:(int)pMinValue To:(int)pMaxValue;
-(float)getAround:(float)pFloat anySign:(BOOL)pSign;
-(float)getAround:(float)pFloat inPrecision:(NSRange)pPrecision;
-(float)getAroundOf:(float)pValue withPercent:(int)pPercent;

-(UIColor*)randomNewColor;
-(UIColor*)getDarkColorUnderIn255:(int)pValue;
-(UIColor*)getBrightColorOverIn255:(int)pValue;




@end
