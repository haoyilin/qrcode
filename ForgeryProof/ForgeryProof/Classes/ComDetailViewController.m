//
//  ComDetailViewController.m
//  ForgeryProof
//
//  Created by haoyl on 13-9-17.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "ComDetailViewController.h"
#import "Common.h"

@interface ComDetailViewController ()

@end

@implementation ComDetailViewController
@synthesize comId = _comId, labelComName, labelProName;

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

    [self requestGetComDetail];
}

- (void)requestGetComDetail
{
    NSDictionary *dicGetComIntro = [NSDictionary dictionaryWithObjectsAndKeys:@"getProduct", @"command", _comId, @"com_id", nil];
    
    _currentRequest = [[CustomASIHttpRequestController sharedInstance] requestNormalTag:e_getProduct dicValue:dicGetComIntro delegate:self finishSelector:@selector(didFinishCallBack:) failSelector:@selector(didFailCallback:) currentRequest:_currentRequest];
    
    [_actView startAnimating];
}

- (void)didFinishCallBack:(ASIHTTPRequest *)request
{
    [_actView stopAnimating];
    NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"result : %@",dicResult);
//    NSDictionary *dic =[dicResult objectForKey:@"result"];
//    if ([Common exsitKey:@"error" inDic:dic])
//    {
//        [Common alert:@"暂无数据"];
//    }
//    else
//    {
//        [labelComName setText:[dic objectForKey:@"name"]];
//        [labelProName setText:[dic objectForKey:@"introduction"]];
//    }
//    NSArray *arrayResult = [dicResult objectForKey:@"result"];
//    for (int i = 0; i < [arrayResult count]; i ++)
//    {
//        NSDictionary *dicTemp = [arrayResult objectAtIndex:i];
//        Company *com = [[Company new] autorelease];
//        [com setComId:[dicTemp objectForKey:@"com_id"]];
//        [com setComId:[dicTemp objectForKey:@"introduction"]];
//        [com setComId:[dicTemp objectForKey:@"name"]];
//        [_arrayDataSource addObject:dicTemp];
//    }
//    NSLog(@"_arrayDataSource : %@",_arrayDataSource);
}

- (void)didFailCallback:(ASIHTTPRequest *)request
{
    [_actView stopAnimating];
    NSLog(@"didFailCallback %@",request.error);
}

- (IBAction)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
