     //
//  CALayer+Util.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 18..
//  Copyright (c) 2012년 moon@kretone.com. All rights reserved.
//

#import "CALayer+Util.h"


//////////////////////////////////////////////////////////////////////   [ CALayer + util]
@implementation CALayer (Util)
//////////////////////////////////////////////////////////////////////////////////////////


-(void)stopAnima
{ // 잠시 멈춤..
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

-(void)restartAnima
{ // 재개.
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = 
        [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}

-(void)removeChildren
{
    //NSLog(@"CALayer+Util ::::  removeChildren Sub Layers and Self Layer...");
    //[self removeSubAnimations]; // 아니마 삭제하고...
    int num = [self sublayers].count;   
    for (int i=0; i<num; i++){
        CALayer* curLay = [[self sublayers] objectAtIndex:(num-i-1)];
        [curLay removeChildren];
        [curLay removeFromSuperlayer];
    }
}

-(void)removeSubAnimations
{
    //NSLog(@"CALayer+Util ::::  removeSubAnimations");

    /*int num = [self sublayers].count;
    for (int i=0; i<num; i++){
        CALayer* curLay = [[self sublayers] objectAtIndex:(num-i-1)];

        [curLay removeSubAnimations];  // Sub 를 먼저 처리하고...
    } */
    
    NSArray *keyArr = [self animationKeys];
    
    //NSLog(@"CALayer+Util ::::  animation Key.count is %d", keyArr.count);
    
    for (NSString *curKey in keyArr) {

        ;//CAAnimation *curAni = [self animationForKey:curKey];
        
        //curAni.delegate = nil;
    }
    
    [self removeAllAnimations];  // Animation Delete ***
}


-(void)zapAnimaSublayer
{
    [self removeSubAnimations];
    [self removeChildren];
    [self removeFromSuperlayer];
}



@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////   [ CALayer + util]
