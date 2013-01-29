//
//  MWTStockDetailViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/22/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTStockDetailViewController.h"
#import "MWTBuyStockViewController.h"

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
    self.buyPriceLabel.text = [stockDetails objectForKey:@"current_price"];
    self.percentChangeLabel.text = [[stockDetails objectForKey:@"percent_change"] stringValue];
    self.pointChangeLabel.text = [stockDetails objectForKey:@"point_change"];
    self.peRatioLabel.text = [stockDetails objectForKey:@"pe_ratio"];
    self.volumeLabel.text = [stockDetails objectForKey:@"volume"];
}

- (IBAction)buyButtonAction:(id)sender
{
    NSLog(@"Buy button pressed");
    [self performSegueWithIdentifier:@"BuyStock" sender:self];
}

- (IBAction)sellButtonAction:(id)sender
{
    NSLog(@"Sell button pressed");
    [self performSegueWithIdentifier:@"SellStock" sender:self];
}

- (IBAction)shortButtonAction:(id)sender
{
    NSLog(@"Short button pressed");
    [self performSegueWithIdentifier:@"ShortStock" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"BuyStock"])
    {
        NSLog(@"Pass buy data");
        MWTBuyStockViewController *destinationController = [segue destinationViewController];
        destinationController.stockSymbol = self.title;
    }
    else if ([[segue identifier] isEqualToString:@"SellStock"])
    {
        NSLog(@"Pass sell data");
    }
    else if ([[segue identifier] isEqualToString:@"ShortStock"])
    {
        NSLog(@"Pass short data");
    }

}


@end
