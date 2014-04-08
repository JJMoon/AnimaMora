//
//  MNPencil.m
//  AnimaPainter
//
//  Created by Jongwoo Moon on 12. 3. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//
//  mht : hansoo term   mui : UI            mst : state         mtm : Thread/tiMer  
//  mit : integer       mfo : float         mbl : bool          mgo : geometry
//  arr : array         dic : dictionary    mla : Layer         man : ANima         
//  mdd : distance      mpo : point         mcl : color         mpa : path
//  mgn : generateObj   mtp : tempObj       moj : object        mng : manageObj     
//

#import "MNPencil.h"
#import "UIColor+Util.h"
#import "ANObject+Touch.h"
#import "ANObject+Anima.h"
#import "ANBeziers.h"
#import "ANBeziers+Geometry.h"

#import <GLKit/GLKMath.h>

//////////////////////////////////////////////////////////////////////        [ MNPencil ]
@implementation MNPencil
//////////////////////////////////////////////////////////////////////////////////////////

@synthesize arrBezrs;

-(id)init
{
    self = [super init];

  //  arrPoints = [[NSMutableArray alloc] init];
    
    return self;
}


//////////////////////////////////////////////////////////////////////        [ MNPencil ]
-(id)touchProcessWithObject:(ANObject*)pTObject wOption:(id)pOption
{
    float thickness = 5, limitDist = 8;
    int repeatNum = [self randomIntFrom:50 To:500];
    UIColor *curColor = [UIColor blueColor];
    float duration = [self getAround:1.0 anySign:NO];
    
    if ( mitType == PENCIL_ANM_BOLD )
    {
        thickness = 15; limitDist = 20;
        curColor = [UIColor getRedishColorDarkness:0.8 nAlpha:1.0];
    } else {
    }
    
    [pTObject pointSimplify:limitDist]; // 여기서 단축점을 추렸음..    // pTObject.arrPoints 에 있슴.
    
    ANBeziers *newObj = [[ANBeziers alloc] init];
    [newObj setBezierBGColor:CLEAR_COL borderWidth:0. 
                 borderColor:CLEAR_COL];
    [newObj setBezierSuperLayer:(CAShapeLayer*)muiView.layer
                      fillColor:CLEAR_COL 
                    strokeColor:curColor lineWidth:thickness]; // 색 지정.
    [newObj generateWithArray:pTObject.arrPoints rigtArr:nil isAnima:NO]; // 컨트롤 포인트 추가.
    
    // Animation Assign..
    switch (mitType) {
        case PENCIL_ANM_NORMAL:
            [newObj animaThicknessFromValue:nil toValue:[NSNumber numberWithFloat:80]
                                    withKey:@"thick" delegateObj:newObj howMany:repeatNum 
                                   duration:duration autoReverse:NO];
            [newObj animaOpacityFromValue:-1.0 toVal:0.1 withKey:@"opacity" 
                              delegateObj:newObj howMany:repeatNum duration:duration 
                              autoReverse:NO];            
            break;
        case PENCIL_ANM_BOLD:
            [newObj animaControlPtFromScale:-1.0 toScale:0.3 withKey:@"" 
                                delegateObj:newObj howMany:10 duration:2 autoReverse:YES];
            break;
        case PENCIL_ANM_STROKE:
            [newObj animaStrokeEndFrom:0.0 to:1.0 withKey:@"stroke" 
                           delegateObj:newObj howMany:HUGE_VAL duration:1 autoReverse:YES];
            break;
        default:
            break;
    }
    
    if  ( mitType == PENCIL_ANM_BOLD ) {
        
        
        
    } else {
    }
    
    return newObj;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //[self logMethodMark:@"MNPencil#animationDidStop:finished" andComment:@"" isStart:YES];
    mblShow = NO; // 앞으로 언제고 삭제될 운명....
    [self removeAllAnimationsTimers];
    return;
}

@end


//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////        [ MNPencil ]