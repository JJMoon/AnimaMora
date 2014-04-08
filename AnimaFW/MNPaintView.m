//
//  PaintView.m
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

#import "MNPaintView.h"

////////////////////////////////////////////////////////////////////       [ MNPaintView ]
@implementation MNPaintView // : UIView 에서 상속..
//////////////////////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        mfoHue = 0.0;
        if ( ![self initContext:frame.size])
            return self;
            // Error Case;
    }
    return self;
}

- (BOOL) initContext:(CGSize)size {
	
	int bitmapByteCount;
	int	bitmapBytesPerRow;
	
	// Declare the number of bytes per row. Each pixel in the bitmap in this
	// example is represented by 4 bytes; 8 bits each of red, green, blue, and
	// alpha.
	bitmapBytesPerRow = (size.width * 4);
	bitmapByteCount = (bitmapBytesPerRow * size.height);
	
	// Allocate memory for image data. This is the destination in memory
	// where any drawing to the bitmap context will be rendered.
	cacheBitmap = malloc( bitmapByteCount );
	if (cacheBitmap == NULL){
		return NO;
	}
    
    // CGContextRef cacheContext;
	mgcCacheContext = CGBitmapContextCreate(cacheBitmap, size.width, size.height, 
        8, // bits per component
        bitmapBytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst);
	return YES;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self drawToCache:touch];
    [self setNeedsDisplay];
}


- (void) drawToCache:(UITouch*)touch {
    mfoHue += 0.005;
    if(mfoHue > 1.0) mfoHue = 0.0;

    // 색깔이 변하는 효과..
    //UIColor *color = [UIColor colorWithHue:mfoHue saturation:0.7 brightness:1.0 alpha:1.0];
    
    UIColor *color = [UIColor grayColor];
    
    CGContextSetStrokeColorWithColor(mgcCacheContext, [color CGColor]);
    CGContextSetLineCap(mgcCacheContext, kCGLineCapRound);
    CGContextSetLineWidth(mgcCacheContext, 15);
    
    CGPoint lastPoint = [touch previousLocationInView:self];
    CGPoint newPoint = [touch locationInView:self];
    
    CGContextMoveToPoint(mgcCacheContext, lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(mgcCacheContext, newPoint.x, newPoint.y);
    CGContextStrokePath(mgcCacheContext);
    
    CGRect dirtyPoint1 = CGRectMake(lastPoint.x-10, lastPoint.y-10, 20, 20);
    CGRect dirtyPoint2 = CGRectMake(newPoint.x-10, newPoint.y-10, 20, 20);
    [self setNeedsDisplayInRect:CGRectUnion(dirtyPoint1, dirtyPoint2)];
}

- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGImageRef cacheImage = CGBitmapContextCreateImage(mgcCacheContext);
    CGContextDrawImage(context, self.bounds, cacheImage);
    CGImageRelease(cacheImage);
}


-(void)clearDrawing
{
    CGContextClearRect(mgcCacheContext, self.frame);
    [self setNeedsDisplay];

    // 지우개로 바꾸기..
    //CGContextSetBlendMode(mgcCacheContext, kCGBlendModeClear);
}




@end


//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
////////////////////////////////////////////////////////////////////       [ MNPaintView ]
