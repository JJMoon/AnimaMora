//
//  MNObject.m
//  ObjectPainter
//
//  Created by Jongwoo Moon on 12. 1. 6..
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

// 필요한 시점에 모든 아니마를 죽이고... 그럼 즉시 animationDidStop 이 가동됨...  retain 이 줄고.
// 이때 객체는 죽이지 말고..
// 시차를 두고.. 타이머에서 객체를 죽인다... 아님 재사용.. 

#import "DefineStates.h"

#import "MNObject.h"
#import "ANObject+Touch.h"
#import "ANObjectSet.h"
#import "ANOption.h"

#import "ANThickline.h"
#import "HtSimpleHair.h"
#import "HtGlasses.h"
#import "HtShape.h"
#import "HtSnow.h"
#import "ANObjectSet.h"
#import "NSArray+Util.h"
#import "ANObject+Anima.h"

#import "MNPencil.h"
#import "MNPaintView.h"

#define HT_MAX_HAIR_CRAZY 10
#define HT_MAX_HAIR_MODERATE 10
#define HT_MAX_GLASSES 5


//////////////////////////////////////////////////////////////////////////////////////////
# pragma mark - GNObject Implementation   Private methods
@interface MNObject ()
{
@private
    int mitJobNum, mitJobCnt; // 한번에 지울 놈 수... 어레이 객체의 10% 정도.
}

@property (assign) int mitJobNum, mitJobCnt;

-(void)checkArray___Num;
-(void)initial___MNObject;
-(void)set___JobNum; 
-(void)kill___ANObjects;

//-(void)animationStopOrRestart:(bool)pStop;

// Model Methods
-(void)generate___ANObjectsAt:(CGPoint)pPosition;
-(void)generate___HairObjectIsCrazy:(bool)pIsCrazy isCorner:(bool)pCorner ;


// Object Kill ...
-(void)boundary___Check;


-(void)cornerObject___Manage;
@end


//////////////////////////////////////////////////////////////////////        [ MNObject ]
@implementation MNObject
//////////////////////////////////////////////////////////////////////////////////////////

@synthesize manCornerObj, manUIObj;
@synthesize mitJobNum, mitJobCnt;
@synthesize dicObjects;
@synthesize arrObjSet, muiCurObjSet;
@synthesize mstLock;
@synthesize mitCounter;
@synthesize mflBaseSize;

@synthesize muiPallete;

@dynamic mOption;


//////////////////////////////////////////////////////////////////////        [ MNObject ]
#pragma mark - 생성자, 소멸자. 
-(id)init
{ // 쓸일 없슴.
    self = [super init];
    [self initial___MNObject];
    return self;
}

-(void)dealloc
{
    //if (arrTouchMovObj) [arrTouchMovObj release];
}

