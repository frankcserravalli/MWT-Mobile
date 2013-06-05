//
//  MWTSearchDetailsViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 6/5/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTSearchDetailsViewController.h"
#import "MWTBuyStockViewController.h"
#import "MWTSellStockViewController.h"
#import "MWTShortStockViewController.h"
#import "MWTStockChartViewController.h"

@interface MWTSearchDetailsViewController ()

@end

@implementation MWTSearchDetailsViewController

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
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = background;
    
    UIImage *resizableButton = [[UIImage imageNamed:@"button.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(12, 6, 12, 6)];
    [_buyButton setBackgroundImage:resizableButton forState:UIControlStateNormal];
    [_sellButton setBackgroundImage:resizableButton forState:UIControlStateNormal];
    [_shortButton setBackgroundImage:resizableButton forState:UIControlStateNormal];
    [self assignLabels];
    [self fetchPortfolio];
    [self fetchStockDetail];

}

- (void) viewWillAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
- (void) assignLabels
{
    _buyPriceLabel.text = [NSString stringWithFormat:@"%@", _stockDetail.buy_price];
    _percentChangeLabel.text = [NSString stringWithFormat:@"%@", _stockDetail.percent_change];
    _pointChangeLabel.text = _stockDetail.point_change;
    _peRatioLabel.text = _stockDetail.pe_ratio;
    _volumeLabel.text = _stockDetail.volume;
    _companyNameLabel.text = _stockDetail.name;
}

#pragma mark - Data Retrieval
- (void) fetchStockDetail
{
    NSString *ios_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"ios_token"];
    NSLog(@"%@", _searchResult.symbol);
    NSString *symbol = _searchResult.symbol;
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
                                             _stockDetail = [[MWTStockDetail alloc] initWith:stockDetails];
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

#pragma mark - IBActions
- (IBAction)buyButtonAction:(id)sender
{
    [self performSegueWithIdentifier:@"BuyStock" sender:self];
}

- (IBAction)shortButtonAction:(id)sender
{
    [self performSegueWithIdentifier:@"ShortStock" sender:self];
}

- (IBAction)sellButtonAction:(id)sender
{
    [self performSegueWithIdentifier:@"SellStock" sender:self];
}

#pragma mark - Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BuyStock"])
    {
        MWTBuyStockViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.stockDetail = _stockDetail;
        destinationViewController.portfolio = _portfolio;
    }
    else if ([segue.identifier isEqualToString:@"SellStock"])
    {
        MWTSellStockViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.stockDetail = _stockDetail;
        destinationViewController.portfolio = _portfolio;
    }
    else if ([segue.identifier isEqualToString:@"ShortStock"])
    {
        MWTShortStockViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.stockDetail = _stockDetail;
        destinationViewController.portfolio = _portfolio;
    }
    else if ([segue.identifier isEqualToString:@"StockChart"])
    {
        MWTStockChartViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.stockSymbol = _stockDetail.symbol;
    }
}
@end
