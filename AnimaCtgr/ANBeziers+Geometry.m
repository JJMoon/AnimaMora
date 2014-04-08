//
//  ANBeziers+Geometry.m
//  AnimaPainter
//
//  Created by Ryan Moon on 12. 3. 27..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <GLKit/GLKMath.h>

#import "NSObject+Geometry.h"
#import "ANBeziers+Geometry.h"
#import "NSMutableArray+Util.h"

////////////////////////////////////////////////////////////       [ ANBeziers + Geometry]
@interface ANBeziers()

-(void)mirror___PathAnima:(BOOL)pIsAnima; // NO : pathAni

@end




////////////////////////////////////////////////////////////       [ ANBeziers + Geometry]
@implementation ANBeziers (Geometry)
//////////////////////////////////////////////////////////////////////////////////////////

-(void)closePath
{
    CGPathCloseSubpath(manPath);
    CGPathCloseSubpath(manPathAni);
}

-(void)mirrorPath
{
    [self mirror___PathAnima:YES];
    [self mirror___PathAnima:NO];
}


-(void)mirror___PathAnima:(BOOL)pIsAnima // *** PRIVATE ***
{
    CGMutablePathRef aPath; 
    NSMutableArray *curBezrArr, *curCtrlArr;
    if (pIsAnima) { // 아니마의 경우..
        aPath = manPathAni; curBezrArr = arrBezrAni; curCtrlArr = arrCtrlAni; 
    }
    else { // 패스의 경우..  
        aPath = manPath; curBezrArr = arrBezrs; curCtrlArr = arrCtrls;
    }
    
    if (curBezrArr.count < 2)       return;
    if (arrBezrs.count < 2)         return;
    
    // Symmetric Axis..
    CGPoint bas = [[curBezrArr objectAtIndex:0] CGPointValue];
    CGPoint dir = [[curBezrArr objectAtIndex:(curBezrArr.count-1)] CGPointValue];
    GLKVector3 symVect = [self vectorFromSta:bas to:dir];
    
    // addCurveTo 를 이용...
    int count = curBezrArr.count, objNum2 = 2*(count-1);
    for (int i=0; i<count-1; i++) {
        CGPoint cpo = [[curBezrArr objectAtIndex:(count-i-2)] CGPointValue];
        CGPoint cpoSym = [self getSymetryOf:cpo btwBasePo:bas nDirPo:dir];
        
        // 컨트롤 포인트..
        CGPoint cstapo = [[curCtrlArr objectAtIndex:(objNum2-i*2-1)] CGPointValue]; // Vector
        CGPoint sctrSym = [self getSymetryOf:cstapo accordingTo:symVect];
        CGPoint cendpo = [[curCtrlArr objectAtIndex:(objNum2-i*2-2)] CGPointValue];
        CGPoint ectrSym = [self getSymetryOf:cendpo accordingTo:symVect];
        
        if (mblRandom) {
            // cpoSym, sctrSym, ectrSym 
            cpoSym = [self randomPosition:cpoSym];
            sctrSym = [self randomPosition:sctrSym];
            ectrSym = [self randomPosition:ectrSym];
        }
        
        [self addCurveTo:aPath withStaCtrl:sctrSym andEndCtrl:ectrSym 
                andEndPo:cpoSym isAnima:pIsAnima isVect:YES];
    }
    
}

////////////////////////////////////////////////////////////       [ ANBeziers + Geometry]
#pragma mark - 연속된 베지어 곡선 추가하기.. 

-(void)addRandom
{
    float staCtrx, staCtry, endPox, endPoy, endCtrx, endCtry;
    // Previous Bezier's Properties...
    CGPoint prevStaPo = [[arrBezrs objectAtIndex:(arrBezrs.count-2) ] CGPointValue]; // prev sta
    CGPoint prevEndPo = [[arrBezrs objectAtIndex:(arrBezrs.count-1) ] CGPointValue]; // prev end
    
    // End Point Coord..  Random ***
    endPox = prevEndPo.x + ( prevEndPo.x-prevStaPo.x ) * [self getAroundOf:1.0 withPercent:20];
    endPoy = prevEndPo.y + ( prevEndPo.y-prevStaPo.y ) * [self getAroundOf:1.0 withPercent:20];
    
    // Start Ctrl Po..
    CGPoint staPoVec = [[arrCtrls objectAtIndex:(arrCtrls.count-1)] CGPointValue];
    // opposite direction
    staCtrx = prevEndPo.x - staPoVec.x; // previous end - current start
    staCtry = prevEndPo.y - staPoVec.y;
    
    // End Ctrl Po..  opposite of Previous start
    CGPoint endPoVec = [[arrCtrls objectAtIndex:(arrCtrls.count-2)] CGPointValue];
    endCtrx = endPox - endPoVec.x;
    endCtry = endPoy - endPoVec.y;
    
    [arrBezrs addObject:[NSValue valueWithCGPoint:CGPointMake(endPox, endPoy)]];
    [arrCtrls addObject:[NSValue valueWithCGPoint:CGPointMake(endCtrx-endPox, endCtry-endPoy)]];
    
    CGPathAddCurveToPoint(manPath, nil, staCtrx, staCtry, endCtrx, endCtry, endPox, endPoy);
}


