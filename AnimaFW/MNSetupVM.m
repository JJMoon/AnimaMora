//
//  MNSetupVM.m
//  ObjectPainter
//
//  Copyright (c) 2012년 jongwoomooon@gmail.com All rights reserved.
//
//  mit : integer       mfo : float         mbl : bool      mgo : geometry
//  arr : array         dic : dictionary    mst : state
//  mdd : distance      man : ANima         mla : Layer     
//  mht : hansoo term   mgn : generator     mgc : graphics
//  AN : Anima          HT : HT Object      GN : Generator  MG : Manager
//


#import "MNSetupVM.h"

#import "ANOption.h"


//////////////////////////////////////////////////////////////////////       [ MNSetupVM ]
# pragma mark - MNSetupVM Implementation   Private methods
@interface MNSetupVM()

//-(void)initialANBeziers;
-(void)drawButtons; // *** PRIVATE ***



@end



//////////////////////////////////////////////////////////////////////       [ MNSetupVM ]
@implementation MNSetupVM
//////////////////////////////////////////////////////////////////////////////////////////

-(void)drawButtons // *** PRIVATE ***
{
    
    //float width = mOption.mgScreenWidth;
    float heigt = mOption.mgScreenHeight;
    float bigger = [mOption getBiggerLengthOfScreen];
    float bttnDim = bigger * 0.25; // 3 buttons = 0.75 width..
    
    float edge = 0.25 / 4 * bigger;
    float bttnHeit = heigt * 0.25;
    float edgeH = 0.1 * bttnHeit;
    
    float x1s = edge, x1e = x1s + bttnDim;
    float x2s = x1e + edge, x2e = x2s + bttnDim;
    float x3s = x2e + edge, x3e = x2s + bttnDim;
    
    float y1s = heigt * 0.3, y1e = y1s + bttnHeit;
    float y2s = y1e + edgeH, y2e = y2s + bttnHeit;

    CALayer *bttn1, *bttn2, *bttn3, *bttn4, *bttn5, *bttn6;
    
    bttn1 = [CALayer layer]; bttn1.frame = CGRectMake(x1s, y1s, x1e, y1e);
    bttn2 = [CALayer layer]; bttn2.frame = CGRectMake(x2s, y1s, x2e, y1e);
    bttn3 = [CALayer layer]; bttn3.frame = CGRectMake(x3s, y1s, x3e, y1e);
    bttn4 = [CALayer layer]; bttn4.frame = CGRectMake(x1s, y1s, x1e, y2e);
    bttn5 = [CALayer layer]; bttn5.frame = CGRectMake(x2s, y1s, x2e, y2e);
    bttn6 = [CALayer layer]; bttn6.frame = CGRectMake(x3s, y1s, x3e, y2e);
    
    bttn1.backgroundColor = [UIColor yellowColor].CGColor;
    bttn2.backgroundColor = [UIColor greenColor].CGColor;
    bttn3.backgroundColor = [UIColor magentaColor].CGColor;
    bttn4.backgroundColor = [UIColor grayColor].CGColor;
    bttn5.backgroundColor = [UIColor blueColor].CGColor;
    bttn6.backgroundColor = [UIColor redColor].CGColor;
    
    bttn1.opacity = bttn2.opacity = bttn3.opacity = 
    bttn4.opacity = bttn4.opacity = bttn6.opacity = 0.3;

    [self.muiView.layer addSublayer:bttn1];
    [self.muiView.layer addSublayer:bttn2];
}


@end



//3456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//////////////////////////////////////////////////////////////////////       [ MNSetupVM ]