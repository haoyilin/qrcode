//
//  BrandRecommendationViewController.m
//  ForgeryProof
//
//  Created by haoyl on 13-9-2.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "BrandRecommendationViewController.h"
#import "SearchCoreManager.h"
#import "ContactPeople.h"

@interface BrandRecommendationViewController ()

@end

@implementation BrandRecommendationViewController

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

    [self tableViewSeachInit];
    [self searchBarInit];
    [_tableViewSeach setHidden:YES];

    _actView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    [_actView setCenter:CENTER_POINT];
    [self.view addSubview:_actView];
    
    _arrayDataSource = [[NSMutableArray alloc] init];
    _arraySearchByName = [[NSMutableArray alloc] init];
    _arraySearchByPhone = [[NSMutableArray alloc] init];
    
    NSDictionary *dicGetAllCom = [NSDictionary dictionaryWithObjectsAndKeys:@"getAllCompany", @"command", nil];
    _currentRequest = [[CustomASIHttpRequestController sharedInstance] requestNormalTag:e_getAllCompany dicValue:dicGetAllCom delegate:self finishSelector:@selector(didFinishCallBack:) failSelector:@selector(didFailCallback:) currentRequest:_currentRequest];
    
    [_actView startAnimating];
}

- (void)tableViewSeachInit
{
    _tableViewSeach = [[[UITableView alloc] initWithFrame:CGRectMake(0.0f, 88, 320.0f, 156)] autorelease];
    [_tableViewSeach setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [_tableViewSeach setSeparatorColor:COLOR_TABLE_SEPARATE_LINE];

    _tableViewSeach.dataSource=self;
	_tableViewSeach.delegate=self;
	_tableViewSeach.backgroundColor=[UIColor clearColor];
	[self.view addSubview:_tableViewSeach];
}

- (void)searchBarInit
{
    _searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 44, 320.0f, 44.0f)] autorelease];
    
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	_searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_searchBar.keyboardType = UIKeyboardTypeDefault;
	_searchBar.backgroundColor=[UIColor clearColor];
	_searchBar.translucent=YES;
	_searchBar.placeholder=@"搜索";
	_searchBar.delegate = self;
	_searchBar.barStyle=UIBarStyleDefault;

    [[[_searchBar subviews] objectAtIndex:0] setImage:[UIImage imageNamed:@"touming.png"]];
    
    [self.view addSubview:_searchBar];
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

        [[SearchCoreManager share] AddContact:[NSNumber numberWithInt:i] name:[com comName] phone:nil];
    }
    
    NSLog(@"_arrayDataSource : %@",_arrayDataSource);
    
    [_tableView reloadData];
}

- (void)didFailCallback:(ASIHTTPRequest *)request
{
    [_actView stopAnimating];
    NSLog(@"didFailCallback %@",request.error);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_searchBar.text length] <= 0)
    {
        return [_arrayDataSource count];
    } else {
        return [_arraySearchByName count] + [_arraySearchByPhone count] ;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//        UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ComTable.png"]] autorelease];
//        [imageView setFrame:CGRectMake(0, 0, 320, 44)];
//        [cell setBackgroundView:imageView];
    }

    if ([_searchBar.text length] <= 0)
    {
        Company *com = [_arrayDataSource objectAtIndex:indexPath.row];
        cell.textLabel.text = [com comName];
        [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
        cell.detailTextLabel.text = @"";
        return cell;
    }
    
    NSNumber *localID = nil;
    NSMutableString *matchString = [NSMutableString string];
    NSMutableArray *matchPos = [NSMutableArray array];
    if (indexPath.row < [_arraySearchByName count])
    {
        localID = [_arraySearchByName objectAtIndex:indexPath.row];
        
        //姓名匹配 获取对应匹配的拼音串 及高亮位置
        if ([_searchBar.text length])
        {
            [[SearchCoreManager share] GetPinYin:localID pinYin:matchString matchPos:matchPos];
        }
    }
    else
    {
        localID = [_arraySearchByPhone objectAtIndex:indexPath.row-[_arraySearchByName count]];
        NSMutableArray *matchPhones = [NSMutableArray array];
        
        //号码匹配 获取对应匹配的号码串 及高亮位置
        if ([_searchBar.text length])
        {
            [[SearchCoreManager share] GetPhoneNum:localID phone:matchPhones matchPos:matchPos];
            [matchString appendString:[matchPhones objectAtIndex:0]];
        }
    }
    Company *com= [_arrayDataSource objectAtIndex:[localID intValue]];
    
    cell.textLabel.text = [com comName];
    cell.detailTextLabel.text = matchString;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Company *com = [_arrayDataSource objectAtIndex:indexPath.row];

    ComDetailViewController *comDetailViewController = [[ComDetailViewController alloc] initWithNibName:@"ComDetailViewController" bundle:nil];
    [comDetailViewController setComId:[com comId]];
    [self.navigationController pushViewController:comDetailViewController animated:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [_tableViewSeach setHidden:NO];
    [_tableView setHidden:YES];
    [_searchBar setShowsCancelButton:YES animated:YES];

    UIButton *btnCancel = [[searchBar subviews] objectAtIndex:2];
    [btnCancel setBackgroundImage:[UIImage imageNamed:@"touming.png"] forState:UIControlStateNormal];
    [btnCancel setBackgroundImage:[UIImage imageNamed:@"touming.png"] forState:UIControlStateSelected];
    [btnCancel setBackgroundImage:[UIImage imageNamed:@"touming.png"] forState:UIControlStateHighlighted];
    
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    
    _searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    _searchBar.showsCancelButton = NO;
    [_tableViewSeach setHidden:YES];
    [_tableView setHidden:NO];

    [_searchBar resignFirstResponder];
    
    [_searchBar setText:@""];
    [_tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [[SearchCoreManager share] Search:searchText searchArray:nil nameMatch:_arraySearchByName phoneMatch:_arraySearchByPhone];
    
    [_tableViewSeach reloadData];
}

- (void)dealloc
{
    [super dealloc];
    [_arrayDataSource release];
    [_arraySearchByName release];
    [_arraySearchByName release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