-(void)initial___MNObject // *** PRIVATE ***
{ // SuperLayer 설정 안됬슴..
    dicObjects = [[NSMutableDictionary alloc] init];
    arrTouchPoints = [[NSMutableArray alloc] init] ;

    // Sketch Related... 
    muiPallete = [[MNPaintView alloc] initWithFrame:muiView.bounds];
                  //CGRectMake(0, 0, mOption.mgoWidth, mgoHeight)];
    //  muiPallete.hidden = NO;
    muiPallete.opaque = 0.5;
    [muiView addSubview:muiPallete];

    // arrObjectSet //
    arrObjSet = 
    [NSArray arrayWithObjects:            

     [[ANObjectSet alloc] initWithGenClass:nil typeOf:0 
                                displayCls:[MNPencil class] typeOf:PENCIL_ANM_NORMAL
                                  tmpClass:nil typeOf:0 view:muiView ],

     [[ANObjectSet alloc] initWithGenClass:nil typeOf:0
                                displayCls:[MNPencil class] typeOf:PENCIL_ANM_STROKE
                                  tmpClass:nil typeOf:0 view:muiView ],
    
     [[ANObjectSet alloc] initWithGenClass:nil typeOf:0
                                displayCls:[MNPencil class] typeOf:PENCIL_ANM_BOLD
                                  tmpClass:nil typeOf:0 view:muiView ],

     [[ANObjectSet alloc] initWithGenClass:nil typeOf:0 
                                displayCls:[ANThickline class] typeOf:TL_GRASS
                                  tmpClass:nil typeOf:0 view:muiView ],
                 /*
        [[ANObjectSet alloc] initWithGenClass:nil displayCls:[HtSimpleHair class]  
                                     tmpClass:nil withType:@"Hair#Moderate" view:muiView],
        [[ANObjectSet alloc] initWithGenClass:nil displayCls:[HtSimpleHair class]  
                                     tmpClass:nil withType:@"Hair#Crazy" view:muiView],
        [[ANObjectSet alloc] initWithGenClass:nil displayCls:[HtGlasses class]  
                                     tmpClass:nil withType:@"Glasses" view:muiView],
        [[ANObjectSet alloc] initWithGenClass:nil displayCls:nil 
                                     tmpClass:[HtSnow class] withType:@"Snow" view:muiView],
        [[ANObjectSet alloc] initWithGenClass:nil displayCls:nil  
                                     tmpClass:[HtShape class] withType:@"Heart" view:muiView],
        [[ANObjectSet alloc] initWithGenClass:nil displayCls:nil
                                     tmpClass:[HtShape class] withType:@"Devil" view:muiView],
        [[ANObjectSet alloc] initWithGenClass:nil displayCls:nil
                                     tmpClass:[HtShape class] withType:@"Butterfly" view:muiView],
                  */
        nil];
    
    muiCurObjSet = [arrObjSet objectAtIndex:0]; // 디폴트 객체. Hair # Moderate
    manUIObj = nil; //[[ANObject alloc] init];
    manCornerObj = nil; 

    // GNObject Array
    NSMutableArray *newArr = [[NSMutableArray alloc] init];
    [dicObjects setObject:newArr forKey:@"GNObject"];
        
    // HtSnow Array
    newArr = [[NSMutableArray alloc] init];
    [dicObjects setObject:newArr forKey:@"ANObject"];
    
    mstLock = [[NSLock alloc] init];
    mitCounter = 0;
}

-(id)initWithView:(UIView *)pView nOption:(ANOption *)pOption
{
    self = [super init];
    mOption = pOption;
    muiView = pView;
    if (mOption.mblIsItPAD) mflBaseSize = 100;
    else mflBaseSize = 50;
    
    [self initial___MNObject];
    [dicObjects setObject:muiView.layer forKey:@"SuperLayer"]; 
    // dicDisplay에는 super정보 없음.

    // 타이머 세팅... 스타트..
    mtmTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self 
                                              selector:@selector(timerFireMethod:) 
                                              userInfo:nil repeats:YES];
    [self cornerObject___Manage];
    return self;
}



//////////////////////////////////////////////////////////////////////        [ MNObject ]
#pragma mark - Timer related methods.

-(void)timerStop // 현재 안 쓰임..
{
    [mtmTimer invalidate];    
    if ([mtmTimer isValid]) {
        NSLog(@"*** ERROR ***  The Timer is not Stopped !!!!!!!!!   *** ERROR ***");
    }
}

//////////////////////////////////////////////////////////////////////        [ MNObject ]
-(void)timerFireMethod:(NSTimer*)pTimer
{
    [mstLock lock];
    //NSString *cnt = [NSString stringWithFormat:@"cnt::%d", mitCounter];
    //[self logMethodMark:@"MNObject#timerFireMethod" andComment:cnt isStart:YES];
    mitCounter++;
    
    [self boundary___Check]; // 범위 밖의 것들은 끈다...
    [self checkArray___Num];
    
    //NSLog(@"    ANObject count %d", [[dicObjects objectForKey:@"ANObject"] count]  );
    
    NSMutableArray *curArr;
    
    [self set___JobNum];
    mitJobCnt = 0;
    
    //NSLog(@"mitJobNum is %d", mitJobNum);
    
    switch (mitCounter % 2) {
        case 0:
            if (mitJobNum) {  // 적어도 3이상임...
                [self kill___ANObjects];
            }
            break;
        case 1:
            curArr = [dicObjects objectForKey:@"GNObject"];
            break;
        default:
            break;
    }
    [mstLock unlock];
}


