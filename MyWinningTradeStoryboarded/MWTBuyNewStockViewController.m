//
//  MWTBuyNewStockViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 5/9/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTBuyNewStockViewController.h"

@interface MWTBuyNewStockViewController ()

@end

@implementation MWTBuyNewStockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [SVProgressHUD showWithStatus:@"Fetching stock information"];
    [self fetchStockDetail];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = background;
    
    UIImage *resizableButton = [[UIImage imageNamed:@"button.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(12, 6, 12, 6)];
    [_submit setBackgroundImage:resizableButton forState:UIControlStateNormal];
    [_cancel setBackgroundImage:resizableButton forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissKeyboard:(id)sender
{
    [sender resignFirstResponder];
    _volume = 0.0f;
    _volume = [[_volumeTextField text] floatValue];
    float totalPriceToBuy = _volume * [_currentPrice.text floatValue];
    NSString *totalPriceToBuyString = [NSString stringWithFormat:@"%f", totalPriceToBuy];
    _totalPrice.text = totalPriceToBuyString;
    float cash = [_cash.text floatValue];
    float cashAfterPurchase = cash - totalPriceToBuy;
    _postPurchaseCash.text = [NSString stringWithFormat:@"%f", cashAfterPurchase];
}

- (IBAction)submitPurchase:(id)sender
{
    [SVProgressHUD showWithStatus:@"Purchasing..."];
    
    NSString *ios_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"ios_token"];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSNumber *volume = [NSNumber numberWithFloat:_volume];
    NSString *stock_id = _companyName.text;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            ios_token, @"ios_token",
                            user_id, @"user_id",
                            volume, @"volume",
                            stock_id, @"stock_id",
                            nil];
    NSString *postPath = @"/api/v1/buys";
    MWTAPIClient *client = [MWTAPIClient sharedInstance];
    NSURLRequest *request = [client requestWithMethod:@"POST" path:postPath parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             [SVProgressHUD showSuccessWithStatus:@"Purchased!"];
                                             NSLog(@"%@", JSON);
                                             [self dismissViewControllerAnimated:YES completion:nil];
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             [SVProgressHUD showErrorWithStatus:@"Server error"];
                                             NSLog(@"%@", error);
                                         }];
    [operation start];

}

- (IBAction)cancelPurchase:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) fetchStockDetail
{
    NSString *ios_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"ios_token"];
    NSString *symbol = _companyName.text;
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
                                             
                                             _currentPrice.text = _stockDeetz.current_price;
                                             [SVProgressHUD showSuccessWithStatus:@"Details downloaded"];
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"%@", error);
                                         }];
    [operation start];

}
@end
