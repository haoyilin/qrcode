//
//  CustomViewController.m
//  youku
//
//  Created by yukuai on 13-3-11.
//  Copyright (c) 2013年 Tian Tian Tai Mei Net Tech (Bei Jing) Lt.d. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

#pragma mark - 通过继承使子类注册 滑动手势操作

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}

- (id)init
{
    if (self = [super init])
    {

    }
    
    return self;
}

- (void)viewDidLoad
{
    [self swipRegister];
    
    [self disableMultipleTouch:self.view];
    
    [super viewDidLoad];
}

- (void)swipRegister
{
    UISwipeGestureRecognizer *swipRight = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction:)] autorelease];
    [swipRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipRight];
    
    UISwipeGestureRecognizer *swipLeft = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction:)] autorelease];
    [swipLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer *swipUp = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction:)] autorelease];
    [swipUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:swipUp];
    
    UISwipeGestureRecognizer *swipDown = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction:)] autorelease];
    [swipDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipDown];
}

#pragma mark - 禁用多点触摸

- (void)disableMultipleTouch:(UIView *)view
{
	[view setMultipleTouchEnabled:NO];
	[view setExclusiveTouch:YES];
	
    for (int i = 0; i < [[view subviews] count]; i ++) {
		[self disableMultipleTouch:[[view subviews] objectAtIndex:i]];
	}
}


#pragma mark - 滑动手势实现
//
//- (void)swipGestureLeft:(id)sender
//{
//    if ([sender direction] == UISwipeGestureRecognizerDirectionRight)
//    {
//        [self swipRight];
//    }
//    if ([sender direction] == UISwipeGestureRecognizerDirectionDown)
//    {
//        [self swipDown];
//    }
//    if ([sender direction] == UISwipeGestureRecognizerDirectionUp)
//    {
//        [self swipUp];
//    }
//    if ([sender direction] == UISwipeGestureRecognizerDirectionLeft)
//    {
//        [self swipLeft];
//    }
//}

- (void)swipAction:(id)sender
{
    if ([sender direction] == UISwipeGestureRecognizerDirectionRight)
    {
        [self swipRight];
    }
    if ([sender direction] == UISwipeGestureRecognizerDirectionDown)
    {
        [self swipDown];
    }
    if ([sender direction] == UISwipeGestureRecognizerDirectionUp)
    {
        [self swipUp];
    }
    if ([sender direction] == UISwipeGestureRecognizerDirectionLeft)
    {
        [self swipLeft];
    }
}

- (void)swipRight
{
//    [self.navigationController popViewControllerAnimated:YES];
//    [[CustomASIHttpRequestController sharedInstance] clearRequest:_currentRequest];
    //custom
}

- (void)swipDown
{

}

- (void)swipLeft
{
    
}

- (void)swipUp
{
    
}

- (void)dataSource:(id)data
{
    //custom 
}

#pragma mark - 结束

- (void)dealloc
{
    [[CustomASIHttpRequestController sharedInstance] clearRequest:_currentRequest];
    [[CustomASIHttpRequestController sharedInstance] cancelOperationForDelegate:self];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
