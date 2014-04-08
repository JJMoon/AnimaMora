//
//  APViewController.m
//  AnimaPainter
//
//  Created by Ryan Moon on 12. 3. 2..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "APViewController.h"

#import "MNObject.h"
#import "ANOption.h"


@implementation APViewController

@synthesize mManager, mstMode, appOption, muiImagePickCtrl, muiPopOver, 
    muiImageView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    //self.view.backgroundColor = [UIColor purpleColor];
    appOption = [[ANOption alloc] init]; // Singleton

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        appOption.mblIsItPAD = FALSE;
    } else {
        appOption.mblIsItPAD = TRUE;
    }

    // MNObject 생성, 스크린 사이즈 세팅..
    mManager = [[MNObject alloc] initWithView:self.view nOption:appOption];
    appOption.mgScreenWidth = self.view.frame.size.width;
    appOption.mgScreenHeight= self.view.frame.size.height;
    
    
    /*/ Image View 생성/어태치.. ..
    CGRect pickerFrame = CGRectMake(0, 0, appOption.mgScreenWidth,
     appOption.mgScreenHeight) ;
    muiImageView = [[UIImageView alloc] initWithFrame:pickerFrame ];
    muiImageView.hidden = YES;
    [self.view addSubview:muiImageView];        
     */
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




//////////////////////////////////////////////////////////////////////[ OPViewController ]
# pragma mark - Touches..

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{   // Generator Setting
    //NSLog(@"Touches Began =================");
    [mManager touchesBegan:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{ // touches 의 개수는 1..
    [mManager touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"Touches Ended ~~~~~~~~~~~~~~~~~");
    [mManager touchesEndedMN:touches withEvent:event];
    
    // 더블 터치 등 처리...
    for (UITouch *touch in touches){
        if (touch.tapCount >= 3) { // 삼중 터치...
            muiImagePickCtrl = [[UIImagePickerController alloc] init];
            muiImagePickCtrl.allowsEditing = YES;
            muiImagePickCtrl.delegate = (id)self;
            muiImagePickCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //UIImagePickerControllerSourceTypeCamera;
            //UIImagePickerControllerSourceTypePhotoLibrary;
            
            muiPopOver = [[UIPopoverController alloc] initWithContentViewController:muiImagePickCtrl];
            
            CGRect pickerFrame = CGRectMake(10, 500, 100, 100);
            //   [muiPopOver setPopoverContentSize:pickerFrame.size animated:NO];
            
            [muiPopOver presentPopoverFromRect:pickerFrame
                                        inView:self.view
                      permittedArrowDirections:UIPopoverArrowDirectionDown
                                      animated:YES];
        }
    }
    
    //[self presentModalViewController:muiImagePickCtrl animated:YES];
    //    [mManager forDebugging];
    
    /*
     for (UITouch *touch in touches){
     if (touch.tapCount >= 2) {
     // 더블 터치 경우...
     mSettingVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
     [self presentModalViewController:mSettingVC animated:YES];
     }
     
     }
     
     */    
}

-(void)imagePickerController:(UIImagePickerController *)picker 
       didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    muiImagePickCtrl.view.hidden = YES;
    muiImageView.image = image;
    muiImageView.hidden = NO;
    muiImageView.backgroundColor = [UIColor redColor];
    //[muiImageView sizeToFit];
    
    [self.view bringSubviewToFront:muiImageView];

    [picker dismissModalViewControllerAnimated:YES];
    [muiPopOver dismissPopoverAnimated:YES];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    [muiPopOver dismissPopoverAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
