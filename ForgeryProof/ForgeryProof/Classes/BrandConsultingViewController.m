//
//  BrandConsultingViewController.m
//  ForgeryProof
//
//  Created by haoyl on 13-9-2.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "BrandConsultingViewController.h"
#import "ComCell.h"

@interface BrandConsultingViewController ()

@end

@implementation BrandConsultingViewController

@synthesize arrayDataSource = _arrayDataSource;

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
    
    _arrayDataSource = [[NSMutableArray alloc] init];

    _actView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    [_actView setCenter:CENTER_POINT];
    [self.view addSubview:_actView];
    
    NSDictionary *dicGetAllCom = [NSDictionary dictionaryWithObjectsAndKeys:@"getAllCompany", @"command", nil];
    _currentRequest = [[CustomASIHttpRequestController sharedInstance] requestNormalTag:e_getAllCompany dicValue:dicGetAllCom delegate:self finishSelector:@selector(didFinishCallBack:) failSelector:@selector(didFailCallback:) currentRequest:_currentRequest];
    
    [_actView startAnimating];
}

- (void)didFinishCallBack:(ASIHTTPRequest *)request
{
    [_actView stopAnimating];
    
    NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"result : %@",dicResult);
    
    NSArray *arrayResult = [dicResult objectForKey:@"result"];
    for (int i = 0; i < [arrayResult count]; i ++)
    {
        NSDictionary *dicTemp = [arrayResult objectAtIndex:i];
        Company *com = [[Company new] autorelease];
        [com setComId:[dicTemp objectForKey:@"com_id"]];
        [com setIntroduction:[dicTemp objectForKey:@"introduction"]];
        [com setComName:[dicTemp objectForKey:@"name"]];
        [_arrayDataSource addObject:com];        
    }
    
    NSLog(@"_arrayDataSource : %@",_arrayDataSource);
    
    [_tableView reloadData];
}

