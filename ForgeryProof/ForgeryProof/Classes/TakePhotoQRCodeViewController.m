//
//  TakePhotoQRCodeViewController.m
//  ForgeryProof
//
//  Created by haoyl on 13-9-15.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "TakePhotoQRCodeViewController.h"
#import "Common.h"

@interface TakePhotoQRCodeViewController ()

@end

@implementation TakePhotoQRCodeViewController

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
    
    _actView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    [_actView setCenter:CENTER_POINT];
    [self.view addSubview:_actView];
    
    [self scanningImg:self];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)scanningImg:(id)sender
{
    /*扫描二维码部分：
     导入ZBarSDK文件并引入一下框架
     AVFoundation.framework
     CoreMedia.framework
     CoreVideo.framework
     QuartzCore.framework
     libiconv.dylib
     引入头文件#import “ZBarSDK.h” 即可使用
     */
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    
    [self presentViewController:reader animated:YES completion:^{
        NSLog(@"跳转成功");
    }];
    
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] tabBarController] hidesTabBar:YES animated:NO];
}

- (IBAction)readFromAlbums:(id)sender {
    ZBarReaderController *reader = [ZBarReaderController new];
    reader.allowsEditing = YES;
    reader.readerDelegate = self;
    reader.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:reader animated:YES completion:^{
        NSLog(@"跳转成功---");
    }];
}

- (void) readerControllerDidFailToRead: (ZBarReaderController*) reader withRetry: (BOOL) retry
{
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    if ([info count]>2) {
        int quality = 0;
        ZBarSymbol *bestResult = nil;
        for(ZBarSymbol *sym in results) {
            int q = sym.quality;
            if(quality < q) {
                quality = q;
                bestResult = sym;
            }
        }
        [self performSelector: @selector(presentResult:) withObject: bestResult afterDelay: .001];
    }else {
        ZBarSymbol *symbol = nil;
        for(symbol in results)
            break;
        [self performSelector: @selector(presentResult:) withObject: symbol afterDelay: .001];
    }
    [picker dismissModalViewControllerAnimated:YES];
}

- (void) presentResult: (ZBarSymbol*)sym {
    if (sym) {
        NSString *tempStr = sym.data;
        if ([sym.data canBeConvertedToEncoding:NSShiftJISStringEncoding]) {
            tempStr = [NSString stringWithCString:[tempStr cStringUsingEncoding:NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        }
        NSLog(@"tempStr : %@",tempStr);
        
        [self seachAction:tempStr];
//        textLabel.text =  tempStr;
    }
}

- (void)seachAction:(NSString *)searchStr
{
    NSDictionary *dicInquire = [NSDictionary dictionaryWithObjectsAndKeys:@"inquire", @"command", searchStr, @"serialnumber", @"1", @"class", nil];
    
    _currentRequest = [[CustomASIHttpRequestController sharedInstance] requestNormalTag:e_inquire dicValue:dicInquire delegate:self finishSelector:@selector(didFinishCallBack:) failSelector:@selector(didFailCallback:) currentRequest:_currentRequest];
    
    [_actView startAnimating];
}

- (void)didFinishCallBack:(ASIHTTPRequest *)request
{
    [_actView stopAnimating];
    NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"result : %@",dicResult);
    
    if ([Common exsitKey:@"result" inDic:dicResult])
    {
        NSDictionary *dicTemp = [[dicResult objectForKey:@"result"] objectAtIndex:0];
        [_labelProName setText:[dicTemp objectForKey:@"pro_name"]];
        [_labelComName setText:[dicTemp objectForKey:@"pro_name"]];
        [_labelContent setText:[[@"说明：此产品是" stringByAppendingString:[dicTemp objectForKey:@"pro_name"]] stringByAppendingString:@"公司生产的正品，请放心使用。"]];
        [_viewResult setHidden:NO];
    }
    else
    {
        [Common alert:@"查无此产品。"];
    }
    
}

- (void)didFailCallback:(ASIHTTPRequest *)request
{
    [_actView stopAnimating];
    NSLog(@"didFailCallback %@",request.error);
}

- (IBAction)backAction
{
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] tabBarController] hidesTabBar:NO animated:NO];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)swipRight
{
    [self backAction];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
