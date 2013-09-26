//
//  ComDetailViewController.h
//  ForgeryProof
//
//  Created by haoyl on 13-9-17.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "CustomViewController.h"

@interface ComDetailViewController : CustomViewController <ASIHTTPRequestDelegate>
{
    NSString *_comId;
    UIActivityIndicatorView *_actView;
}

@property (nonatomic, copy) NSString *comId;
@property (nonatomic, retain) IBOutlet UILabel *labelComName;
@property (nonatomic, retain) IBOutlet UILabel *labelProName;

- (void)didFinishCallBack:(ASIHTTPRequest *)request;
- (void)didFailCallback:(ASIHTTPRequest *)request;

- (IBAction)backAction;

@end
