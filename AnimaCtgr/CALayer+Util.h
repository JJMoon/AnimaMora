//
//  CALayer+Util.h
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 18..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mit : integer       mfo : float         mbl : bool      mgo : geometry
//  arr : array         dic : dictionary    mst : state
//  mdd : distance      man : ANima         mla : Layer     
//  mht : hansoo term   mgn : generator
//  AN : Anima          HT : HT Object      GN : Generator  MG : Manager
//

#import <QuartzCore/QuartzCore.h>


@interface CALayer (Util)


-(void)stopAnima; // hold...
-(void)restartAnima;

-(void)removeChildren;

-(void)removeSubAnimations;

-(void)zapAnimaSublayer; // Zap All including myself

//-(void)removeSubLayers;



@end
