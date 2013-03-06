//
//  MWTLoginViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/17/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTLoginViewController.h"
#import "SBJson.h"

@interface MWTLoginViewController ()

@end

@implementation MWTLoginViewController

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
	// Do any additional setup after loading the view.
    //self.title = @"Login";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundDismissKeyboard:(id)sender
{
    [_emailTextfield resignFirstResponder];
    [_passwordTextfield resignFirstResponder];
}

- (IBAction)login:(id)sender
{
//    NSString *loginURLString = [NSString stringWithFormat:@"http://%@/api/v1/", serverURL];
//    NSURL *loginURL = [NSURL URLWithString:loginURLString];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:loginURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//    [request setHTTPMethod:@"GET"];
//    
//    NSError *requestError;
//    
//    NSURLResponse *urlResponse = nil;
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
//    
//    SBJsonParser *parser = [[SBJsonParser alloc] init];
//    NSDictionary *loginResponse = [parser objectWithData:response];
//    
//    if ([[loginResponse objectForKey:@""] isEqualToString:@"login successful"])
//    {
//        [self performSegueWithIdentifier:@"Login" sender:self];
//    }
    [self performSegueWithIdentifier:@"Login" sender:self];
}

@end
