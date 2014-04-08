//
//  ANObject+Anima.m
//  AnimaPainter
//
//  Created by Ryan Moon on 12. 3. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ANObject+Anima.h"


@interface ANObject ()
{
@private
    ;
}

-(void)initial___ANObject;

-(void)animaAdd___ObjectOf:(CAAnimation*)pAnima delegateObj:(id)pDelegate
                   howMany:(int)pNum duration:(float)pDura
               autoReverse:(bool)pAutoReverse withKey:(NSString*)pKey ;

@end


@implementation ANObject (Anima)



///////////////////////////////////////////////////////////////////   [ ANObject + Anima ]
#pragma mark - Animations.





///////////////////////////////////////////////////////////////////   [ ANObject + Anima ]
-(void)animaRotationSnow
{
    //////////////////////////////////////////////////  Rotation Anima
    [self animaRotation4key:@"Rotation" delegateObj:self howMany:2 duration:3.0f 
                       type:@"Snow" axis:@"z" autoReverse:NO];
}

-(void)animaFallingSnowFrom:(CGPoint)pSta endsAt:(CGPoint)pEnd
{
    [self setRandomBezierStartsAt:pSta endsAt:pEnd];
    [self animaMoveOnPath4key:@"Move" delegateObj:self duration:6.0 
                       calcMode:kCAAnimationPaced autoReverse:NO];
    [self animaFloatKeypathOf:@"transform.scale" forKey:@"Scale" delegateObj:self 
                        howMany:5 duration:[self getAround:0.5 anySign:NO]  
                        fromVal:1.0 toVal:1.5 autoReverse:YES];
}


-(void)animaAdd___ObjectOf:(CAAnimation *)pAnima delegateObj:(id)pDelegate 
                   howMany:(int)pNum duration:(float)pDura 
               autoReverse:(_Bool)pAutoReverse withKey:(NSString *)pKey
{ // 기본값 세팅 및 레이어에 추가..
    
    if (pNum == 0) pNum = HUGE_VALF;
    pAnima.repeatCount = pNum;
    pAnima.duration = pDura;
    pAnima.autoreverses = pAutoReverse;
    pAnima.delegate = pDelegate;
    pAnima.removedOnCompletion = YES; // Default yet.....
    [mlaBase addAnimation:pAnima forKey:pKey];
}



//////////////////////////////////////////////////////////////////////        [ ANObject ]
-(void)animaFloatKeypathOf:(NSString *)pKeyPath forKey:(NSString *)pKey 
               delegateObj:(id)pDelegate
                   howMany:(int)pNum duration:(float)pDuration 
                   fromVal:(float)pFrom toVal:(float)pTo
               autoReverse:(_Bool)pAutoReverse
{
    [self animaValueKeypathOf:pKeyPath forKey:pKey delegateObj:pDelegate 
                      howMany:pNum duration:pDuration 
                      fromVal:[NSNumber numberWithFloat:pFrom] 
                        toVal:[NSNumber numberWithFloat:pTo] autoReverse:pAutoReverse];
}


///////////////////////////////////////////////////////////////////   [ ANObject + Anima ]
-(void)animaValueKeypathOf:(NSString *)pKeyPath forKey:(NSString *)pKey
               delegateObj:(id)pDelegate
                   howMany:(int)pNum duration:(float)pDuration 
                   fromVal:(id)pFrom toVal:(id)pTo
               autoReverse:(_Bool)pAutoReverse
{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:pKeyPath];
    if (pFrom)   anima.fromValue = pFrom;
    if (pTo)     anima.toValue   = pTo;
    
    [self animaAdd___ObjectOf:anima delegateObj:pDelegate howMany:pNum duration:pDuration
                  autoReverse:pAutoReverse withKey:pKey];
}


///////////////////////////////////////////////////////////////////   [ ANObject + Anima ]
-(void)animaRotation4key:(NSString *)pKey delegateObj:(id)pDelegate
                 howMany:(int)pNum duration:(float)pDuration 
                    type:(NSString *)pType axis:(NSString *)pAxis 
             autoReverse:(_Bool)pAutoReverse
{
    NSString *keyPath = [NSString stringWithFormat:@"transform.rotation.%@", pAxis];    
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:keyPath];
	//anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	
    if (pType == @"Snow") {
        anim1.fromValue = [NSNumber numberWithFloat:0.f];
        anim1.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    }
    
    [self animaAdd___ObjectOf:anim1 delegateObj:pDelegate howMany:pNum duration:pDuration 
                  autoReverse:pAutoReverse withKey:pKey];
}


//////////////////////////////////////////////////////////////////////        [ ANObject ]
-(void)animaMoveOnPath4key:(NSString *)pKey delegateObj:(id)pDelegate 
                  duration:(float)pDuration calcMode:(NSString *)pCalulationMode 
               autoReverse:(_Bool)pAutoReverse
{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anima.path = manPath;
    anima.calculationMode = pCalulationMode; 
    if (pDelegate)         anima.delegate = pDelegate;
    [self animaAdd___ObjectOf:anima delegateObj:pDelegate howMany:1 duration:pDuration 
                  autoReverse:pAutoReverse withKey:pKey];
}

///////////////////////////////////////////////////////////////////   [ ANObject + Anima ]
-(void)animaOpacityFromValue:(float)pFrom toVal:(float)pTo withKey:(NSString *)pKey delegateObj:(id)pDelegate 
                     howMany:(int)pNum duration:(float)pDuration 
                 autoReverse:(_Bool)pAutoReverse
{ // From Value 만 받으므로 원래 투명도로 돌아간다... See "ANObject#vanish"
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    if (pFrom >= 0) anima.fromValue = [NSNumber numberWithFloat:pFrom];
    if (pTo >= 0)   anima.toValue = [NSNumber numberWithFloat:pTo];
    anima.delegate = pDelegate;
    [self animaAdd___ObjectOf:anima delegateObj:pDelegate howMany:pNum duration:pDuration
                  autoReverse:pAutoReverse withKey:pKey];    
}


///////////////////////////////////////////////////////////////////   [ ANObject + Anima ]
-(void)vanishWithKey:(NSString *)pKey delegateObj:(id)pDelegate
{
    [mlaBase setOpacity:0.0];
    [self animaOpacityFromValue:1.0 toVal:-1.0 withKey:[NSString stringWithFormat:@"%@#Opacity",pKey]
                    delegateObj:pDelegate howMany:1 duration:3.0 
                    autoReverse:NO];
    CGPoint endPo = CGPointMake(120, 120);
    [self setRandomBezierStartsAt:mpoTarget endsAt:endPo];
    [self animaMoveOnPath4key:[NSString stringWithFormat:@"%@#Move",pKey] 
                  delegateObj:pDelegate duration:3.0 
                     calcMode:kCAAnimationPaced autoReverse:NO];
}

@end
