//
//  UIColor+Util.h
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 2..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  NSObject Category
//
//  mit : integer       mfo : float         mbl : bool      mgo : geometry
//  arr : array         dic : dictionary    
//  mdd : distance      man : ANima         mla : Layer     
//  mht : hansoo term   mgn : generator
//  AN : Anima          HT : HT Object      GN : Generator  
//

#import <UIKit/UIKit.h>

@interface UIColor (Util)

+(UIColor*)getRedishColorDarkness:(float)pDarkness nAlpha:(float)pAlpha;

-(float)getBrightValue:(float) pGiven;
-(float)getDarkerValue:(float)pGiven;


-(UIColor*)brighterColor;



@end
