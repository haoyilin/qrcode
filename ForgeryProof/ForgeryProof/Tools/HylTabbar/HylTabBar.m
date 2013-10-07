//
//  HylTabBar.m
//  HylTabBarController
//
//  Created by Hyl Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import "HylTabBar.h"

@implementation HylTabBar
@synthesize backgroundView = _backgroundView;
@synthesize delegate = _delegate;
@synthesize buttons = _buttons;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_backgroundView setImage:[UIImage imageNamed:@"buttomBar.png"]];
		[self addSubview:_backgroundView];
        
        CGFloat width = 320.0f / [imageArray count];

        UIImageView *imageTarBarBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TabBarBg.png"]];
        [imageTarBarBg setFrame:CGRectMake(0, 0, width, self.bounds.size.height)];
        [imageTarBarBg setAlpha:0.5];
        [self addSubview:imageTarBarBg];
        [imageTarBarBg setTag:101];
        
		self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
		UIButton *btn;
		for (int i = 0; i < [imageArray count]; i++)
		{
			btn = [UIButton buttonWithType:UIButtonTypeCustom];           //自定义
			btn.showsTouchWhenHighlighted = YES;                          //
			btn.tag = i;
			btn.frame = CGRectMake(width * i, 0, width, frame.size.height);
            
            NSString *strImgName = [[@"TabBar_b" stringByAppendingFormat:@"%d",i + 1] stringByAppendingString:@".png"];
            UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:strImgName] ];
            [image1 setFrame:CGRectMake(15, -5, 50, 50)];

            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 42, 80, 15)];
            [label1 setTextAlignment:NSTextAlignmentCenter];
            [label1 setBackgroundColor:[UIColor clearColor]];
            [label1 setFont:[UIFont systemFontOfSize:14]];
            
            NSString *strName = @"";
            switch (i)
            {
                case 0:
                    strName = @"快速防伪";
                    break;
                case 1:
                    strName = @"品牌咨询";
                    break;
                case 2:
                    strName = @"品牌推荐";
                    break;
                case 3:
                    strName = @"关于平台";
                    break;
                default:
                    break;
            }
            [label1  setText:strName];
            
            [btn addSubview:label1];
            [btn addSubview:image1];
            
//			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
//			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
//			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Seleted"] forState:UIControlStateSelected];
			[btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchDown];
			
			[self.buttons addObject:btn];
			[self addSubview:btn];
		}
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)img
{
	[_backgroundView setImage:img];
}

/**
 *按钮点击事件方法
 */
- (void)tabBarButtonClicked:(id)sender
{	
	[self performSelector:@selector(tabClickedOver) withObject:nil afterDelay:0.1];
	
	UIButton *btn = sender;
	[self selectTabAtIndex:btn.tag];
    
    CGFloat width = 320.0f / [self.buttons count];

    UIImageView *imageViewTabBarBg = (UIImageView *)[self viewWithTag:101];
    [imageViewTabBarBg setFrame:CGRectMake(width * btn.tag, 0, imageViewTabBarBg.frame.size.width, imageViewTabBarBg.frame.size.height)];
    
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [_delegate tabBar:self didSelectIndex:btn.tag];
    }
}

- (void)tabClickedOver {

}

- (void)selectTabAtIndex:(NSInteger)index
{
	for (int i = 0; i < [self.buttons count]; i++)
	{
		UIButton *b = [self.buttons objectAtIndex:i];
		b.selected = NO;
		b.userInteractionEnabled = YES;
	}
	UIButton *btn = [self.buttons objectAtIndex:index];
	btn.selected = YES;
	btn.userInteractionEnabled = NO;
}

- (void)removeTabAtIndex:(NSInteger)index
{
    // Remove button
    [(UIButton *)[self.buttons objectAtIndex:index] removeFromSuperview];
    [self.buttons removeObjectAtIndex:index];
    
    // Re-index the buttons
    CGFloat width = 320.0f / [self.buttons count];
    for (UIButton *btn in self.buttons) 
    {
        if (btn.tag > index)
        {
            btn.tag --;
        }
        btn.frame = CGRectMake(width * btn.tag, 0, width, self.frame.size.height);
    }
}
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    // Re-index the buttons
    CGFloat width = 320.0f / ([self.buttons count] + 1);
    for (UIButton *b in self.buttons) 
    {
        if (b.tag >= index)
        {
            b.tag ++;
        }
        b.frame = CGRectMake(width * b.tag, 0, width, self.frame.size.height);
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.tag = index;
    btn.frame = CGRectMake(width * index, 0, width, self.frame.size.height);
    [btn setImage:[dict objectForKey:@"Default"] forState:UIControlStateNormal];
    [btn setImage:[dict objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:[dict objectForKey:@"Seleted"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons insertObject:btn atIndex:index];
    [self addSubview:btn];
}

- (void)dealloc
{
    [_backgroundView release];
    [_buttons release];
    [super dealloc];
}

@end
