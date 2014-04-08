//
//  HtFlower.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 11. 12. 26..
//  Copyright (c) 2011년 moon@kretone.com. All rights reserved.
//

// HELP : randomPoint

#import "HtFlower.h"
#import "UIColor+Util.h"
#import "NSObject+Util.h"
#import "ANBeziers.h"

#define P(x,y) CGPointMake(x, y)

//////////////////////////////////////////////////////////////////////////////////////////
@implementation HtFlower
//////////////////////////////////////////////////////////////////////////////////////////

@synthesize mitCnt, manBeziers;
//@synthesize mflTargetX, mflTargetY;
//////////////////////////////////////////////////////////////////////        [ HtFlower ]
#pragma mark - 생성자, 소멸자.

-(id) init
{
    self = [super init];
    [self logMethodMark:@"HtFlower#init" andComment:@" .." isStart:YES];
    
    mitCnt = 0;
    
    manBeziers = [[ANBeziers alloc] init];
    
    [self logMethodMark:@"HtFlower#init" andComment:@" .." isStart:NO];
    return self;
}



-(void) dealloc
{
}



-(id) initWithCoordX:(float)pX andY:(float)pY andSuperLayer:(id)pSuperLayer
{
    self = [super init ];
    [self logMethodMark:@"HtFlower#initWithCoordX:andY:" andComment:@" .." isStart:YES];
    
    mitCnt = 0;
    
    mlaSuper = pSuperLayer;
    [mlaSuper addSublayer:mlaBase ]; // layer 추가.

    // 형태 및 색깔 지정...  애니메이션은 ANObject 에서 처리. 
    [self setTargetWithX:pX andY:pY];
    
    //float size = [self getAround:20. anySign:NO];
    
    // Size.. 사각형 그리기..
    mlaBase.frame = CGRectMake(0, 0, 700, 700);
    mlaBase.anchorPoint = CGPointMake(0.5, 0.5); 
	mlaBase.position = CGPointMake(pX, pY);
	mlaBase.cornerRadius = 100; 
	
    mlaBase.borderColor = [self randomNewColor].CGColor; //[UIColor redColor].CGColor;
	mlaBase.borderWidth = 5;
    //mlaBase.backgroundColor = [UIColor redColor].CGColor;  //  Red color
    
    
    
    //CAShapeLayer *aLayer = [CAShapeLayer layer];
    
    mlaBase.strokeColor = [UIColor blackColor].CGColor;
    mlaBase.fillColor = [UIColor clearColor].CGColor;
    mlaBase.lineWidth = 10;
    mlaBase.lineCap = kCALineCapRound;
//    mlaBase.strokeStart = 5.f;
//    mlaBase.strokeEnd = 15.f;
     
    
    /*  라인 그리기...
    CGPathMoveToPoint(trianglePath, nil, 100, 100);
    CGPathAddLineToPoint(trianglePath, nil, 200, 200); // 라인...
    CGPathAddLineToPoint(trianglePath, nil, 100, 200);
    CGPathAddLineToPoint(trianglePath, nil, 100, 100);
    CGPathCloseSubpath(trianglePath); */
    
    
    //  베지어 곡선 애니메이션..
    CGMutablePathRef trianglePath, newTrianglePath;
    
    trianglePath = CGPathCreateMutable();
    CGPathMoveToPoint(trianglePath, nil, 100, 100);
    CGPathAddCurveToPoint(trianglePath, nil, 100, 200, 200, 200, 200, 100); // Cp1/2/EndPo
    CGPathAddCurveToPoint(trianglePath, nil, 200, 100, 400, 200, 400, 100); // Cp1/2/EndPo
    

    
    
    newTrianglePath = CGPathCreateMutable();
    CGPathMoveToPoint(newTrianglePath, nil, 100, 200);
    CGPathAddCurveToPoint(newTrianglePath, nil, 100, 500, 200, 500, 200, 200);
    CGPathAddCurveToPoint(newTrianglePath, nil, 100, 500, 400, 500, 400, 200);
    
    // 아니마.
    CABasicAnimation *connectorAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    connectorAnimation.duration = 1.0; //duration need to be less than the time it takes to fire handle timer again
    connectorAnimation.removedOnCompletion = NO;  //trying to keep the the triangle from disappearing after the animation
    connectorAnimation.autoreverses = YES;
    connectorAnimation.fillMode = kCAFillModeForwards;
    connectorAnimation.fromValue = (__bridge id)trianglePath;  
    connectorAnimation.toValue = (__bridge id)newTrianglePath;

    connectorAnimation.repeatCount = 1; //HUGE_VAL;
    //[connectorAnimation setDelegate:self]; // animationDidStop 기동시키기...
    CFRelease(trianglePath);
    CFRelease(newTrianglePath);

    [mlaBase addAnimation:connectorAnimation forKey:@"Anima"]; //animatePath"]; 

    /*
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:2.0];
    mnsTimer = [[NSTimer alloc] initWithFireDate:fireDate interval:10.0 target:self 
                                        selector:@selector(animaTest) userInfo:nil repeats:2];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:mnsTimer forMode:NSDefaultRunLoopMode];
    
    [mnsTimer logRetainCount:@"initWithCoordX" withSpace:4]; // Log....
    [mnsTimer release];
    [mnsTimer logRetainCount:@"initWithCoordX" withSpace:4]; // Log.... 
     */
     

    //[self drawPetal];
    
    return self;
}

