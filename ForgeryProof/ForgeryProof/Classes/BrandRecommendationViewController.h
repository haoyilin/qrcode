//
//  BrandRecommendationViewController.h
//  ForgeryProof
//
//  Created by haoyl on 13-9-2.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "CustomViewController.h"

@interface BrandRecommendationViewController : CustomViewController <ASIHTTPRequestDelegate, UITableViewDelegate , UITableViewDataSource, UISearchBarDelegate>
{
    IBOutlet UITableView *_tableView;
    UIActivityIndicatorView *_actView;
    UITableView *_tableViewSeach;
    UISearchBar *_searchBar;
    
    NSMutableArray *_arrayDataSource;
    NSMutableArray *_arraySearchByName;
    NSMutableArray *_arraySearchByPhone;
//    NSMutableDictionary *_dicCom;
}

- (void)didFinishCallBack:(ASIHTTPRequest *)request;
- (void)didFailCallback:(ASIHTTPRequest *)request;

@end
