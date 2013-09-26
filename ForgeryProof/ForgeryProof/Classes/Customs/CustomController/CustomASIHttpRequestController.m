//
//  CustomASIHttpRequestController.m
//  Yueba
//
//  Created by Hyl on 12-13-3.
//
//

#import "CustomASIHttpRequestController.h"

@interface CustomASIHttpRequestController ()
{
   
}
@end

static CustomASIHttpRequestController *instance = nil;

@implementation CustomASIHttpRequestController

+ (CustomASIHttpRequestController *)sharedInstance
{
    @synchronized(self)
    {
        if (instance == nil)
        {
            instance = [[CustomASIHttpRequestController alloc] init];
        }
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _requestQueue = [[ASINetworkQueue alloc] init];
        [_requestQueue setDelegate:self];
        
        [_requestQueue setShowAccurateProgress:YES];
        
        [_requestQueue setRequestDidStartSelector:@selector(requestStartedByQueue:)];
        [_requestQueue setRequestDidReceiveResponseHeadersSelector:@selector(requestDidReceiveResponseHeadersSelectorByQueue:)];
        [_requestQueue setRequestDidFinishSelector:@selector(requestDidFinishSelectorByQueue:)];
        [_requestQueue setRequestDidFailSelector:@selector(requestDidFailSelectorByQueue:)];
        [_requestQueue setQueueDidFinishSelector:@selector(queueFinished:)];
        [_requestQueue go];
    }
    return self;
}

- (void)dealloc
{
    [_requestQueue release];
    [super dealloc];
}

#pragma mark - queueDelegate


- (void)requestStartedByQueue:(ASIHTTPRequest *)req
{
    NSLog(@"%@ status:%d",NSStringFromSelector(_cmd),req.tag);
}

- (void)requestDidReceiveResponseHeadersSelectorByQueue:(ASIHTTPRequest *)req
{
    NSLog(@"%@ status:%d",NSStringFromSelector(_cmd),req.tag);
}

- (void)requestDidFinishSelectorByQueue:(ASIHTTPRequest *)req
{
    NSLog(@"%@ status:%d",NSStringFromSelector(_cmd),req.tag);
}

- (void)requestDidFailSelectorByQueue:(ASIHTTPRequest *)req
{
    NSLog(@"%@ status:%d",NSStringFromSelector(_cmd),req.tag);
}

- (void)queueFinished:(ASINetworkQueue *)queue
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

#pragma mark - 填充http接口表单

- (void)fillRequest:(ASIFormDataRequest *)request dicValue:(NSDictionary *)dic
{
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@?",request.url];
    
    for (int i = 0; i < [dic count]; ++i)
    {
        (i==0)?:[urlStr appendString:@"&"];
        NSString *key = [[dic allKeys] objectAtIndex:i];
        NSString *value = [[dic allValues] objectAtIndex:i];
        
        if ([[[dic allKeys] objectAtIndex:i] isEqualToString:@"file"] || [[[dic allKeys] objectAtIndex:i] isEqualToString:@"path"])
        {
            [request setFile:value forKey:key];
            [request setShouldStreamPostDataFromDisk:YES];
        }
        else
        {
            [request addPostValue:value forKey:key];
        }
        [urlStr appendFormat:@"%@=%@",key,value];
    }
    NSLog(@"%@",urlStr);
}

#pragma mark normal rquest （just single request at a View）

- (ASIFormDataRequest *)requestNormalTag:(E_REQUEST_Tag)tag dicValue:(NSDictionary *)dic delegate:(id)delegate finishSelector:(SEL)finSEL failSelector:(SEL)failSEL currentRequest:(ASIFormDataRequest *)currentRequest;
{
    [self clearRequest:currentRequest];
    
	NSURL *url = [[NSURL alloc] initWithString:urlList[tag]];
	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    [self fillRequest:request dicValue:dic];
	request.delegate = delegate;
    request.tag = tag;
    
    request.timeOutSeconds = TIME_OUT;
	[request setDidFinishSelector:finSEL];
	[request setDidFailSelector:failSEL];
    
    [request startAsynchronous];
    
	[url release];
	return request;    ////request未分配内存时为nil,分配后需让request保存一个引用计数，不让其自动释放
}

- (void)clearRequest:(ASIFormDataRequest *)request {
    
	if (request != nil) {
        /*重点：nil与release的区别：某指针引用计数为0时，会调用dealloc方法，此时在调用retainCount会导致程序闪退。但有时在引用计数为0后，立即调用retainCount时不会闪退，而是得到结果为1。此时引用计数也确实降到0了，只是该指针指向的memcache被dealloc后，相当于告诉系统这块内存“可用”了，但是接下来NSLog就要输出retainCount，可能此时这块内存的“内容还没有变”。
            一个正确的写法还是应该当让指针的retainCount为0后，把指针赋值为nil，在[指针 retainCount] 后，即使是nil也不会抛异常，实际上nil调用retainCount返回的结果是0。
         */
        
        //我们这让request的retainCount始终是1

		if (![request isCancelled] || ![request complete])
        {
			[request clearDelegatesAndCancel];
            [request release];
            request = nil;
		}
	}
}

#pragma mark quene rquest 

- (ASIFormDataRequest *)requestQueueTag:(E_REQUEST_Tag)tag dicValue:(NSDictionary *)dic delegate:(id)delegate finishSelector:(SEL)finSEL failSelector:(SEL)failSEL
{
	NSURL *url = [[NSURL alloc] initWithString:urlList[tag]];
	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    [self fillRequest:request dicValue:dic];
	request.delegate = delegate;
    request.tag = tag;

    request.timeOutSeconds = TIME_OUT;
	[request setDidFinishSelector:finSEL];
	[request setDidFailSelector:failSEL];
    
    [_requestQueue addOperation:request];
    
	[url release];
	return [request autorelease];
}

- (void)cancelOperationForDelegate:(id)delegate
{
    [_requestQueue setSuspended:YES];
    for (ASIFormDataRequest *r in [_requestQueue operations])
    {
        if (r.delegate == delegate)
        {
            r.delegate = nil;
        }
    }
    [_requestQueue setSuspended:NO];
}


@end
