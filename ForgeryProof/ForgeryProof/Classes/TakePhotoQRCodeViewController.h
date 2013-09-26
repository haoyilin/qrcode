//
//  TakePhotoQRCodeViewController.h
//  ForgeryProof
//
//  Created by haoyl on 13-9-15.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "CustomViewController.h"

@interface TakePhotoQRCodeViewController : CustomViewController <ZBarReaderDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (IBAction)backAction;

@end
