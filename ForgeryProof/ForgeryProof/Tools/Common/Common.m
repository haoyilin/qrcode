//
//  Common.m
//  ForgeryProof
//
//  Created by haoyl on 13-9-21.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (void)alert:(NSString *)msg
{
    UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
    
    [alertView show];
}

+ (BOOL)exsitKey:(NSString *)key inDic:(NSDictionary *)dic
{
    NSEnumerator *enumerator = [dic keyEnumerator];
    id enumkey;
    
    while ((enumkey = [enumerator nextObject]))
    {
        if ([enumkey isEqualToString:key])
        {
            return YES;
        }
    }
    return NO;
}

@end