-(void)animaTest
{
    [CATransaction begin];
    // 0. 시간 
    [CATransaction setValue:[NSNumber numberWithFloat:2.0f] forKey:kCATransactionAnimationDuration];
    
    

    [CATransaction commit];
}


#pragma mark - Delegation 

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self logMethodMark:@"HtFlower#animationDidStop" andComment:@".." isStart:YES];
    NSLog(@"animationDidStop");

    /* // 키 패스를 제거 
    NSString *path = [theAnimation keyPath];
    [layer setValue:[theAnimation toValue] forKeyPath:path];
    [layer removeAnimationForKey:path];
    */
    
    [mlaBase removeAnimationForKey:@"Anima"];
    
    
    CGMutablePathRef trianglePath, newTrianglePath;
    
    trianglePath = CGPathCreateMutable();
    CGPathMoveToPoint(trianglePath, nil, 100, 100);
    
    CGPathAddCurveToPoint(trianglePath, nil, 200, 300, 400, 300, 300, 300);
    
    newTrianglePath = CGPathCreateMutable();
    CGPathMoveToPoint(newTrianglePath, nil, 100, 200);
    CGPathAddCurveToPoint(newTrianglePath, nil, 200, 900, 400, 900, 300, 200);
    
    
    CABasicAnimation *connectorAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    connectorAnimation.duration = 3.0; //duration need to be less than the time it takes to fire handle timer again
    connectorAnimation.removedOnCompletion = NO;  //trying to keep the the triangle from disappearing after the animation
    connectorAnimation.fromValue = (__bridge id)trianglePath;  
    connectorAnimation.toValue = (__bridge id)newTrianglePath;
    
    connectorAnimation.repeatCount = HUGE_VAL;
    
    [mlaBase addAnimation:connectorAnimation forKey:@"Anima"];
    
    CFRelease(trianglePath);
    CFRelease(newTrianglePath);
}

-(void)old // animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    

    mitCnt++;
    
    //NSLog(@"mitCnt is %d", mitCnt);
    
    
    //float tarX = [self getCurX] + 0.5*[self getStep]; // 현재 위치에서 세팅..
    //float tarY = [self getCurY] + [self getStep];

    mlaBase.position = CGPointMake(mpoTarget.x, mpoTarget.y);
    mpoTarget = CGPointMake(mpoTarget.x+50, mpoTarget.y+100);
    
//    NSLog(@"tarX : %f, tarY : %f", tarX, tarY);
   
    CGPoint pEnd = CGPointMake(mpoTarget.x, mpoTarget.y);
    
    // 다음 애니메이션을 위한 기준...

    
    /* 애니메이션 작성 */
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position"];
    //ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //ani.fromValue = [NSValue valueWithCGPoint:pStart];
    ani.toValue = [NSValue valueWithCGPoint:pEnd];

    /*
    if ( (mitCnt % 2) == 1) {
        second=[CABasicAnimation animationWithKeyPath:@"borderWidth"];
        second.toValue = [NSNumber numberWithFloat:30.0];

    } else {
        second=[CABasicAnimation animationWithKeyPath:@"opacity"];
        second.toValue = [NSNumber numberWithFloat:0.0];
    }*/
    ani.duration = 3.0; //[self getAround:4.0];
    [ani  setDelegate:self];
    [mlaBase addAnimation:ani forKey:@"aniDidStop"];
    
    //[self setNewPositionX:newX andY:newY];

/*    CALayer *layer = [anim valueForKey:@"animationLayer"];
    if (layer) {
        NSLog(@"removed %@ (%@) from superview", layer, [layer name]);
        [layer removeFromSuperlayer];
    } */
}





#pragma mark - 그리기.. 관련. 
-(void)drawPetal
{
    [self logMethodMark:@"HtFlower#drawPetal" andComment:@" .. " isStart:YES];
    //UIColor *myColor = [self randomNewColor];
    //UIColor *haloCol = [myColor brighterColor]; // [self brighterColor:myColor];
    //CGPoint superCen = CGPointMake(mlaBase.frame.size.width/2, mlaBase.frame.size.height/2);
    //float len = mlaBase.frame.size.width * 0.8;
    //float haloD = len*0.3;
    for (int i=0; i<1; i++) {
        /*UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:P(100, 100)];
        [path addCurveToPoint:P(300, 100)
                controlPoint1:P(100, 200)
                controlPoint2:P(300, 200)]; */
        
        CGMutablePathRef path1 = CGPathCreateMutable(); 
        CGPathMoveToPoint(path1, NULL, 150, 290);
        CGPathAddLineToPoint(path1, NULL, 270, 400);
        CGPathAddLineToPoint(path1, NULL, 360, 510);

        
        CAShapeLayer *curSL = [CAShapeLayer layer];
        curSL.path = path1;
        curSL.strokeColor = [UIColor blackColor].CGColor;
        curSL.fillColor = [UIColor clearColor].CGColor;
        curSL.lineWidth = 5.0;
        [mlaBase addSublayer:curSL];
    }
}




@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////        [ HtFlower ]