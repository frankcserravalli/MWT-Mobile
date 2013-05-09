//
//  MWTSellStockViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/24/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTSellStockViewController.h"

@interface MWTSellStockViewController ()

@end

@implementation MWTSellStockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _volume = 0.0f;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = background;
    
    UIImage *resizableButton = [[UIImage imageNamed:@"button.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(12, 6, 12, 6)];
    [_submitButton setBackgroundImage:resizableButton forState:UIControlStateNormal];
    [_cancelButton setBackgroundImage:resizableButton forState:UIControlStateNormal];
    
	// Do any additional setup after loading the view.
//    _companyNameLabel.text = _stockSymbol;
////    MWTPortfolioSingleton *portfolioSingleton = [MWTPortfolioSingleton sharedInstance];
////    NSDictionary *stockDict = [[portfolioSingleton userPortfolio] getStockDictionaryFromStock:_stockSymbol];
////    NSNumber *currentPriceOfStock = [stockDict objectForKey:@"current_price"];
////    _cash = [portfolioSingleton.userPortfolio cash];
////    
//    _companyNameLabel.text = [stockDict objectForKey:@"name"];
//    _currentPriceLabel.text = [currentPriceOfStock stringValue];
//    _volumeHeld.text = [stockDict objectForKey:@""];
 
    _companyNameLabel.text = _stock.symbol;
    _currentPriceLabel.text = [_stock.current_price stringValue];
    _volumeHeld.text = [_stockDetail.volume stringValue];
    _cash = _portfolio.cash;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButtonAction:(id)sender
{
    [self connectToAPIPath:@"/api/v1/sells" toSell:[_volumeTextField.text integerValue] ofStock:_stockSymbol];
    [self cancelButtonAction:sender];
}

- (IBAction)cancelButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backgroundDismissKeyboard:(id)sender
{
    [_volumeTextField resignFirstResponder];
    [self assignValues];
}

- (IBAction)dismissKeyboard:(id)sender
{
    [sender resignFirstResponder];
    [self assignValues];
   
}

- (void) connectToAPIPath:(NSString *)pathToAPI toSell:(NSInteger )amountOfShares ofStock:(NSString *)stockSymbol
{
//    NSLog(@"connecting to API");
//    
//    NSString *urlString = [NSString stringWithFormat:@"http://%@/%@", serverURL, pathToAPI];
//    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSLog(@"Calling URL %@", [url absoluteString]);
//    
//    
//    NSString *post = [NSString stringWithFormat:@"user_id=1&sell[volume]=%d&stock_id=%@",amountOfShares,stockSymbol];
//    NSMutableData *postData = [NSMutableData data];
//    [postData appendData:[post dataUsingEncoding:NSUTF8StringEncoding]];
//    NSString *postDataString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
//    NSLog(@"Data string is %@", postDataString);
//    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//    
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:postData];
//    
//    NSURLResponse *response;
//    NSError *requestError;
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
//    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"error is %@", [requestError debugDescription]);
//    NSLog(@"response string is %@",responseString);
    NSString *ios_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"ios_token"];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSNumber *volume = [NSNumber numberWithInt:amountOfShares];
    NSString *stock_id = stockSymbol;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            ios_token, @"ios_token",
                            user_id, @"user_id",
                            volume, @"volume",
                            stock_id, @"stock_id",
                            nil];
    NSString *postPath = pathToAPI;
    MWTAPIClient *client = [MWTAPIClient sharedInstance];
    NSURLRequest *request = [client requestWithMethod:@"POST" path:postPath parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             NSLog(@"%@", JSON);
                                             [self dismissViewControllerAnimated:YES completion:nil];
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"%@", error);
                                         }];
    [operation start];

}

- (void) assignValues
{
    _volume = 0.0f;
    _volume = [_volumeTextField.text floatValue];
    float totalPriceWhenSold = _volume * [_currentPriceLabel.text floatValue];
    NSString *totalPriceWhenSoldString = [NSString stringWithFormat:@"%f", totalPriceWhenSold];
    _totalLabel.text = totalPriceWhenSoldString;
    float cashAfterPurchase = [_cash floatValue] + totalPriceWhenSold;
    _cashAfterTransactionLabel.text = [NSString stringWithFormat:@"%f", cashAfterPurchase];
}

@end