-(void)checkArray___Num // *** PRIVATE ***
{ // 객체가 너무 많아지는 것을 방지.
    NSMutableArray *curArr;
    curArr = [dicObjects objectForKey:@"GNObject"];
    int glassN, moderateN, crazyN, heartN;
    glassN = moderateN = crazyN = heartN = 0;
    
    for (int i=0; i<curArr.count; i++) {
        ANObject *curObj = [curArr objectAtIndex:i];
        
        if ( [curObj class] == [HtGlasses class ]) {
            glassN++;
            if (glassN > HT_MAX_GLASSES) {
                //[curArr stopAndKillSingleObject:[HtGlasses class]];
                return;
            } 
        }
        if ( [curObj class] == [HtSimpleHair class ]) {
            if (curObj.mitType == HAIR_MODERATE) {
                if (moderateN++ > HT_MAX_HAIR_MODERATE) {
                    //[curArr stopAndKillSingleObjectOfType:@"Moderate"];
                }
            } else {
                if (crazyN++ > HT_MAX_HAIR_CRAZY) {
                    //[curArr stopAndKillSingleObjectOfType:@"Crazy"];
                }
            }
        }
        if ( [curObj class] == [HtShape class ]) {
            if (heartN++ > 2) 
                NSLog(@"Nothing to log...");//[curArr stopAndKillSingleObject:[HtShape class]];
        }
    }
}


//////////////////////////////////////////////////////////////////////        [ MNObject ]
# pragma mark - Objects kill...

-(void)set___JobNum  // *** PRIVATE ***
{
    NSMutableArray *curArr = [dicObjects objectForKey:@"ANObject"];

    int count = 0;
    for (int i=0; i<curArr.count; i++) {
        ANObject *curObj = [curArr objectAtIndex:i];        
        if (!curObj.mblShow) // 갯수를 헤아림...
            count++;
    }
    
    if (0 < count && count < 20) {
        mitJobNum = 1;
        return;
    }
    mitJobNum = (int)(float)(count * 0.1);
}


-(void)boundary___Check  // *** PRIVATE ***
{
    float minX = mflBaseSize, minY = mflBaseSize, 
        maxX = mOption.mgScreenHeight - mflBaseSize, 
        maxY = mOption.mgScreenWidth - mflBaseSize;
    int jobCount = 0;

    NSMutableArray *curArr = [dicObjects objectForKey:@"ANObject"];    
    for (int i=0; i<curArr.count; i++) {
        if (jobCount > 10) return; // 한번에 10개 이상은 처리 안함...
        ANObject *curObj = [curArr objectAtIndex:i];
        
        if (!curObj.mblShow) continue; // 이미 Show를 꺼버린/안보이는 객체..
        if (!curObj.mlaBase) continue;
        
        CGPoint curPo = [[curObj.mlaBase presentationLayer] position];
        if (curPo.x < minX || curPo.x > maxX || curPo.y < minY || curPo.y > maxY ) 
        { // 범위를 넘어서면 일단 아니마는 제거.
            
            NSLog(@"Boundary Check ... Out of Boundary !!!!");
            [curObj removeAllAnimationsTimers];
            jobCount++;
        }
    }
    
}


