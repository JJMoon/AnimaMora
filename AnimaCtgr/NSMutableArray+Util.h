//
//  NSMutableArray+Util.h
//  ObjectPainter
//
//  Created by Ryan Moon on 12. 2. 1..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mit : integer       mfo : float         mbl : bool      mgo : geometry
//  arr : array         dic : dictionary    mst : state
//  mdd : distance      man : ANima         mla : Layer     
//  mht : hansoo term   mgn : generator
//  AN : Anima          HT : HT Object      GN : Generator  MG : Manager
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Util)

-(void)stopAndKillSingleObject:(Class)pClass;
-(void)stopAndKillSingleObjectOfType:(int)pType;

// 베지어 단순화 로직..
-(void)divideWithLimit:(float)pDist;

// Geometry Related..
-(double)totalLength;

-(NSMutableArray*)divide:(int)pIndex;
-(int)farthestPointIdxWithLimit:(float)pDist;

-(void)reverseMyself;

-(void)addObjectsFromArrayReversed:(NSArray*)pArray;

@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
///////////////////////////////////////////////////////////////  [ NSMutableArray + Util ]