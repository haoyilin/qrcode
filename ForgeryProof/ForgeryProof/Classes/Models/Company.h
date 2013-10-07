//
//  Company.h
//  ForgeryProof
//
//  Created by haoyl on 13-9-15.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject
{
    NSString *_comId;
    NSString *_introduction;
    NSString *_comName;
    NSString *_recommendLevel;
}

@property (nonatomic, copy) NSString *comId;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSString *comName;
@property (nonatomic, copy) NSString *recommendLevel;

@end
