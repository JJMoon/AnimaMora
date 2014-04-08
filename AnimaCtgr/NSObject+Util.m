//
//  NSObject+Util.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 4..
//  Copyright (c) 2012년 moon@kretone.com. All rights reserved.
//

#import "NSObject+Util.h"

#import "DefineStates.h"

////////////////////////////////////////////////////////////////////   [ NSObject + Util ]
@implementation NSObject (Util)
//////////////////////////////////////////////////////////////////////////////////////////


-(NSString*)getSpace:(int)pSpaceNum
{
    NSMutableString *space = [NSMutableString stringWithString:@""];
    for (int i=0; i<pSpaceNum; i++) [space appendString:@" "];
    
    return (NSString*) space;
}

-(void)specialMark:(NSString*)pComment 
{
    NSString *mark = @" ##### ##### ##### ##### ";
    NSLog(@"%@ %@ %@", mark, pComment, mark);
}

////////////////////////////////////////////////////////////////////   [ NSObject + Util ]
#pragma mark - NSLog, NSString Functions.

-(NSString*)getStringAt:(int)pIndex divider:(NSString *)pDivider inString:(NSString *)pStr
{
    NSString* rValue;    
    int num = [pStr length], pastNum = 0;
    
    // ex  @"012#$56#$90#$3456#$90";  
    // range(loca:0, leng:20)   => 3/2.. next> range(loca:5, leng:15) =>
    // 7/2.. next> range(loca:9 leng:11)
    
    NSRange searchRange, rRange;
    
    rRange = NSMakeRange(0, 0);
    
    for (int i=0; i<=pIndex; i++) {
        pastNum = rRange.location + rRange.length;
        searchRange = NSMakeRange(pastNum, num - pastNum);
        rRange = [pStr rangeOfString:pDivider options:NSCaseInsensitiveSearch range:searchRange];
        // 대소문자 가리지 않음..
        if (rRange.location > num) 
        {
            if (pIndex == 0) return pStr; // 첫번째에서 못 찾으면 전체 리턴..
            else 
            {
                searchRange = NSMakeRange(pastNum, pStr.length-pastNum);
                rValue = [pStr substringWithRange:searchRange];
                return rValue; // 못 찾을 경우.
            }
        }
    }
    searchRange = NSMakeRange(pastNum, rRange.location - pastNum);
    rValue = [pStr substringWithRange:searchRange];
    return rValue;
}

-(void)logSpecialComment:(NSString*)pComment withSpace:(int)pSpaceNum;
{
    if (gbooSpecial) {
        gbooSpecial = NO;
        [self specialMark:@"   SPECIAL  COMMENT   "];
        [self logComment:pComment withSpace:pSpaceNum];
        gbooSpecial = YES;
    }
    else
    {
        [self specialMark:@"   ERASE  THIS  LOG   "];
        [self specialMark:@"   ERASE  THIS  LOG   "];
        [self logComment:pComment withSpace:pSpaceNum];
        [self specialMark:@"   ERASE  THIS  LOG   "];
        [self specialMark:@"   ERASE  THIS  LOG   "];
    }
}

-(void)logComment:(NSString*)pComment withSpace:(int)pSpaceNum;
{
    if (gbooSpecial)         return;
    
    NSString *space = [self getSpace:pSpaceNum];

    NSLog(@"%@GENERAL COMMENT CLASS:%@ \t{'' %@ ''}", 
         space, [self class], pComment);
    
}


-(void)logComment:(NSString*)pComment withInteger:(int)pInt 
               of:(NSString*)pIntCmt withSpace:(int)pSpaceNum
{
    if (gbooSpecial)         return;
    NSString *space = [self getSpace:pSpaceNum];
    NSLog(@"%@INTEGER COMMENT in CLASS:%@ \t\t <%@ is \t %d>", 
          space, [self class], pIntCmt, pInt);
}


-(void)logComment:(NSString *)pComment withFloat:(float)pVal 
               of:(NSString *)pValCmt withSpace:(int)pSpaceNum
{
    if (gbooSpecial)         return;
    NSString *space = [self getSpace:pSpaceNum];
    NSLog(@"%@FLOAT COMMENT in CLASS:%@ \t\t <%@ is \t %f>", 
          space, [self class], pValCmt, pVal);
}


