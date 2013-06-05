//
//  MWTStockDetailViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/22/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTStockDetailViewController.h"
#import "MWTBuyStockViewController.h"
#import "MWTSellStockViewController.h"
#import "MWTStockDetail.h"
#import "MWTStockChartViewController.h"
#import "MWTShortStockViewController.h"

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
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = background;
    
    UIImage *resizableButton = [[UIImage imageNamed:@"button.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(12, 6, 12, 6)];
    [_buyButton setBackgroundImage:resizableButton forState:UIControlStateNormal];
    [_sellButton setBackgroundImage:resizableButton forState:UIControlStateNormal];
    [_shortButton setBackgroundImage:resizableButton forState:UIControlStateNormal];
    
//    _stock = [[MWTStock alloc] init];
//    [_stock getStockDetailsForStock:self.title];
    
//    NSString *URLString = [NSString stringWithFormat:@"https://www.tradingview.com/e/?symbol=%@", self.title];
//    
//    NSURL *url = [NSURL URLWithString:URLString];
//    NSURLRequest *chartRequest = [NSURLRequest requestWithURL:url];
//    [_chartView loadRequest:chartRequest];

    [self fetchStockDetails];
    //    [self fetchPortfolio];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) assignLabels
{
    _companyNameLabel.text = _stock.name;
    _buyPriceLabel.text = [_stock.current_price stringValue];
    _percentChangeLabel.text = [_stock.percent_gain stringValue];
    _pointChangeLabel.text = _stockDeetz.point_change;
    _peRatioLabel.text = _stockDeetz.pe_ratio;
    _volumeLabel.text = _stockDeetz.volume;
}

- (void) fetchStockDetails
{
    NSString *ios_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"ios_token"];
    NSString *symbol = _stock.symbol;
    NSString *postPath = @"/api/v1/stocks/details";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            symbol, @"symbol",
                            ios_token, @"ios_token",
                            nil];
    MWTAPIClient *client = [MWTAPIClient sharedInstance];
    NSURLRequest *request = [client requestWithMethod:@"POST" path:postPath parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             NSLog(@"%@", JSON);
                                             NSDictionary *stockDetails = [JSON objectForKey:@"table"];
                                             _stockDeetz = [[MWTStockDetail alloc] initWith:stockDetails];
                                             [self assignLabels];
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"%@", error);
                                         }];
    [operation start];

}

- (void) fetchPortfolio
{
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString *ios_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"ios_token"];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            user_id, @"user_id",
                            ios_token, @"ios_token",
                            nil];
    NSString *postPath = @"/api/v1/users/portfolio";
    
    MWTAPIClient *client = [MWTAPIClient sharedInstance];
    NSURLRequest *request = [client requestWithMethod:@"POST" path:postPath parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             NSLog(@"%@", JSON);
                                             _portfolio = [[MWTPortfolio alloc] initWith:JSON];
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"%@", error);
                                         }];
    
    [operation start];
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

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"BuyStock"])
    {
        MWTBuyStockViewController *destinationController = [segue destinationViewController];
//        destinationController.stock = _stock;
        destinationController.stockDetail = _stockDeetz;
        destinationController.portfolio = _portfolio;
    }
    else if ([[segue identifier] isEqualToString:@"SellStock"])
    {
        MWTSellStockViewController *destinationController = [segue destinationViewController];
        destinationController.stockSymbol = self.title;
//        destinationController.stock = _stock;
        destinationController.stockDetail = _stockDeetz;
        destinationController.portfolio = _portfolio;

    }
    else if ([[segue identifier] isEqualToString:@"ShortStock"])
    {
        MWTShortStockViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.stockDetail = _stockDeetz;
        destinationViewController.portfolio = _portfolio;
//        destinationViewController.stock = _stock;
    }
    else if ([[segue identifier] isEqualToString:@"StockChart"])
    {
        MWTStockChartViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.stockSymbol = self.title;
    }

}


@end
