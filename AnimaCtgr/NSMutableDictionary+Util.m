//
//  NSMutableDictionary+Util.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 17..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mit : integer       mfo : float         mbl : bool      mgo : geometry
//  arr : array         dic : dictionary    mst : state
//  mdd : distance      man : ANima         mla : Layer     
//  mht : hansoo term   mgn : generator
//  AN : Anima          HT : HT Object      GN : Generator  MG : Manager
//

#import "NSMutableDictionary+Util.h"
#import "GNObject.h"
#import "HtSnow.h"

@interface NSMutableDictionary ()
{
@private
    ;
}

-(CAShapeLayer*)getSuper;


@end


////////////////////////////////////////////////////////     [ NSMutableDictionary + util]
@implementation NSMutableDictionary (Util)
//////////////////////////////////////////////////////////////////////////////////////////

-(bool)checkArrNum:(NSString *)pKey toLimitNum:(int)pLimitN
{
    NSLog(@"checkArrNum");
    NSMutableArray *arr = [self objectForKey:pKey];
    if (!arr) return NO;
    if (arr.count > pLimitN) return NO;
    
    ANObject *newObj;
    if (pKey == @"GNObject") {
        newObj = [[GNObject alloc] init];
        [arr addObject:newObj];
        NSLog(@"GN Object Added :: %d", arr.count);
        return YES;
    } 
    if (pKey == @"HtSnow") {
        newObj = [[HtSnow alloc] init];
        
        [newObj putAt:CGPointMake(100, 100) nSuperLa:[self getSuper] ];
        [arr addObject:newObj];
        NSLog(@"HtSnow Added :: %d", arr.count);
        return YES;
    } 
    
    return NO; // No Object Added
}
    
////////////////////////////////////////////////////////     [ NSMutableDictionary + util]
-(bool)putObject:(NSString *)pKey at:(CGPoint)pPosition to:(NSMutableDictionary *)pDic
{ // 기존에 생성된 놈은 다시 놓고, 아니면 새로 생성..
    
    NSMutableArray *arr = [self objectForKey:pKey];
    if (!arr) {
        NSLog(@"in [putObject:at]  Array not found ... ");
        return NO;
    }
    
    ANObject *newObj = nil;
    if (arr.count) {
        newObj = [arr objectAtIndex:0];
        [arr removeObjectAtIndex:0];
    }
    else {
        if (pKey == @"GNObject") {
            newObj = [[GNObject alloc] init];
        }
        if (pKey == @"HtSnow") {
            newObj = [[HtSnow alloc] init];
        }
    }
    
    if (newObj) {
        [newObj putAt:pPosition nSuperLa:[self getSuper]];
        if ([pDic addObject:newObj forKey:pKey])
        {
            NSLog(@"before newobj release");
            NSLog(@" Object is put");
            return YES; // Success..
        }
    } 
    return NO;
}


-(bool)addObject:(ANObject *)pObj forKey:(NSString *)pKey
{
    NSMutableArray *arr = [self objectForKey:pKey];
    if (!arr) return NO;

    [arr addObject:pObj];
    return YES;
}

-(CAShapeLayer*)getSuper
{
    CAShapeLayer *rVal = [self objectForKey:@"SuperLayer"];
    return rVal;
}


         
@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
////////////////////////////////////////////////////////     [ NSMutableDictionary + util]
