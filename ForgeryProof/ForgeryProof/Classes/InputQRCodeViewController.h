//
//  InputQRCodeViewController.h
//  ForgeryProof
//
//  Created by haoyl on 13-9-15.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "CustomViewController.h"

@interface InputQRCodeViewController : CustomViewController <ASIHTTPRequestDelegate, UITextFieldDelegate>
{
    NSMutableArray *_arrayDataSource;    
    UIActivityIndicatorView *_actView;
    UISearchBar *_seachBar;
    
    IBOutlet UITextField *_textFieldKey;
    IBOutlet UILabel *_labelProName;
    IBOutlet UILabel *_labelComName;
    IBOutlet UILabel *_labelContent;
    IBOutlet UIView *_viewResult;
}

- (IBAction)seachAction;
- (IBAction)closeAction;

- (void)textFieldDidBeginEditing:(UITextField *)textField;  
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

- (void)didFinishCallBack:(ASIHTTPRequest *)request;
- (void)didFailCallback:(ASIHTTPRequest *)request;

- (IBAction)backAction;

@end
