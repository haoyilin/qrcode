//
//  CustomViewController.h
//  youku
//
//  Created by yukuai on 13-3-11.
//  Copyright (c) 2013年 Tian Tian Tai Mei Net Tech (Bei Jing) Lt.d. All rights reserved.
//

#pragma mark -自定义ViewController，主要用于手势操作和多点触摸，其他所有ViewController继承此Controller

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface CustomViewController : UIViewController <ASIHTTPRequestDelegate>
{
    ASIFormDataRequest *_currentRequest;
}

- (void)swipRight;
- (void)swipDown;
- (void)swipLeft;
- (void)swipUp;

- (void)dataSource:(id)data;

@end


