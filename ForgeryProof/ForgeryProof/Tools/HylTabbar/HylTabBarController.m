//
//  HylTabBarControllerViewController.m
//  HylTabBarController
//
//  Created by Hyl Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import "HylTabBarController.h"
#import "HylTabBar.h"

#define kTabBarHeight 60

static HylTabBarController *hylTabBarController;

@implementation UIViewController (HylTabBarControllerSupport)

- (void)setHylTabBarController:(HylTabBarController *)controller
{
	hylTabBarController = controller;
}

- (HylTabBarController *)hylTabBarController
{
	return hylTabBarController;
}

@end

@interface HylTabBarController (private)
- (void)displayViewAtIndex:(NSUInteger)index;
@end

@implementation HylTabBarController
@synthesize delegate = _delegate;
@synthesize selectedViewController = _selectedViewController;
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize tabBarHidden = _tabBarHidden;

#pragma mark -
#pragma mark lifecycle
- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr;
{
	self = [super init];
	if (self != nil)
	{
		_viewControllers = [[NSMutableArray arrayWithArray:vcs] retain];
		
		_containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
		
		_transitionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, _containerView.frame.size.height)];
		_transitionView.backgroundColor =  [UIColor groupTableViewBackgroundColor];

//        _youkuMenuView = [[HHYoukuMenuView alloc] initWithFrame:[HHYoukuMenuView getFrame]];
//        _youkuMenuView.delegate = self;
        
//        _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *image = [UIImage imageNamed:@"hidemenu.png"];
//        _btnClose.frame = CGRectMake(0.0,self.view.frame.size.height - 18, 320,17);
//        [_btnClose setBackgroundImage:image forState:UIControlStateNormal];
//        [_btnClose addTarget:self action:@selector(showMeun:) forControlEvents:UIControlEventTouchDown];
        
		_tabBar = [[HylTabBar alloc] initWithFrame:CGRectMake(0, _containerView.frame.size.height - kTabBarHeight, 320.0f, kTabBarHeight) buttonImages:arr];
		_tabBar.delegate = self;
		
        hylTabBarController = self;
	}
	return self;
}

- (void)loadView 
{
	[super loadView];
	
	[_containerView addSubview:_transitionView];
	[_containerView addSubview:_tabBar];
//    [_containerView addSubview:_youkuMenuView];
	

//    [_containerView addSubview:_btnClose];
    
	self.view = _containerView;
}
- (void)showMeun:(id)sender
{
    _btnClose.hidden = YES;
//    [_youkuMenuView  showOrHideMenu];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
		
    self.selectedIndex = 0;
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	_viewControllers = nil;
}



- (void)dealloc 
{
//    [_youkuMenuView release];
    [_tabBar release];
    [_containerView release];
    [_transitionView release];
	[_viewControllers release];
    [super dealloc];
}

#pragma mark - instant methods

- (HylTabBar *)tabBar
{
    return _tabBar;
//    return _youkuMenuView;
}
- (BOOL)tabBarTransparent
{
	return _tabBarTransparent;
}
- (void)setTabBarTransparent:(BOOL)yesOrNo
{
	if (yesOrNo == YES)
	{
		_transitionView.frame = _containerView.bounds;
	}
	else
	{
		_transitionView.frame = CGRectMake(0, 0, 320.0f, _containerView.frame.size.height - kTabBarHeight);
	}
    
}
- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;
{
	if (yesOrNO == YES)
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height)
		{
			return;
		}
	}
	else 
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height - kTabBarHeight)
		{
			return;
		}
	}
	
	if (animated == YES)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3f];
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else 
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		[UIView commitAnimations];
	}
	else 
	{
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else 
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
	}
}

- (NSUInteger)selectedIndex
{
	return _selectedIndex;
}
- (UIViewController *)selectedViewController
{
    return [_viewControllers objectAtIndex:_selectedIndex];
}

-(void)setSelectedIndex:(NSUInteger)index
{
    
	if ([_delegate respondsToSelector:@selector(tabBarController:delectedByClick:)]) {
		[_delegate tabBarController:self delectedByClick:NO];
	}
//    [_tabBar selectTabAtIndex:index];	
    [self displayViewAtIndex:index];

}

- (void)removeViewControllerAtIndex:(NSUInteger)index
{
    if (index >= [_viewControllers count])
    {
        return;
    }
    // Remove view from superview.
    [[(UIViewController *)[_viewControllers objectAtIndex:index] view] removeFromSuperview];
    // Remove viewcontroller in array.
    [_viewControllers removeObjectAtIndex:index];
    // Remove tab from tabbar.
//    [_tabBar removeTabAtIndex:index];
}

- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    [_viewControllers insertObject:vc atIndex:index];
//    [_tabBar insertTabWithImageDic:dict atIndex:index];
}


#pragma mark - Private methods
- (void)displayViewAtIndex:(NSUInteger)index
{
    // Before change index, ask the delegate should change the index.
    if ([_delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) 
    {        
        if (![_delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:index]])
        {
            return;
        }
    }
    // If target index if equal to current index, do nothing.
    if (_selectedIndex == index && [[_transitionView subviews] count] != 0) 
    {
//        return;
    }
//    NSLog(@"Display View.");
    _selectedIndex = index;
    
	UIViewController *selectedVC = [self.viewControllers objectAtIndex:index];	
	selectedVC.view.frame = _transitionView.frame;
	if ([selectedVC.view isDescendantOfView:_transitionView]) 
	{
		[_transitionView bringSubviewToFront:selectedVC.view];
	}
	else
	{
		[_transitionView addSubview:selectedVC.view];
	}
    
    // Notify the delegate, the viewcontroller has been changed.
    if ([_delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) 
    {
        [_delegate tabBarController:self didSelectViewController:selectedVC];
    }
    
}

#pragma mark -
#pragma mark tabBar delegates
- (void)tabBar:(HylTabBar *)tabBar didSelectIndex:(NSInteger)index
{
    _btnClose.hidden = NO;
    
	if ([_delegate respondsToSelector:@selector(tabBarController:delectedByClick:)]) {
		[_delegate tabBarController:self delectedByClick:YES];
	}

	[self displayViewAtIndex:index];
}
@end