-(void)kill___ANObjects  // *** PRIVATE ***
{
    NSMutableArray *curArr = [dicObjects objectForKey:@"ANObject"];
    NSLog(@" ### kill___ANObjects curArr.count is %d, JobCnt %d, JobNum %d", 
          curArr.count, mitJobCnt, mitJobNum);
    
    for (int i=0; i<curArr.count; i++) {
        ANObject *curObj = [curArr objectAtIndex:i];
        //[curObj logRetainCount:@" <<<<  timerFireMethod  >>>> " withSpace:2];
        
        if (!curObj.mblShow) { // 이미 Show를 꺼버린/안보이는 객체..

            NSLog(@"Removing....");
            [curArr removeObject:curObj];
            NSLog(@"Removing.... Finished");

            mitJobCnt++;
            if (mitJobCnt < mitJobNum) {
                
                NSLog(@"Inner Loop call interation....");
                [self kill___ANObjects];
                return;
            }
        }
    }
    
}


//////////////////////////////////////////////////////////////////////        [ MNObject ]
# pragma mark - Model Methods..

-(void)generate___ANObjectsAt:(CGPoint)pPosition   // *** PRIVATE ***
{    
    ANObject *newObj = [muiCurObjSet newTempObj];
    if (newObj == nil) return;
    
//    newObj.mstMode = [muiCurObjSet getMode];
//    newObj.mstType = [muiCurObjSet getObject];
    newObj.mgoHeight = newObj.mgoWidth = mflBaseSize * 0.25;
    [newObj putAt:pPosition nSuperLa:(CAShapeLayer*)muiView.layer];
    
    //////////////////////////////////////////////////  Rotation Anima
    [newObj animaRotationSnow];

    //////////////////////////////////////////////////  Falling Anima
    CGPoint endPo = CGPointMake([self getAround:mOption.mgScreenWidth*1.2 anySign:NO], 
                                [self getAround:mOption.mgScreenHeight*1.2 anySign:NO]);
    [newObj animaFallingSnowFrom:pPosition endsAt:endPo];
    
    NSMutableArray* curArr = [dicObjects objectForKey:@"ANObject"];
    [curArr addObject:newObj];
}


-(void)generate___HairObjectIsCrazy:(_Bool)pIsCrazy isCorner:(_Bool)pCorner   // *** PRIVATE ***
{
    NSMutableArray *touchPoArr;
    float mode; NSString *strType;
    
    //NSString *objType = muiCurObjSet.muiObjType;  /// "Hair#Moderate"
    NSString *sMode = @"Moderate"; // [muiCurObjSet getMode];
    
    if ( [sMode isEqualToString:@"Moderate"]) 
    { mode = 0.2; strType = @"Moderate"; }
    else { mode = 0.9; strType = @"Crazy"; } 
    
    if (pCorner) { // 터치 포이트 할당. / 가상 생성...
        touchPoArr = [NSMutableArray arrayWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(50,  50) ],
                      [NSValue valueWithCGPoint:CGPointMake(50, 100) ],
                      [NSValue valueWithCGPoint:CGPointMake(50, 150) ], nil];
    } else { touchPoArr = arrTouchPoints; }
    
    HtSimpleHair *newHair = [[HtSimpleHair alloc] initWithPoints:touchPoArr 
                                nSuperLa:(CAShapeLayer*)muiView.layer   // 생성...
                                withMode:mode];

    // newHair.mitType = strType; ???
    
    if (!pCorner) { // 어레이에 추가. 
        NSMutableArray *gnArr = [dicObjects objectForKey:@"GNObject"];    
        [gnArr addObject:newHair];
    } else { manCornerObj = newHair; }
    
    arrTouchPoints = [[NSMutableArray alloc] init];
    
    //[newHair markPointsAndIsAnimaBezier:YES]; //디버깅용.. 컨트롤 포인트 출력.

}


//////////////////////////////////////////////////////////////////////        [ MNObject ]
# pragma mark - UI/UX Touches..

