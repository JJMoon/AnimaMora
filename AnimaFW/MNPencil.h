//
//  MNPencil.h
//  AnimaPainter
//
//  Created by Ryan Moon on 12. 3. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ANObject.h"


//////////////////////////////////////////////////////////////////////        [ MNPencil ]
@interface MNPencil : ANObject
// 여기서 무슨 일이 벌어질 것인가..
// 절점을 가장 단순화시켜 그리고, 애니메이션 시킬 것.
// MNPaintView 를 갖고 있어야 할까?.. 이것은 하나의 디스플레이만 하는 임시 레이어 같은 것..
//   그냥 MNObject 에서 갖고 처리하면 됨... 펜슬은 그 이후의 점들을 받아서 처리..
// 단순화 로직 --> ANBezier 가 갖으면 됨..

//////////////////////////////////////////////////////////////////////////////////////////
{

    NSMutableArray *arrBezrs;
}

@property (nonatomic, retain) NSMutableArray *arrBezrs;

-(id)touchProcessWithObject:(ANObject*)pTObject wOption:(id)pOption;
// 터치 정보를 갖는 TObject 를 받아서 후속 작업 처리.




// simplify



@end




//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////        [ MNPencil ]