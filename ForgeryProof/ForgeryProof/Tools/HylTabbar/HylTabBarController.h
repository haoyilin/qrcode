//
//  LeveyTabBarControllerViewController.h
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHYoukuMenuView.h"
#import "HylTabBar.h"

@class UITabBarController;

@protocol HylTabBarControllerDelegate;
@interface HylTabBarController : UIViewController  <HylTabBarDelegate>//<HHYoukuMenuViewDelegate>
{
//	LeveyTabBar *_tabBar;
	UIView      *_containerView;
	UIView		*_transitionView;
	id<HylTabBarControllerDelegate> _delegate;
	NSMutableArray *_viewControllers;
	NSUInteger _selectedIndex;

	HylTabBar *_tabBar;
//    HHYoukuMenuView *_youkuMenuView;
    UIButton *_btnClose;
    
	BOOL _tabBarTransparent;
	BOOL _tabBarHidden;
}

@property(nonatomic, copy) NSMutableArray *viewControllers;

@property(nonatomic, readonly) UIViewController *selectedViewController;
@property(nonatomic) NSUInteger selectedIndex;

// Apple is readonly
//@property (nonatomic, readonly) LeveyTabBar *tabBar;
@property(nonatomic,assign) id<HylTabBarControllerDelegate> delegate;


// Default is NO, if set to YES, content will under tabbar
@property (nonatomic) BOOL tabBarTransparent;
@property (nonatomic) BOOL tabBarHidden;

- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr;

- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;

// Remove the viewcontroller at index of viewControllers.
- (void)removeViewControllerAtIndex:(NSUInteger)index;

// Insert an viewcontroller at index of viewControllers.
- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index;

@end


@protocol HylTabBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(HylTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(HylTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(HylTabBarController *)tabBarController delectedByClick:(BOOL)selectWay;
@end

@interface UIViewController (HylTabBarControllerSupport)
@property(nonatomic, retain) HylTabBarController *hylTabBarController;
@end