-(void)cornerObject___Manage  // *** PRIVATE ***
{ // 처음에도 한번 실행됨..
    /*CGPoint tch1po, tch2po;
    
    if  (manCornerObj) {  
        [manCornerObj removeAllAnimationsTimers];
    }
    
    NSString* strObject = [muiCurObjSet getObject], *strMode;
    
        
        
    if ( [strObject isEqualToString:@"Hair"] ) {
        strMode = [muiCurObjSet getMode];
        if (strMode == @"Moderate")
            [self generate___HairObjectIsCrazy:NO isCorner:YES];
        else
            [self generate___HairObjectIsCrazy:YES isCorner:YES];
    } else if ([strObject isEqualToString: @"Glasses"]) {
        tch1po = CGPointMake(20, 50);
        tch2po = CGPointMake(200, 50);
        HtGlasses *glasObj = [[HtGlasses alloc] initWithInitPoint:tch1po andPoint:tch2po 
                                                    andSuperLayer:muiView.layer];
        [glasObj drawUIGlasses:tch1po andPoint:tch2po];  // 두점에 상응하는 베지어 그리기...
        manCornerObj = glasObj;        
    } else if ([strObject isEqualToString: @"Snow"] ) {
        manCornerObj = [[HtSnow alloc] init] ;        
        manCornerObj.mgoHeight = manCornerObj.mgoWidth = mflBaseSize * 0.4;
        [manCornerObj putAt:CGPointMake(50, 50) nSuperLa:(CAShapeLayer*)muiView.layer];
        [manCornerObj animaRotation4key:@"Vanish" delegateObj:self 
                                howMany:10 duration:10. type:@"Snow" axis:@"z" autoReverse:NO];
        [manCornerObj vanishWithKey:@"Vanish" delegateObj:manCornerObj];
    } else if ([strObject isEqualToString: @"Heart"] ) {
        manCornerObj = [[HtShape alloc] init] ;        
        manCornerObj.mgoHeight = manCornerObj.mgoWidth = mflBaseSize * 0.4;
        [manCornerObj putAt:CGPointMake(50, 50) nSuperLa:(CAShapeLayer*)muiView.layer];
        [manCornerObj vanishWithKey:@"Vanish" delegateObj:manCornerObj];
    } else if ([strObject isEqualToString: @"Devil"] ) {
        manCornerObj = [[HtShape alloc] init];
        manCornerObj.mblRandom = YES;
        manCornerObj.mgoHeight = manCornerObj.mgoWidth = mflBaseSize * 0.4;
        [manCornerObj putAt:CGPointMake(50, 50) nSuperLa:(CAShapeLayer*)muiView.layer];
        [manCornerObj vanishWithKey:@"Vanish" delegateObj:manCornerObj];
    } else if ([strObject isEqualToString: @"Butterfly"] ) {

        ;
    }*/
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mstLock lock];
    NSLog(@"touches began started");
    
    [super touchesBegan:touches withEvent:event];

    NSMutableArray* curArr = [dicObjects objectForKey:@"ANObject"];

    // Temp Object Process
    ANObject *newTmpObj = [muiCurObjSet newTempObj];
    if (newTmpObj) {
        [newTmpObj touchProcess:[[arrTouchPoints objectAtIndex:0] CGPointValue]
                     nSuperView:muiView]; // 터치 프로세스..
        [curArr addObject:newTmpObj];
    }
    
    [mstLock unlock];
    return;
    
    
    
    
    
    //Class curClass = [mOption.manTouchMoveObj class];
    
    //Class tempClass = muiCurObjSet.muiTmpObj; // 잠깐 보여지고 사라지는 객체 (눈)
    Class curClass = muiCurObjSet.muiDspObj;

    NSSet *allTouches = [event allTouches];
    int touchCnt = [allTouches count];
    muiTouchNum = 0; // 터치 갯수 초기화.
    
    [muiCurObjSet.mojDisplay touchesBegan:touches withEvent:event];
    [muiCurObjSet.mojGenerate touchesBegan:touches withEvent:event];
    [muiCurObjSet.mojTemp touchesBegan:touches withEvent:event];
        
    //////////////////////////////////////////////////  Glasses :: Multi(double) Touched
    if (curClass == [HtGlasses class]) {
        if (touchCnt == 2)
        {
            CGPoint tch1po = [ [[allTouches allObjects] objectAtIndex:0] locationInView:muiView];
            CGPoint tch2po = [ [[allTouches allObjects] objectAtIndex:1] locationInView:muiView];
            
            // manUIObj 초기화, 생성.. 
            if (manUIObj) {
                [manUIObj removeAllAnimationsTimers]; // 기존에 그려진 안경 아니마 스탑..
            }
            manUIObj = [[HtGlasses alloc] initWithInitPoint:tch1po andPoint:tch2po 
                                              andSuperLayer:muiView.layer];
        }
        [mstLock unlock];  // 탭 1일때 그냥 리턴..
        return;
    }
    
    UITouch *curTouch = [touches anyObject];
    CGPoint curPo =  [curTouch locationInView:muiView]; // Touched Coordinates
    
    // Hair Case
    if (curClass == [HtSimpleHair class] ) {
        if (arrTouchPoints.count > 0) {
            arrTouchPoints = [[NSMutableArray alloc] init];
        }        
        [arrTouchPoints addObject:[NSValue valueWithCGPoint:curPo]]; // 첫 점 추가..
    } else {
        [self generate___ANObjectsAt:curPo];
    }
    
    //NSLog(@"touches began ended ~~~~~ ~~~~~ ~~~~~ ~~~~~ ~~~~~");    
    [mstLock unlock];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mstLock lock];
    //NSLog(@"MNObject # touches Moved started");
    
    [super touchesMoved:touches withEvent:event]; // [ANObject touchesMove....]
    NSMutableArray* curArr = [dicObjects objectForKey:@"ANObject"];
    
    // Temp Object Process
    ANObject *newTmpObj = [muiCurObjSet newTempObj];
    if (newTmpObj) {
        for (UITouch *touch in touches) {
            CGPoint curPo = [touch locationInView:muiView];
            [newTmpObj touchProcess:curPo nSuperView:muiView]; // 터치 프로세스..
            [curArr addObject:newTmpObj];
        }
    }

    [mstLock unlock];
    return;

    
    
    
    

    // Enumerates through all touch objects    
    
    Class curClass = muiCurObjSet.muiDspObj;

    NSSet *allTouches = [event allTouches];
    int touchCnt = [allTouches count];

    //////////////////////////////////////////////////  Glasses
    if (touchCnt == 2 && curClass == [HtGlasses class])
    { // 초기점 세팅..
        CGPoint tch1po = [[[allTouches allObjects] objectAtIndex:0] locationInView:muiView];
        CGPoint tch2po = [[[allTouches allObjects] objectAtIndex:1] locationInView:muiView];
        //NSLog(@"Glass Case... 2 touches Moving ...[%f,%f], [%f,%f]", tch1po.x, tch1po.y, tch2po.x, tch2po.y);

        HtGlasses* glasObj = (HtGlasses*) manUIObj;
        //NSLog(@"Type Casting to Glass Object");
        
        [glasObj drawUIGlasses:tch1po andPoint:tch2po];  // 두점에 상응하는 베지어 그리기...
        
        [mstLock unlock]; return;
    }
    
	for (UITouch *touch in touches) {
        CGPoint curPo = [touch locationInView:muiView];

        
        //////////////////////////////////////////////////  Hair
        if (curClass == [HtSimpleHair class] ) 
        {
            [arrTouchPoints addObject:[NSValue valueWithCGPoint:curPo]]; // 단지 점만 추가.
            NSLog(@"Point added.. in touchesMoved");
            continue;
        }
        
        [self generate___ANObjectsAt:curPo];
    }
    
    NSLog(@"touches Moved ended ~~~~~ ~~~~~ ~~~~~ ~~~~~ ~~~~~");    
    [mstLock unlock];
}

