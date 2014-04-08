//
//  GNObject.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 6..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mit : integer       mfo : float         mbl : bool      mgo : geometry
//  arr : array         dic : dictionary    mst : state
//  mdd : distance      man : ANima         mla : Layer     
//  mht : hansoo term   mgn : generator
//  AN : Anima          HT : HT Object      GN : Generator  MG : Manager
//

#import "GNObject.h"



//////////////////////////////////////////////////////////////////////////////////////////
# pragma mark - GNObject Implementation   Private methods
@interface GNObject ()
{
@private
    ;
}

-(void)initialGNObject;

@end


//////////////////////////////////////////////////////////////////////        [ GNObject ]
@implementation GNObject
//////////////////////////////////////////////////////////////////////////////////////////

@synthesize mhtCurrent;

//////////////////////////////////////////////////////////////////////        [ GNObject ]
#pragma mark - 생성자, 소멸자. 
-(id)init
{
    return self;
}

-(void)initialGNObject // *** PRIVATE ***
{
//    mgoBG = nil; // 생성은 drawHeart, .. 에서.
  //  mgoDeco = nil;
    

}

-(id)initWithHtObject:(ANObject *)pObject
{
    mhtCurrent = pObject;
    
        
    return self;
}




//////////////////////////////////////////////////////////////////////        [ ANObject ]
#pragma mark - Animations.



@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////        [ GNObject ]