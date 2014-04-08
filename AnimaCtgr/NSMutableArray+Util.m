//
//  NSMutableArray+Util.m
//  ObjectPainter
//
//  Created by Ryan Moon on 12. 2. 1..
//

#import <GLKit/GLKMath.h>

#import "NSMutableArray+Util.h"
#import "ANObject.h"
#import "NSObject+Geometry.h"



# pragma mark - NSMutableArray Util Category 
///////////////////////////////////////////////////////////////  [ NSMutableArray + Util ]
@implementation NSMutableArray (Util)
//////////////////////////////////////////////////////////////////////////////////////////




-(void)stopAndKillSingleObject:(Class)pClass
{
    //////////////////////////////////////////////////  객체 하나만 제거 후 리턴.     
    for (int i=0; i<self.count; i++) {
        ANObject *curObj = [self objectAtIndex:i];
        
        if ([curObj class] == pClass ) {
            curObj.mblShow = NO;            
            [curObj removeAllAnimationsTimers];

            [self removeObject:curObj];
            return;
        }
    }
}



-(void)stopAndKillSingleObjectOfType:(int)pType
{
    //////////////////////////////////////////////////  객체 하나만 제거 후 리턴. 
    for (int i=0; i<self.count; i++) {
        ANObject *curObj = [self objectAtIndex:i];
        
        if (curObj.mitType == pType) {
            curObj.mblShow = NO;            
            [curObj removeAllAnimationsTimers];
            
            [self removeObject:curObj];
            return;
        }
    }
}




-(double)totalLength
{
    int i, num = self.count;
    float length = 0.;
    CGPoint curPo, prePo;
    
    for (i=0; i<num; i++) {
        curPo = [[self objectAtIndex:i] CGPointValue];
        if (i) {
            length += sqrtf(  powf(curPo.x-prePo.x, 2) + powf(curPo.y-prePo.y, 2)  );
        } 
        prePo = curPo;
    }
    
    NSString *lengStr = [NSString stringWithFormat:@"%f", length];
    [self logMethodMark:@"NSMutableArray+Util#totalLength" andComment:lengStr isStart:NO];
    
    return length;
}


///////////////////////////////////////////////////////////////  [ NSMutableArray + Util ]
#pragma mark - divideWithLimit 주기능 함수..

-(void)divideWithLimit:(float)pDist
{ // Self is already array of array..  // initialy have ONE array.
    BOOL bIsComplete = FALSE;
    
    while (!bIsComplete) {
        int i=0, num = self.count;
        bIsComplete = TRUE;

        for (i=0; i<num; i++) {
            NSMutableArray *curArray = [self objectAtIndex:i];

            int idx = [curArray farthestPointIdxWithLimit:pDist];
            if (idx) {
                NSMutableArray *newArr = [curArray divide:idx];
                [self insertObject:newArr atIndex:i+1]; // i + 1..
                bIsComplete = FALSE;
                break;
            }
        }
    }
}


-(NSMutableArray*)divide:(int)pIndex
{
    NSMutableArray *backArray = [[NSMutableArray alloc] init];
    int i, num = self.count;
    
    // Index 객체는 겹치도록 분리.
    for (i=pIndex; i<num; i++) { // New Array
        [backArray addObject:[self objectAtIndex:i]];
    }
    for (i=pIndex+1; i<num; i++) { // My Self.
        [self removeLastObject];
    }
    
    return backArray;
}


-(int)farthestPointIdxWithLimit:(float)pDist
{
    int i, num = [self count], maxIdx;
    if (num <= 2) return 0;
    CGPoint rValue;
    float farthest = 0.;
    BOOL isExistRValue = FALSE;
    
    CGPoint staPo = [[self objectAtIndex:0] CGPointValue];
    CGPoint endPo = [[self lastObject] CGPointValue];
    GLKVector3 dirV = GLKVector3Make(staPo.x - endPo.x, staPo.y - endPo.y, 0);
    
    for (i=1; i<num-1; i++) {
        CGPoint curPo = [[self objectAtIndex:i] CGPointValue];        
        float dist = [self getDistanceOfPoint:curPo toVector:dirV nBasePo:staPo];
                
        if (dist > pDist && dist > farthest) {
            maxIdx = i;
            rValue = curPo;
            farthest = dist;
            isExistRValue = TRUE;
        }
    }
    
    if (isExistRValue) {
        return maxIdx; //[NSValue valueWithCGPoint:rValue];
    } else {
        return 0; // It acts as FALSE..
    }
}

-(void)addObjectsFromArrayReversed:(NSArray *)pArray
{
    int i, num = pArray.count;

    for (i=0; i<num; i++) {
        id curObj = [pArray objectAtIndex:(num - i - 1)];
        [self addObject:curObj];
    }
}


-(void)reverseMyself
{
    int i, num = self.count;
    NSRange range = NSMakeRange(0, num) ;
    for (i=0; i<num; i++) {
        id curObj = [self objectAtIndex:(num - i - 1)];
        [self addObject:curObj];
    }
    
    [self removeObjectsInRange:range];
}

@end


//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
///////////////////////////////////////////////////////////////  [ NSMutableArray + Util ]