-(void)touchesEndedMN:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mstLock lock];
    NSLog(@"touches Ended started");
    
    [super touchesEnded:touches withEvent:event]; // 우선. 터치 포인트 어레이에 담기 완료.

    // GNObject 생성..
    id newObj = [muiCurObjSet.mojDisplay touchProcessWithObject:self wOption:nil]; // pencil
    NSMutableArray *gnArr = [dicObjects objectForKey:@"GNObject"];
    [gnArr addObject:newObj]; // 추가.
    
    //[muiCurObjSet.mojGenerate touchesBegan:touches withEvent:event];
    //[muiCurObjSet.mojTemp touchesBegan:touches withEvent:event];
        
    [muiPallete clearDrawing];
    
    // 더블 터치 등 처리...
    for (UITouch *touch in touches){
        if (touch.tapCount >= 2) { // 더블 터치...
            NSLog(@"\n\n\n WWWWWWWWWWWWW    Double Touched    WWWWWWWWWWWWW");
            
            //[self performSelector4ObjectsInDisplay:@selector(stopAllAnima)]; ??
            
            // 더블 터치 경우...  객체를 바꿈..
            muiCurObjSet = [arrObjSet nextObjectOf:muiCurObjSet]; // Next...
            [self cornerObject___Manage];
        }
    }

    [mstLock unlock];
    return;

    
    
    
    
    
    Class curClass = muiCurObjSet.muiDspObj;
    

    //////////////////////////////////////////////////  Hair Case
    if (curClass == [HtSimpleHair class] && arrTouchPoints.count > 10) { // 헤어 케이스. 
        NSString *mode = @"Moderate"; //[muiCurObjSet getMode];
         if (mode == @"Moderate") { 
            [self generate___HairObjectIsCrazy:NO isCorner:NO];
        }
        else { 
            [self generate___HairObjectIsCrazy:YES isCorner:NO];
        }
    }
    //////////////////////////////////////////////////  Glasses ::     
    if (curClass == [HtGlasses class] ) //&& touchCnt == 2) // touchCnt를 멤버 변수에서 제외.
    { // 객체를 이미 생성했다. Mutli(double)Touched.. already  사용후 삭제/초기화.
        HtGlasses *obj = (HtGlasses*) manUIObj;
        [obj fixPositionAndStartAnimations];  // 고정...
        
        [obj animaLineWidthFromV:15 toV:40 forKey:@"lineWidth" 
                         howMany:4 duration:2 autoReverse:YES];
        [obj animaFrameColorFrom:(id)[UIColor cyanColor].CGColor toV:nil 
                          forKey:@"FrameColor" howMany:2 duration:2 autoReverse:YES];
        
        [[dicObjects objectForKey:@"GNObject"] addObject:obj]; // Add Array
        manUIObj = nil;
    }
        NSLog(@"touches Ended ended ~~~~~ ~~~~~ ~~~~~ ~~~~~ ~~~~~");    
    [mstLock unlock];
}


