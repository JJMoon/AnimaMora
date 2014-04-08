//
//  ANObject+Touch.m
//  AnimaPainter
//
//  Created by James Moon on 12. 3. 26..
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

#import "ANObject+Touch.h"

#import "DefineStates.h"
#import "NSMutableArray+Util.h"



//////////////////////////////////////////////////////////////////////        [ ANObject ]
# pragma mark - ANObject Implementation   Private methods
@interface ANObject()
{
@private
    ;
}

-(void)add___touchPointsNumOf:(int)pNum;

-(double)total___Length;
-(BOOL)is___Simplified;

@end



///////////////////////////////////////////////////////////////////   [ ANObject + Touch ]
@implementation ANObject (Touch)
//////////////////////////////////////////////////////////////////////////////////////////




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    arrTouchPoints = nil;
    muiTouchNum = 0;
    arrTouchPoints = [[NSMutableArray alloc] init];
    
    // 첫 포인트 추가.
    NSSet *allTouches = [event allTouches];
    CGPoint firstPo = [[[allTouches allObjects] objectAtIndex:0] locationInView:muiView];
    [arrTouchPoints addObject:[NSValue valueWithCGPoint:firstPo]];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint curPo = [touch locationInView:muiView];
        // Memory is Full !!!
        
        muiTouchPos[muiTouchNum][0] = curPo.x;  
        muiTouchPos[muiTouchNum][1] = curPo.y;
        if (muiTouchNum >= TOUCH_COORD_NUM-1 ) {
            [self add___touchPointsNumOf:TOUCH_COORD_NUM]; // 단위 작업 처리.. 이걸 블록화.
            muiTouchNum = 0;
        } else {
            muiTouchNum++; // 일련번호 증가.
        }
        NSLog(@"ANObject+Touch touch Moved  muiTouchNum : %i, %f, %f", muiTouchNum, curPo.x, curPo.y);
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{ // double/tripple touch...
    [self add___touchPointsNumOf:muiTouchNum]; // 남은 우수리 처리.
    NSLog(@"ANObject+Touch touch Ended muiTouchNum : %i", muiTouchNum);
}

-(void)touchProcess:(CGPoint)pPosition nSuperView:(UIView *)pView
{     }


-(id)touchProcessWithObject:(ANObject*)pTObject wOption:(id)pOption
{    // 자식 객체들이 일을 함.
    return nil;
}

-(void)add___touchPointsNumOf:(int)pNum
{
    dispatch_queue_t globalQue = 
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0ul);
    
    dispatch_sync(globalQue, ^{
        int i = 0;
        for (i=0; i<pNum; i++) {
            NSLog(@"Add Points ...i:%i", i);
            [arrTouchPoints addObject:[NSValue valueWithCGPoint:
                                       CGPointMake(muiTouchPos[i][0], muiTouchPos[i][1])]];
        }
    });
}


-(void)pointSimplify:(float)pLimitDist
{
    //float length = [arrTouchPoints totalLength];
    NSMutableArray *arrayOfarray = [[NSMutableArray alloc] init];
    NSMutableArray *duple = [NSMutableArray arrayWithArray:arrTouchPoints];
    arrPoints = [[NSMutableArray alloc] init ];
    
    [arrayOfarray addObject:duple]; // add 1 array object
    [arrayOfarray divideWithLimit:pLimitDist]; // 여기서 점들을 추출..
        
    int i, num = arrayOfarray.count;
    for (i=0; i<num; i++) {
        NSMutableArray *curArr = [arrayOfarray objectAtIndex:i];
        if (i == 0) {
            [arrPoints addObject:[curArr objectAtIndex:0]]; // 첫점..
            NSLog(@"***************************** :: ANObject + Touch -pointSimplify, %d", num);
            CGPoint curPo = [[curArr objectAtIndex:0] CGPointValue];
            NSLog(@"First Point : %f, %f", curPo.x, curPo.y);
        }
        [arrPoints addObject:[curArr lastObject]];  // 각 끝점들..
        CGPoint curPo = [[curArr lastObject] CGPointValue];
        NSLog(@"Mid   Point : %f, %f", curPo.x, curPo.y);
    }
    
    NSLog(@"***************************** :: ANObject + Touch -pointSimplify, %d", arrPoints.count);
}


-(BOOL)is___Simplified
{ // Check Simplify. If not Add the most distant point to <arrPoints>..
    
    
    
    return YES;
}


@end


//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
///////////////////////////////////////////////////////////////////   [ ANObject + Touch ]
