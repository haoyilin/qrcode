//
//  Common.h
//  ForgeryProof
//
//  Created by haoyl on 13-9-21.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

+ (void)alert:(NSString *)msg;
+ (BOOL)exsitKey:(NSString *)key inDic:(NSDictionary *)dic;

@end