////////////////////////////////////////////////////////////       [ ANBeziers + Geometry]
#pragma mark - 포인트 리스트에 컨트롤 포인트 추가하기..

-(void)generateWithArray:(NSMutableArray *)pArrPoints 
                 rigtArr:(NSMutableArray*)pArrRigt isAnima:(bool)pIsAnm
{ //
    int i, num=pArrPoints.count;
    NSLog(@"******************************************* ANBezier + Geometry ");    
    NSLog(@"Simplified arrPoints %d", num);
    
    CGPoint staPo, endPo, nxtPo, ctrV, negV, preV;
    CGMutablePathRef curPath;
    preV = CGPointMake(0, 0); // For the First Point
    staPo = [[pArrPoints objectAtIndex:0] CGPointValue];
    
    if (pIsAnm) {
        [self setStaPathAni:staPo];
        curPath = manPathAni;
    } else {
        [self setStaPath:staPo];   
        curPath = manPath;
    }
    
    NSMutableArray *curArr = [[NSMutableArray alloc] initWithArray:pArrPoints];
    if (pArrRigt) {
        num += pArrRigt.count;
        [curArr addObjectsFromArrayReversed:pArrRigt];
    }
    
    for (i=1; i<num; i++) {
        staPo = [[curArr objectAtIndex:i-1] CGPointValue];
        endPo = [[curArr objectAtIndex:i] CGPointValue];

        if (i+1 < num) {
            nxtPo = [[curArr objectAtIndex:i+1] CGPointValue];
            
            CGPoint midPo1 = CGPointMake( (staPo.x + endPo.x)/2, (staPo.y + endPo.y)/2 );
            CGPoint midPo2 = CGPointMake( (nxtPo.x + endPo.x)/2, (nxtPo.y + endPo.y)/2 );
            // 방향벡터.. 한쪽 방향을 나타내므로 0.5 곱함.. sta --> end 방향. 
            ctrV = CGPointMake( (midPo2.x-midPo1.x)*mgoKval*0.5, 
                                (midPo2.y-midPo1.y)*mgoKval*0.5  ) ;
            negV = CGPointMake(-ctrV.x, -ctrV.y);
            
            [self addCurveTo:curPath withStaCtrl:preV  andEndCtrl:negV 
                    andEndPo:endPo isAnima:NO isVect:YES]; // middle members.
            
            //CGPathAddLineToPoint (manPath, nil, endPo.x, endPo.y); // 4 debugging
            
            preV = ctrV;
            
        } else {
            CGPoint zeroVect = CGPointMake(0, 0);
            [self addCurveTo:curPath withStaCtrl:ctrV andEndCtrl:zeroVect 
                    andEndPo:endPo isAnima:NO isVect:YES]; // 끝점 컨트롤 포인트 없음.
            
            //CGPathAddLineToPoint(manPath, nil, endPo.x, endPo.y); // 4 debugging
        }
    }
    //[self generateLineWithArray:pArrPoints];
}




-(void)generateLineWithArray:(NSMutableArray *)pArrPoints
{ // 직선으로 표현... 디버깅용...
    int i, num=pArrPoints.count;
    NSLog(@"******************************************* ANBezier + Geometry ");    
    NSLog(@"Simplified arrPoints %d", num);
    
    CGPoint staPo, endPo, nxtPo, ctrV, negV, preV;
    preV = CGPointMake(0, 0); // For the First Point
    staPo = [[pArrPoints objectAtIndex:0] CGPointValue];
    [self setStaPath:staPo];
    
    for (i=1; i<num; i++) {
        staPo = [[pArrPoints objectAtIndex:i-1] CGPointValue];
        endPo = [[pArrPoints objectAtIndex:i] CGPointValue];
        
        if (i+1 < num) {
            nxtPo = [[pArrPoints objectAtIndex:i+1] CGPointValue];
            
            CGPoint midPo1 = CGPointMake( (staPo.x + endPo.x)/2, (staPo.y + endPo.y)/2 );
            CGPoint midPo2 = CGPointMake( (nxtPo.x + endPo.x)/2, (nxtPo.y + endPo.y)/2 );
            // 방향벡터.. 한쪽 방향을 나타내므로 0.5 곱함.. sta --> end 방향. 
            ctrV = CGPointMake( (midPo2.x-midPo1.x)*mgoKval*0.5, 
                               (midPo2.y-midPo1.y)*mgoKval*0.5  ) ;
            negV = CGPointMake(-ctrV.x, -ctrV.y);
            
            CGPathAddLineToPoint (manPath, nil, endPo.x, endPo.y); // 4 debugging
            
            preV = ctrV;
            
        } else {
            CGPathAddLineToPoint(manPath, nil, endPo.x, endPo.y); // 4 debugging
        }
    }
    
}



@end


//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
////////////////////////////////////////////////////////////       [ ANBeziers + Geometry]