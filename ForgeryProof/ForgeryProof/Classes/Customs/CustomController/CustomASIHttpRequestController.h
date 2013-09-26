//
//  ZDHttpRequestController.h
//  Yueba
//
//  Created by Gan LL on 12-12-27.
//
//  

#pragma mark -自定义http请求

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"

typedef enum
{
    e_getAllCompany = 0,
    e_getProduct = 1,
    e_inquire = 2
}E_REQUEST_Tag;

static NSString * const urlList[] =
{
    @"http://121.199.20.18/qrcode/index.php",
    @"http://121.199.20.18/qrcode/index.php",
    @"http://121.199.20.18/qrcode/index.php"
};

@interface CustomASIHttpRequestController : NSObject
{
    ASINetworkQueue *_requestQueue;
}

+ (CustomASIHttpRequestController *)sharedInstance;

- (void)fillRequest:(ASIFormDataRequest *)request dicValue:(NSDictionary *)dic;

- (ASIFormDataRequest *)requestNormalTag:(E_REQUEST_Tag)tag dicValue:(NSDictionary *)dic delegate:(id)delegate finishSelector:(SEL)finSEL failSelector:(SEL)failSEL currentRequest:(ASIFormDataRequest *)currentRequest;
- (ASIFormDataRequest *)requestQueueTag:(E_REQUEST_Tag)tag dicValue:(NSDictionary *)dic delegate:(id)delegate finishSelector:(SEL)finSEL failSelector:(SEL)failSEL;

- (void)clearRequest:(ASIFormDataRequest *)request;

- (void)cancelOperationForDelegate:(id)delegate;

@end
