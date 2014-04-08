//
//  HtGlasses.h
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 4. 2..
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mht : hansoo term   mui : UI            mst : state         mtm : Thread/tiMer  
//  mit : integer       mfo : float         mbl : bool          mgo : geometry
//  arr : array         dic : dictionary    mla : Layer         man : ANima         
//  mdd : distance      mpo : point         mcl : color         mpa : path
//  mgn : generateObj   mtp : tempObj       moj : object        mng : manageObj     
//  mgc : graphic rel.  
//  updated @ : 2012. 3. 21.
//

// 잎파리 종류..  센터 라인이 있고, 그 양쪽으로 외곽선을 구성하여 잎을 표현. 

@class ANBeziers;
#import "ANBeziers.h"

@interface ANThickline : ANBeziers
{
    
    NSMutableArray *arrCenter, *arrLeft, *arrRigt; // Just Line Coords..
    NSMutableArray *arrAnmCenter, *arrAnmLeft, *arrAnmRigt; // Anima Target Coords.
}

//////////////////////////////////////////////////////////////////         [ ANThickline ]
# pragma mark - property
@property (nonatomic, retain) NSMutableArray *arrCenter, *arrLeft, *arrRigt,
    *arrAnmCenter, *arrAnmLeft, *arrAnmRigt;

//////////////////////////////////////////////////////////////////         [ ANThickline ]

-(id)touchProcessWithObject:(ANObject*)pTObject wOption:(id)pOption;

-(void)generateThickWithRatio:(float)pRatio;

// Anima
-(void)animaLineWidthFromV:(float)pFromThk toV:(float)pToThk forKey:(NSString*)pKey
                   howMany:(int)pNum duration:(float)pDuration autoReverse:(bool)pAutoReverse;

-(void)animaFrameColorFrom:(id)pFrom toV:(id)pTo forKey:(NSString*)pKey
                   howMany:(int)pNum duration:(float)pDuration autoReverse:(bool)pAutoReverse;


@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////         [ ANThickline ]
