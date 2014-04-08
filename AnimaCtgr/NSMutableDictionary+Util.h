//
//  NSMutableDictionary+Util.h
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 17..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mit : integer       mfo : float         mbl : bool      mgo : geometry
//  arr : array         dic : dictionary    mst : state
//  mdd : distance      man : ANima         mla : Layer     
//  mht : hansoo term   mgn : generator     mui : UI
//  AN : Anima          HT : HT Object      GN : Generator  MG : Manager
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class HtSnow;
@class ANObject;


@interface NSMutableDictionary (Util)

-(bool)checkArrNum:(NSString*)pKey toLimitNum:(int)pLimitN;

-(bool)putObject:(NSString*)pKey at:(CGPoint)pPosition to:(NSMutableDictionary*)pDic;

-(bool)addObject:(ANObject*)pObj forKey:(NSString*)pKey;

@end
