//
//  PaintView.h
//  PaintingSample
//
//  Created by Sean Christmann on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  mht : hansoo term   mui : UI            mst : state         mtm : Thread/tiMer  
//  mit : integer       mfo : float         mbl : bool          mgo : geometry
//  arr : array         dic : dictionary    mla : Layer         man : ANima         
//  mdd : distance      mpo : point         mcl : color         mpa : path
//  mgn : generateObj   mtp : tempObj       moj : object        mng : manageObj     
//  mgc : graphic rel.  
//  updated @ : 2012. 3. 21.
//

#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////       [ MNPaintView ]
@interface MNPaintView : UIView 
//////////////////////////////////////////////////////////////////////////////////////////
{
    void *cacheBitmap;
    CGContextRef mgcCacheContext;
    float mfoHue;
}

- (BOOL) initContext:(CGSize)size;
- (void) drawToCache:(UITouch*)touch;

-(void)clearDrawing;

@end


//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
////////////////////////////////////////////////////////////////////       [ MNPaintView ]
