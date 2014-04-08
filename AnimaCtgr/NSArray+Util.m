//
//  NSArray+Util.m
//  ObjectPainter
//
//  Created by Ryan Moon on 12. 2. 12..
//  Copyright (c) 2012년 moon@kretone.com. All rights reserved.
//

#import "NSArray+Util.h"

@implementation NSArray (Util)



-(id)nextObjectOf:(id)pObject
{
    int idx = [self indexOfObject:pObject];
    
    if (idx == NSNotFound) {  // Error ..  Object is INVALID !!!
        return nil;
    }
    
    if (idx +1 == self.count) {  // Last Object ==> return first Object..
        return [self objectAtIndex:0];
    }
    return [self objectAtIndex:(idx + 1)];  // Next Object..
}




@end