//////////////////////////////////////////////////////////////////////        [ MNObject ]
#pragma mark - Animations.
-(void)performSelector4ObjectsInDisplay:(SEL)aSelector
{
    NSLog(@"performSelector4ObjectsInDisplay  ========");
    [mstLock lock];
    for (id mem in dicObjects) {
        id object = [dicObjects objectForKey:mem];
        if ([object isKindOfClass:[CALayer class]]) {
            NSLog(@"Error :: No Lyaer in dicDisplay !!! ");
            continue;
        }
        //if ([object isKindOfClass:[NSMutableArray class]]) {
            //for (id obj in object) {
                //obj = (ANObject*)obj; // ANObject
                //[obj performSelector:aSelector];
            //}
        //}
    }    
    [mstLock unlock];
    NSLog(@"performSelector4ObjectsInDisplay  ~~~~~~~~");    
}

/*
-(void)animationStopOrRestart:(_Bool)pStop  // *** PRIVATE ***
{
    for (id mem in dicObjects) {
        id object = [dicObjects objectForKey:mem];
        if ([object isKindOfClass:[CALayer class]]) continue;
        if ([object isKindOfClass:[NSMutableArray class]]) {
            for (id obj in object) {
                obj = (ANObject*)obj; // ANObject
                CALayer *theLay = [obj mlaBase];
                if (pStop)  [theLay stopAnima];
                else        [theLay restartAnima];
            }
        }
    }
}*/


@end


//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////        [ MNObject ]