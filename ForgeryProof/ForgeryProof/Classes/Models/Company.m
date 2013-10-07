//
//  Company.m
//  ForgeryProof
//
//  Created by haoyl on 13-9-15.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "Company.h"

@implementation Company

@synthesize comId = _comId, comName = _comName, introduction = _introduction;
@synthesize recommendLevel = _recommendLevel;

- (void)dealloc
{
    [_comId release];
    [_comName release];
    [_introduction release];
    [_recommendLevel release];
    [super dealloc];
}

@end
