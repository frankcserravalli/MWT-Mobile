//
//  MWTStockChartViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 3/20/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTStockChartViewController.h"

@interface MWTStockChartViewController ()

@end

@implementation MWTStockChartViewController

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
    NSString *URLString = [NSString stringWithFormat:@"https://www.tradingview.com/e/?symbol=%@", _stockSymbol];
    
    NSURL *url = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
