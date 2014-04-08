//
//  APViewController.h
//  AnimaPainter
//
//  Created by Ryan Moon on 12. 3. 2..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANObject.h"

//@class OPSettingVC;
@class MNObject;
@class ANOption;

@interface APViewController : UIViewController <UIImagePickerControllerDelegate>
{
    ANOption *appOption;
    
    UIImageView *muiImageView;
    UIImagePickerController *muiImagePickCtrl;
    UIPopoverController *muiPopOver;
}

@property (strong) MNObject *mManager;
@property (strong) ANOption *appOption;

@property (nonatomic, retain) UIImageView *muiImageView;

@property (nonatomic, retain) UIImagePickerController *muiImagePickCtrl;
@property (nonatomic, retain) UIPopoverController *muiPopOver;

//@property (assign) OPSettingVC *mSettingVC;
@property (assign) int mstMode;

//@property (strong) NSArray *arrTest;



@end
