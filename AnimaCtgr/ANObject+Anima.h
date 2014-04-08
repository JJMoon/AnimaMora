//
//  ANObject+Anima.h
//  AnimaPainter
//
//  Created by Ryan Moon on 12. 3. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ANObject.h"

///////////////////////////////////////////////////////////////////   [ ANObject + Anima ]
@interface ANObject (Anima)
//////////////////////////////////////////////////////////////////////////////////////////

// 쉬운 사용... 
-(void)animaRotationSnow;
-(void)animaFallingSnowFrom:(CGPoint)pSta endsAt:(CGPoint)pEnd;


// 직접 아니마 실행... From Value, To Value... [NSNumber numberWithFloat:pFrom]  때문에.. 
-(void)animaFloatKeypathOf:(NSString*)pKeyPath forKey:(NSString*)pKey 
               delegateObj:(id)pDelegate howMany:(int)pNum duration:(float)pDuration
                   fromVal:(float)pFrom toVal:(float)pTo
               autoReverse:(bool)pAutoReverse;


// animaAdd___ObjectOf Direct Call Methods.....
-(void)animaValueKeypathOf:(NSString*)pKeyPath forKey:(NSString*)pKey 
               delegateObj:(id)pDelegate howMany:(int)pNum duration:(float)pDuration
                   fromVal:(id)pFrom toVal:(id)pTo
               autoReverse:(bool)pAutoReverse;

-(void)animaRotation4key:(NSString*)pKey delegateObj:(id)pDelegate 
                 howMany:(int)pNum duration:(float)pDuration 
                    type:(NSString*)pType axis:(NSString*)pAxis 
             autoReverse:(bool)pAutoReverse ;


// Animation

// Position Anima..  // manPath 는 이미 세팅되어 있어야함....
-(void)animaMoveOnPath4key:(NSString*)pKey delegateObj:(id)pDelegate duration:(float)pDuration 
                  calcMode:(NSString*)pCalulationMode autoReverse:(bool)pAutoReverse;

// From Value 만 받으므로 원래 투명도로 돌아간다... See "ANObject#vanish"
-(void)animaOpacityFromValue:(float)pFrom toVal:(float)pTo withKey:(NSString*)pKey delegateObj:(id)pDelegate
                     howMany:(int)pNum duration:(float)pDuration 
                 autoReverse:(bool)pAutoReverse;

// 코너 객체에 쓰임... 천천히 사라져가는 효과. 
-(void)vanishWithKey:(NSString*)pKey delegateObj:(id)pDelegate ;



@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
///////////////////////////////////////////////////////////////////   [ ANObject + Anima ]
