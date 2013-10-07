//
//  TakePhotoQRCodeViewController.h
//  ForgeryProof
//
//  Created by haoyl on 13-9-15.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "CustomViewController.h"

@interface TakePhotoQRCodeViewController : CustomViewController <ZBarReaderDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIActivityIndicatorView *_actView;
    
    IBOutlet UILabel *_labelProName;
    IBOutlet UILabel *_labelComName;
    IBOutlet UILabel *_labelContent;
    IBOutlet UIView *_viewResult;
}

- (IBAction)backAction;

@end
