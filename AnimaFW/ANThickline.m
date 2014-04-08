//
//  HtGlasses.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 4. 2..
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

#import "ANThickline.h"
#import "ANObject+Touch.h"
#import "NSMutableArray+Util.h"
#import "ANBeziers.h"
#import "NSObject+Geometry.h"
#import "CALayer+Util.h"
#import "ANObject+Anima.h"
#import "ANBeziers+Geometry.h"

//////////////////////////////////////////////////////////////////////////////////////////
# pragma mark - HtGlasses Implementation   Private methods
@interface ANThickline()

-(void)initial___ANThickline; 

-(void)generate___Beziers;


@end


//////////////////////////////////////////////////////////////////         [ ANThickline ]
@implementation ANThickline
//////////////////////////////////////////////////////////////////////////////////////////

@synthesize arrCenter, arrLeft, arrRigt, arrAnmCenter, arrAnmLeft, arrAnmRigt;


//////////////////////////////////////////////////////////////////         [ ANThickline ]
#pragma mark - 생성자, 소멸자. 
-(id)init
{
    self = [super init];
    

    
    [self initial___ANThickline];
    return self;
}

-(void)dealloc
{
}


-(void)initial___ANThickline // *** PRIVATE ***
{

}


-(void)removeAllAnimationsTimers
{
    [mlaBase removeChildren];
    [super removeAllAnimationsTimers];
}




//////////////////////////////////////////////////////////////////////        [ MNPencil ]
-(id)touchProcessWithObject:(ANObject*)pTObject wOption:(id)pOption
{
    float thickness = 5, limitDist = 8;
    int repeatNum = [self randomIntFrom:50 To:500];
    UIColor *curColor = [UIColor blueColor];
    float duration = [self getAround:1.0 anySign:NO];
    
    switch (mitType) {
        case TL_GRASS:
            ;
            break;
            
        case TL_TOOTHPICK:
            ;
            break;
        default:
            break;
    }
    
    
    [pTObject pointSimplify:limitDist]; // 여기서 단축점을 추렸음..    // pTObject.arrPoints 에 있슴.
    arrCenter = [[NSMutableArray alloc] initWithArray:pTObject.arrTouchPoints];
    arrLeft = [[NSMutableArray alloc] init];
    arrRigt = [[NSMutableArray alloc] init];
    mgoTotalLength = [arrCenter totalLength];
    
    // Outline Generation
    ANBeziers *newObj = [[ANBeziers alloc] init];
    [newObj setBezierBGColor:CLEAR_COL borderWidth:0. 
                 borderColor:CLEAR_COL];
    [newObj setBezierSuperLayer:(CAShapeLayer*)muiView.layer
                      fillColor:MAGENTA_COL 
                    strokeColor:curColor lineWidth:0]; // 색 지정.

    [self generateThickWithRatio:0.1]; // 여기서 좌우의 절점 채워넣음......
    
    [newObj generateWithArray:arrLeft rigtArr:arrRigt isAnima:NO];
    
    
    
    
    
    
    // AnimaLine Generation
    
    
    
    // Animation Assign..
    /*
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
    */
    return newObj;
}


-(void)generate___Beziers
{
    int i, nLeft = arrLeft.count, nRigt = arrRigt.count;
    
    for (i=0; i<nLeft; i++) {
        ;
    }
    
}


-(void)generateThickWithRatio:(float)pRatio
{
    int i, num = arrCenter.count;
    float curDist, accumLength = mgoTotalLength; // 누적 길이..
    
    if (num < 2)   return;
    
    CGPoint curPo, nextPo, preVect, curVect, dirVect, lPoint, rPoint;
    preVect = CGPointMake(0, 0);
    
    for (i=0; i<num; i++) {
        curPo = [[arrCenter objectAtIndex:i] CGPointValue];
        if (i+1 < num) {
            nextPo = [[arrCenter objectAtIndex:i+1] CGPointValue];
            curDist = [self getDistanceBtw:curPo And:nextPo];
        } else {
            nextPo = curPo;
            curDist = 0;
        }
        
        curVect = [self pointFromSta:curPo to:nextPo];
        dirVect = [self addPoint:preVect nPnt:curVect wScale:1.0]; // 단순히 벡터합.

        // Generate Points...
        GLKVector3 lVect = [self transFrom:dirVect], rVect;
        rVect = [self rotateVector3:lVect degreeAngle:-90];
        lVect = [self rotateVector3:lVect degreeAngle: 90];
        lPoint = [self getPointFrom:curPo toDirVect:lVect ofDistance:accumLength*pRatio];
        rPoint = [self getPointFrom:curPo toDirVect:rVect ofDistance:accumLength*pRatio];
        [arrLeft addObject:[NSValue valueWithCGPoint:lPoint]];
        [arrRigt addObject:[NSValue valueWithCGPoint:rPoint]];
        
        [self log2points:lPoint nPoint2:rPoint andComment:@"Thickness Left, Right Points"];
        [self logComment:@"accumLength" withFloat:accumLength of:@"" withSpace:4];
        accumLength -= curDist;
        preVect = curVect;
    }
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //[self logMethodMark:@"MNPencil#animationDidStop:finished" andComment:@"" isStart:YES];
    mblShow = NO; // 앞으로 언제고 삭제될 운명....
    [self removeAllAnimationsTimers];
    return;
}


//////////////////////////////////////////////////////////////////         [ ANThickline ]
#pragma mark - Anima

-(void)animaLineWidthFromV:(float)pFromThk toV:(float)pToThk forKey:(NSString *)pKey 
                   howMany:(int)pNum duration:(float)pDuration autoReverse:(_Bool)pAutoReverse
{
/*    [self.mgoLeft  animaFloatKeypathOf:@"lineWidth" forKey:pKey delegateObj:self
                               howMany:pNum duration:pDuration fromVal:pFromThk
                                 toVal:pToThk autoReverse:pAutoReverse];
    [self.mgoRigt  animaFloatKeypathOf:@"lineWidth" forKey:pKey delegateObj:self
                               howMany:pNum duration:pDuration fromVal:pFromThk
                                 toVal:pToThk autoReverse:pAutoReverse];
  */  
}

-(void)animaFrameColorFrom:(id)pFrom toV:(id)pTo forKey:(NSString *)pKey
                   howMany:(int)pNum duration:(float)pDuration 
               autoReverse:(_Bool)pAutoReverse
{
    /*[self.mgoLeft animaValueKeypathOf:@"strokeColor" forKey:pKey
                          delegateObj:self howMany:pNum duration:pDuration 
                              fromVal:pFrom toVal:pTo autoReverse:pAutoReverse];
    [self.mgoRigt animaValueKeypathOf:@"strokeColor" forKey:pKey
                          delegateObj:self howMany:pNum duration:pDuration 
                              fromVal:pFrom toVal:pTo autoReverse:pAutoReverse];
    */
}


@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////         [ ANThickline ]
