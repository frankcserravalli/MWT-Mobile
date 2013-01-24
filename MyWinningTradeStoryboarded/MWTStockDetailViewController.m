//
//  MWTStockDetailViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/22/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTStockDetailViewController.h"

@interface MWTStockDetailViewController ()

@end

@implementation MWTStockDetailViewController

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
    _stock = [[MWTStock alloc] init];
    [_stock getStockDetailsForStock:self.title];

    [self assignLabels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) assignLabels
{
    NSDictionary *stockDetails = [_stock stockDetails];
    
    self.companyNameLabel.text = [stockDetails objectForKey:@"name"];
    self.buyPriceLabel.text = [[stockDetails objectForKey:@"buy_price"] stringValue];
    self.percentChangeLabel.text = [[stockDetails objectForKey:@"percent_change"] stringValue];
    self.pointChangeLabel.text = [stockDetails objectForKey:@"point_change"];
    self.peRatioLabel.text = [stockDetails objectForKey:@"pe_ratio"];
    self.volumeLabel.text = [stockDetails objectForKey:@"volume"];
}

@end
