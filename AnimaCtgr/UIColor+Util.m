//
//  UIColor+Util.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 2..
//  Copyright (c) 2012년 moon@kretone.com. All rights reserved.
//

#import "UIColor+Util.h"
#import "NSObject+Util.h"


@implementation UIColor (Util)

-(UIColor*) brighterColor
{
    float vRed, vGreen, vBlue, vAlpha;
    [self getRed:&vRed green:&vGreen blue:&vBlue alpha:&vAlpha];
    float addVal = 0.3;
    vRed += addVal; vGreen += addVal; vBlue += addVal; 
    vAlpha -= addVal;
    
    vRed = [self getBrightValue:vRed];
    vGreen = [self getBrightValue:vGreen];
    vBlue = [self getBrightValue:vBlue];
    vAlpha = [self getDarkerValue:vAlpha];

    return [UIColor colorWithRed:vRed green:vGreen blue:vBlue alpha:vAlpha];    
}

-(float)getDarkerValue:(float)pGiven
{
    if (pGiven <= 0.0) {
        return 0.1;
    }
    if (pGiven > 0.5) {
        return 0.25;
    }
    return pGiven;
}


+(UIColor*)getRedishColorDarkness:(float)pDarkness nAlpha:(float)pAlpha 
{
    float vRed, vGreen, vBlue, vAlpha;

    int redLow, redHigh, low, high;
    
    redLow = 80. * pDarkness; redHigh = 100. * pDarkness;
    low = 20 * pDarkness; high = 60 * pDarkness;
    
    vRed = 0.01 * ( (float)[self randomIntFrom:redLow To:redHigh] );
    vGreen = 0.01 * ( (float)[self randomIntFrom:low To:high] ); 
    vBlue = 0.01 * ( (float)[self randomIntFrom:low To:high] );
    
    vAlpha = pAlpha * 0.01 * ( (float)[self randomIntFrom:80 To:120] );
    NSLog(@"alpha %f", vAlpha);
    return [UIColor colorWithRed:vRed green:vGreen blue:vBlue alpha:vAlpha];    
}
            
            
              
              
-(float)getBrightValue:(float)pGiven
{
    if (pGiven < 0.5) {
        return 0.75;
    }
    if (pGiven >= 1.0) {
        return 0.95;
    }
    return pGiven;
}

@end
