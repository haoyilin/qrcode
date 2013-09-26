//
//  AppDelegate.h
//  ForgeryProof
//
//  Created by haoyl on 13-9-2.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    HylTabBarController *_tabBarController;
}

@property (strong, nonatomic) UIWindow *window;
@property(retain, nonatomic) HylTabBarController *tabBarController;

@end
