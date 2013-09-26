//
//  BrandConsultingViewController.h
//  ForgeryProof
//
//  Created by haoyl on 13-9-2.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "CustomViewController.h"

@interface BrandConsultingViewController : CustomViewController <ASIHTTPRequestDelegate, UITableViewDelegate , UITableViewDataSource>
{
    UIActivityIndicatorView *_actView;
    IBOutlet UITableView *_tableView;
    
    NSMutableArray *_arrayDataSource;
}

@property (nonatomic, retain) NSMutableArray *arrayDataSource;

@end
