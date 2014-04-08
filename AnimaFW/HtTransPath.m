//
//  HtTransPath.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 12..
//  Copyright (c) 2012년 moon@kretone.com. All rights reserved.
//

#import "HtTransPath.h"


//////////////////////////////////////////////////////////////////////////////////////////
# pragma mark - HtTransPath Implementation   Private methods
@interface HtTransPath ()
{
@private
    ;
}

-(void)initialHtTransPath;

@end

# pragma mark - HtTransPath Implementation 
//////////////////////////////////////////////////////////////////////////////////////////
@implementation HtTransPath
//////////////////////////////////////////////////////////////////////////////////////////

@synthesize mraDirect, mddLength, mvlRotate;

//////////////////////////////////////////////////////////////////////     [ HtTransPath ]
#pragma mark - 생성자, 소멸자.

-(id)init
{
    self = [super init];
    return self;
}


-(void)initialHtTransPath  // *** PRIVATE ***
{
}

-(id)initPathInitialDirection:(float)pInitAngle nRotateDelta:(float)pvlRotate 
                      nLength:(float)pddLength 
                        staPo:(CGPoint)pStaPo endPo:(CGPoint)pEndPo
                    staCtrlPo:(CGPoint)pStaCtr endCtrlPo:(CGPoint)pEndCtr
{
    self = [super init];
    mraDirect = pInitAngle;    mvlRotate = pvlRotate;    mddLength = pddLength;
    
    // manPath 세팅...  manPathAni는 필요 없겠음..  하나만 갖음...
    // 미세변화 필요하므로.. 좌표를 따로 갖고 있고... 패스는 그때 그때 날림... 
    // manPath는 불필요...  arrBezrs, *arrCtrls,  만 필요할 것 같음... 
    
    
    return self;
}

//////////////////////////////////////////////////////////////////////     [ HtTransPath ]
#pragma mark - Supply CGPathRef objects to Owner.               

-(CGPathRef)getCurrentPath
{
    CGPathRef rPath = CGPathCreateMutable();
    
    
    
    
    
    
    
    return rPath;
}





@end




//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