-(void)logMethodMark:(NSString*)pClassMethod andComment:(NSString*)pComment isStart:(BOOL)pStart
{
    if (gbooSpecial)         return;

    // Class#Method
    NSString *className, *methodName, *endCmt, *marker;
    NSRange charRange = [pClassMethod rangeOfString:@"#"]; // # 이 있는 위치 리턴.
    NSRange classRange, methodRange;
    classRange.location = 0; classRange.length = charRange.location; // 클래스 이름.
    methodRange.location = classRange.length+1; 
    methodRange.length = [pClassMethod length] - classRange.length - 1; // 메서드 이름.
    className = [pClassMethod substringWithRange:classRange];
    methodName = [pClassMethod substringWithRange:methodRange];
    marker = @">>>. END .<<<";
    if (pStart) { 
        endCmt = marker = @"=========="; //>>. START .<<";
        NSLog(@"\n");   // 새줄 넣고..
    }
    else   endCmt = marker = @"~~~~~~~~~~";//" .... Ended .... ";
    
    // className = [self class]; 이러면 상위 클래스가 보임..
    
    NSLog(@"%@%@ {''  %@  ''} \t%@\t[%@]::[%@]", 
          marker, marker, pComment, endCmt, className, methodName);
    // >>. START .<< >>. START .<<  {''   ..  ''} 	 ... Started ...   	[ ANObject ]::	[ dealloc ]
}


-(void)log2points:(CGPoint)pPt1 nPoint2:(CGPoint)pPt2 andComment:(NSString *)pComment
{
    NSLog(@" CGPoint Coords : (%f, %f) (%f, %f) [  %@  ]", 
          pPt1.x, pPt1.y, pPt2.x, pPt2.y, pComment);
}

/*
-(void)logRetainCount:(NSString *)pComment withSpace:(int)pSpaceNum
{
    if (gbooSpecial)         return;

    NSString *space = [self getSpace:pSpaceNum];
    
    NSLog(@"%@Retain Count [class: %@ ] \t{'' %@ ''} \t<Cnt: %d>", 
          space, [self class], pComment, [self retainCount] );
}
 */



//////////////////////////////////////////////////////////////////////        [ ANObject ]
#pragma mark - Random Utilities

-(int)randomIntFrom:(int)pMinValue To:(int)pMaxValue
{
    int rValue, differ;
    differ = pMaxValue - pMinValue;
    
    if (differ == 0) {
        return 1;
    }
    rValue = (random() % differ) + pMinValue;
    return rValue;
}

-(UIColor*)randomNewColor
{
    CGFloat iRed, iGreen, iBlue, fAlpha;
    iRed = [self randomIntFrom:0 To:255] / 255.0 ;
    iGreen = [self randomIntFrom:0 To:255] / 255.0 ;
    iBlue = [self randomIntFrom:0 To:255] / 255.0 ;
    fAlpha = [self randomIntFrom:150 To:255] / 255.0 ;
    
    return [UIColor colorWithRed:iRed green:iGreen blue:iBlue alpha:fAlpha];
}


-(UIColor*)getDarkColorUnderIn255:(int)pValue
{
    CGFloat iRed, iGreen, iBlue, fAlpha;
    iRed = [self randomIntFrom:0 To:pValue] / 255.0 ;
    iGreen = [self randomIntFrom:0 To:pValue] / 255.0 ;
    iBlue = [self randomIntFrom:0 To:pValue] / 255.0 ;
    fAlpha = [self randomIntFrom:200 To:255] / 255.0 ;
    
    return [UIColor colorWithRed:iRed green:iGreen blue:iBlue alpha:fAlpha];
}

-(UIColor*)getBrightColorOverIn255:(int)pValue
{
    CGFloat iRed, iGreen, iBlue, fAlpha;
    iRed = [self randomIntFrom:pValue To:255] / 255.0 ;
    iGreen = [self randomIntFrom:pValue To:255] / 255.0 ;
    iBlue = [self randomIntFrom:pValue To:255] / 255.0 ;
    fAlpha = [self randomIntFrom:200 To:255] / 255.0 ;
    
    return [UIColor colorWithRed:iRed green:iGreen blue:iBlue alpha:fAlpha];
    
}



-(float)getAround:(float)pFloat anySign:(BOOL)pSign
{
    int rv;
    if (fabs(pFloat)< SMALL_FLOAT ) rv = [self randomIntFrom:5 To:20];
    else  rv = [self randomIntFrom:(int)(80*pFloat) To:(int)(120*pFloat)];
    rv = fabs(rv);
    if (pSign) {
        rv *= powf(-1, random() % 2 );
    }
    return ((float) rv )/ 100.0;
}

-(float)getAround:(float)pFloat inPrecision:(NSRange)pPrecision
{
    int val, loca = pPrecision.location, leng = pPrecision.length; // [loca:30% ~ leng:130%]
    val = [self randomIntFrom:loca To:leng];
    return pFloat * val * 0.01;    
}


-(float)getAroundOf:(float)pValue withPercent:(int)pPercent 
{
    // 0 < pPercent < 100
    int rv = [self randomIntFrom:(int)(100-pPercent) To:(int)(100+pPercent)];
    return ((float) rv )/ 100.0;    
}



@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
////////////////////////////////////////////////////////////////////   [ NSObject + Util ]
