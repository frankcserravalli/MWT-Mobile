//
//  MWTStockDetailViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/22/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTStockDetailViewController.h"
#import "SBJson.h"

@interface MWTStockDetailViewController ()

@end

@implementation MWTStockDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _portfolio = [[MWTPortfolio alloc] init];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self getStockDetails];
    [self assignLabels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getStockDetails
{
    NSString *stockSymbol = self.title;
    
    NSString *stockDetailURLString = [NSString stringWithFormat:@"http://%@/api/v1/stocks/details?symbol=%@", serverURL, stockSymbol];
    NSURL *stockDetailURL = [NSURL URLWithString:stockDetailURLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:stockDetailURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];

    [self parseStock:response];
}

- (void) parseStock:(NSData *)data
{
    NSLog(@"parse stock");
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *stockJSON = [parser objectWithData:data];
    NSDictionary *stockDetails = [stockJSON objectForKey:@"table"];
    _stockDetails = stockDetails;
}

- (void) assignLabels
{   
    self.companyNameLabel.text = [_stockDetails objectForKey:@"name"];
    self.buyPriceLabel.text = [[_stockDetails objectForKey:@"buy_price"] stringValue];
    self.percentChangeLabel.text = [[_stockDetails objectForKey:@"percent_change"] stringValue];
    self.pointChangeLabel.text = [_stockDetails objectForKey:@"point_change"];
    self.peRatioLabel.text = [_stockDetails objectForKey:@"pe_ratio"];
    self.volumeLabel.text = [_stockDetails objectForKey:@"volume"];
}

@end
