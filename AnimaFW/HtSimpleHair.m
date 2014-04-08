//
//  HtSimpleHair.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 25..
//  Copyright (c) 2012년 moon@kretone.com. All rights reserved.
//

#import "HtSimpleHair.h"
#import "NSObject+Geometry.h"


//////////////////////////////////////////////////////////////////////    [ HtSimpleHair ]
# pragma mark - HtSimpleHair Implementation   Private methods
@interface HtSimpleHair ()
{
@private
    ;
}

-(void)initialHtSimpleHair;

@end




//////////////////////////////////////////////////////////////////////    [ HtSimpleHair ]
@implementation HtSimpleHair
//////////////////////////////////////////////////////////////////////////////////////////

@dynamic mgoHairWidth;

-(id)init
{
    self = [super init];
    
    [self initialHtSimpleHair];
    
    return self;
}


-(void)dealloc
{
    
}

-(void)initialHtSimpleHair  // *** PRIVATE ***
{
    [self logMethodMark:@"HtSimpleHair#initialHtSimpleHair" andComment:@"" isStart:YES];
    
    

}

-(id)initWithPoints:(NSMutableArray *)pointsArr nSuperLa:(CAShapeLayer *)pSuper 
           withMode:(float)pMode
{
    self = [super init];
    [self initialHtSimpleHair];

    CGPoint curPo, staCtrl, endCtrl;
    int num = pointsArr.count;    
    float maxVal = 0. , lineWidth;

    // Main Axis..
    CGPoint bas = [[pointsArr objectAtIndex:0] CGPointValue];
    CGPoint dir = [[pointsArr objectAtIndex:(num-1)] CGPointValue];
    mgoMainVector = [self vectorFromSta:bas to:dir];

    for (int i=0; i<num; i++) {
        curPo = [[pointsArr objectAtIndex:i] CGPointValue];
        float curDist = [self getDistanceOfPoint:curPo toVector:mgoMainVector nBasePo:bas];
        if (curDist > maxVal) {
            maxVal = curDist;
            mgoFarthestPo = curPo;
            //NSLog(@" ***** Max Point Get ***** ");
        } 
    }
    
    // NSLog(@" End of initWithPoints :::  count is %d maxDist is %f ", num, maxVal);

    // 그리기...    
    mlaBase.fillColor = [UIColor clearColor].CGColor;
    // 변수 세팅.
    mlaBase.lineWidth = mgoLineWidth = 5.0f; // 
    mlaBase.strokeColor = [UIColor yellowColor].CGColor;

    // 디버깅 용...
    //[self drawPointAt:mgoFarthestPo withColor:[UIColor redColor].CGColor nSize:15];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
        mlaBase.lineWidth = [self getAround:5 anySign:NO];
    else
        mlaBase.lineWidth = [self getAround:10 anySign:NO];
    
    UIColor *color; // 색깔은 모드에 따라... 어둡게, 랜덤..
    
    if (pMode > 0.4) { // Crazy Mode
        color = [self randomNewColor];
        lineWidth = 10;
    } else {
        color = [self getDarkColorUnderIn255:50];
        lineWidth = 3;
    }
    mlaBase.strokeColor = color.CGColor;
    mlaBase.lineWidth = lineWidth;
    
    GLKVector3 vect = GLKVector3Make( mgoFarthestPo.x - mgoMainVector.x/2,
                                     mgoFarthestPo.y - mgoMainVector.y/2, 0); // 뒤로 빽..
    staCtrl = CGPointMake(vect.x, vect.y);
    endCtrl = CGPointMake(vect.x + mgoMainVector.x, vect.y + mgoMainVector.y); // 앞으로..
    [self setStaPath:bas];  // 초기점 세팅..
    [self addCurveTo:manPath withStaCtrl:staCtrl andEndCtrl:endCtrl 
            andEndPo:dir isAnima:NO isVect:NO];

    // 0,0 에 넣게 됨.. 터치 좌표는 아이패드 좌표.. 다른 점에 넣으면 좌표 보간을 해 줘야 함.
    [self putAt:CGPointMake(0, 0) nSuperLa:pSuper];
    [self setAnimaCurveWithOption:11 endOption:0 withMode:pMode];
    [self startBasicPathAnima];
    
    return self;
}


@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////    [ HtSimpleHair ]
