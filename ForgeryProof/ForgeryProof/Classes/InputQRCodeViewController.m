//
//  InputQRCodeViewController.m
//  ForgeryProof
//
//  Created by haoyl on 13-9-15.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "InputQRCodeViewController.h"
#import "Common.h"

@interface InputQRCodeViewController ()

@end

@implementation InputQRCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _actView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    [_actView setCenter:CENTER_POINT];
    [self.view addSubview:_actView];
    
    _arrayDataSource = [[NSMutableArray alloc] init];
    
    [_viewResult setHidden:YES];
}

- (void)didFinishCallBack:(ASIHTTPRequest *)request
{
    [_actView stopAnimating];
    NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"result : %@",dicResult);

    if ([Common exsitKey:@"result" inDic:dicResult])
    {
        NSDictionary *dicTemp = [[dicResult objectForKey:@"result"] objectAtIndex:0];
        [_labelProName setText:[dicTemp objectForKey:@"pro_name"]];
        [_labelComName setText:[dicTemp objectForKey:@"pro_name"]];
        [_labelContent setText:[[@"说明：此产品是" stringByAppendingString:[dicTemp objectForKey:@"pro_name"]] stringByAppendingString:@"公司生产的正品，请放心使用。"]];
        [_viewResult setHidden:NO];
    }
    else
    {
        [Common alert:@"查无此产品。"];
    }

}

- (void)didFailCallback:(ASIHTTPRequest *)request
{
    [_actView stopAnimating];
    NSLog(@"didFailCallback %@",request.error);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textFieldKey resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textFieldKey resignFirstResponder];
    return true;
}

- (IBAction)seachAction
{
    if ([_textFieldKey.text isEqualToString:@""] || _textFieldKey.text  == nil)
    {
        [Common alert:@"请输入防伪码！"];
        return;
    }
    
    NSDictionary *dicInquire = [NSDictionary dictionaryWithObjectsAndKeys:@"inquire", @"command", _textFieldKey.text, @"serialnumber", @"1", @"class", nil];
    
    _currentRequest = [[CustomASIHttpRequestController sharedInstance] requestNormalTag:e_inquire dicValue:dicInquire delegate:self finishSelector:@selector(didFinishCallBack:) failSelector:@selector(didFailCallback:) currentRequest:_currentRequest];
    
    [_actView startAnimating];
}

- (IBAction)closeAction
{
    [_labelProName setText:@""];
    [_labelComName setText:@""];
    [_labelContent setText:@""];

    [_viewResult setHidden:YES];
}

- (IBAction)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)swipRight
{
    [self backAction];
}

- (void)dealloc
{
    [super dealloc];
    [_arrayDataSource release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