- (void)didFailCallback:(ASIHTTPRequest *)request
{
    [_actView stopAnimating];
    NSLog(@"didFailCallback %@",request.error);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_arrayDataSource count] % 4 == 0)
    {
        return [_arrayDataSource count] / 4;
    }
    else
    {
        return [_arrayDataSource count] / 4 + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ComCellIdentifier = @"ComCellIdentifier";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered)
    {
        UINib *nib = [UINib nibWithNibName:@"ComCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ComCellIdentifier];
        nibsRegistered = YES;
    }
    int row = indexPath.row;
    ComCell *cell = [tableView dequeueReusableCellWithIdentifier:ComCellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    int remain = [_arrayDataSource count] % 4;
    if (remain == 0)
    {
        Company *com1 = [_arrayDataSource objectAtIndex:row * 4];
        Company *com2 = [_arrayDataSource objectAtIndex:row * 4 + 1];
        Company *com3 = [_arrayDataSource objectAtIndex:row * 4 + 2];
        Company *com4 = [_arrayDataSource objectAtIndex:row * 4 + 3];
        
        [cell.btn1 setTitle:[com1 comName] forState:UIControlStateNormal];
        [cell.btn2 setTitle:[com2 comName] forState:UIControlStateNormal];
        [cell.btn3 setTitle:[com3 comName] forState:UIControlStateNormal];
        [cell.btn4 setTitle:[com4 comName] forState:UIControlStateNormal];
        [cell.btn1 setHidden:NO];
        [cell.btn2 setHidden:NO];
        [cell.btn3 setHidden:NO];
        [cell.btn4 setHidden:NO];
    }
    else
    {
        if ( [_arrayDataSource count] / 4 == row)
        {
            if (remain == 1)
            {
                Company *com1 = [_arrayDataSource objectAtIndex:row * 4];
                [cell.btn1 setTitle:[com1 comName] forState:UIControlStateNormal];
                [cell.btn1 setHidden:NO];
                [cell.btn2 setHidden:YES];
                [cell.btn3 setHidden:YES];
                [cell.btn4 setHidden:YES];
            }
            else if (remain == 2)
            {
                Company *com1 = [_arrayDataSource objectAtIndex:row * 4];
                Company *com2 = [_arrayDataSource objectAtIndex:row * 4 + 1];
                
                [cell.btn1 setTitle:[com1 comName] forState:UIControlStateNormal];
                [cell.btn2 setTitle:[com2 comName] forState:UIControlStateNormal];
                [cell.btn1 setHidden:NO];
                [cell.btn2 setHidden:NO];
                [cell.btn3 setHidden:YES];
                [cell.btn4 setHidden:YES];
            }
            else if (remain == 3)
            {
                Company *com1 = [_arrayDataSource objectAtIndex:row * 4];
                Company *com2 = [_arrayDataSource objectAtIndex:row * 4 + 1];
                Company *com3 = [_arrayDataSource objectAtIndex:row * 4 + 2];
                
                [cell.btn1 setTitle:[com1 comName] forState:UIControlStateNormal];
                [cell.btn2 setTitle:[com2 comName] forState:UIControlStateNormal];
                [cell.btn3 setTitle:[com3 comName] forState:UIControlStateNormal];
                
                [cell.btn1 setHidden:NO];
                [cell.btn2 setHidden:NO];
                [cell.btn3 setHidden:NO];
                [cell.btn4 setHidden:YES];
            }
        }
        else
        {
            Company *com1 = [_arrayDataSource objectAtIndex:row * 4];
            Company *com2 = [_arrayDataSource objectAtIndex:row * 4 + 1];
            Company *com3 = [_arrayDataSource objectAtIndex:row * 4 + 2];
            Company *com4 = [_arrayDataSource objectAtIndex:row * 4 + 3];
            
            [cell.btn1 setTitle:[com1 comName] forState:UIControlStateNormal];
            [cell.btn2 setTitle:[com2 comName] forState:UIControlStateNormal];
            [cell.btn3 setTitle:[com3 comName] forState:UIControlStateNormal];
            [cell.btn4 setTitle:[com4 comName] forState:UIControlStateNormal];
            [cell.btn1 setHidden:NO];
            [cell.btn2 setHidden:NO];
            [cell.btn3 setHidden:NO];
            [cell.btn4 setHidden:NO];
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{    
//	[tableView deselectRowAtIndexPath:indexPath animated:YES];
//	
//	NSDictionary *d = [_arrayDataSource objectAtIndex:indexPath.row];
//	if([d objectForKey:@"objects"])
//    {
//		NSArray *ar = [d objectForKey:@"objects"];
//		
//		BOOL isAlreadyInserted = NO;
//		
//		for(NSDictionary *dInner in ar ){
//			NSInteger index = [_arrayDataSource indexOfObjectIdenticalTo:dInner];
//			isAlreadyInserted = (index>0 && index != NSIntegerMax);
//			if(isAlreadyInserted) break;
//		}
//		
//		if(isAlreadyInserted) {
//			[self miniMizeThisRows:ar];
//		} else {
//			NSUInteger count=indexPath.row+1;
//			NSMutableArray *arCells=[NSMutableArray array];
//			for(NSDictionary *dInner in ar ) {
//				[arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
//				[_arrayDataSource insertObject:dInner atIndex:count ++];
//			}
//			[tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationFade];
//		}
//	}
//}
//
//-(void)miniMizeThisRows:(NSArray*)ar{
//	
//	for(NSDictionary *dInner in ar ) {
//		NSUInteger indexToRemove = [_arrayDataSource indexOfObjectIdenticalTo:dInner];
//		NSArray *arInner = [dInner objectForKey:@"objects"];
//		if(arInner && [arInner count]>0){
//			[self miniMizeThisRows:arInner];
//		}
//		
//		if([_arrayDataSource indexOfObjectIdenticalTo:dInner] != NSNotFound) {
//			[_arrayDataSource removeObjectIdenticalTo:dInner];
//			[_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexToRemove inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
//		}
//	}
//}

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
