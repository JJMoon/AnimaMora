//
//  ANBeziers+Geometry.h
//  AnimaPainter
//
//  Created by Ryan Moon on 12. 3. 27..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ANBeziers.h"

////////////////////////////////////////////////////////////       [ ANBeziers + Geometry]
@interface ANBeziers (Geometry)
//////////////////////////////////////////////////////////////////////////////////////////

{
    
}


-(void)closePath;
-(void)mirrorPath;


// 연속된 베지어 곡선 추가하기.. 
-(void)addRandom;


// 부드러운 베지어 곡선 만들기.. Ctrl Point 자동 생성..
-(void)generateWithArray:(NSMutableArray*)pArrPoints 
                 rigtArr:(NSMutableArray*)pArrRigt isAnima:(bool)pIsAnm;

// 곡선과 관련된 값 리턴..
-(id)getOutlinePointFromPoint:(CGPoint)pPoint ;

// 4 Debugging.
//-(void)generateLineWithArray:(NSMutableArray *)pArrPoints; // 디버깅용 함수.

@end


//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
////////////////////////////////////////////////////////////       [ ANBeziers + Geometry]
