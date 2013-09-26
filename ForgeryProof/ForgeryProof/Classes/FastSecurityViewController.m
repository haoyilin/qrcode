//
//  FastSecurityViewController.m
//  ForgeryProof
//
//  Created by haoyl on 13-9-2.
//  Copyright (c) 2013年 com.haoyl. All rights reserved.
//

#import "Header.h"

@interface FastSecurityViewController ()

@end

@implementation FastSecurityViewController

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
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)inputQRCodeAction
{
    InputQRCodeViewController *inputQRCodeViewController = [[[InputQRCodeViewController alloc] initWithNibName:@"InputQRCodeViewController" bundle:nil] autorelease];
    [self.navigationController pushViewController:inputQRCodeViewController animated:YES];
}

- (IBAction)takePhotoQRCodeAction
{
    TakePhotoQRCodeViewController *takePhotoQRCodeViewController = [[[TakePhotoQRCodeViewController alloc] initWithNibName:@"TakePhotoQRCodeViewController" bundle:nil] autorelease];
    [self.navigationController pushViewController:takePhotoQRCodeViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
