//
//  MWTShortStockViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/24/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTShortStockViewController.h"

@interface MWTShortStockViewController ()

- (void) connectToAPIPath:(NSString *)pathToAPI toShort:(NSInteger)amountOfShares ofStock:(NSString *)stockSymbol;

@end

@implementation MWTShortStockViewController

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
	// Do any additional setup after loading the view.
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = background;
    
    UIImage *resizableButton = [[UIImage imageNamed:@"button.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(12, 6, 12, 6)];
    [_submitButton setBackgroundImage:resizableButton forState:UIControlStateNormal];
    [_cancelButton setBackgroundImage:resizableButton forState:UIControlStateNormal];
    
    _numberToCurrencyConverter = [[NSNumberFormatter alloc] init];
    [_numberToCurrencyConverter setNumberStyle:NSNumberFormatterCurrencyStyle];

}

- (void) viewWillAppear:(BOOL)animated
{
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)submitButtonAction:(id)sender
{
    NSString *postPath = @"api/v1/short_sell_borrows";
    NSInteger shortVolume = _volume;
    NSString *stockSymbol = _stockDetail.symbol;
    
    [self connectToAPIPath:postPath toShort:shortVolume ofStock:stockSymbol];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backgroundPressed:(id)sender
{
    [_volumeField resignFirstResponder];
    [self computeBorrowTotal];
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextfield Delegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self computeBorrowTotal];
    return YES;
}

#pragma mark - UI
- (void) updateUI
{
    _companyName.text = _stockDetail.name;
    
    NSNumber *currentPriceNumber = [NSNumber numberWithFloat:[_stockDetail.current_price floatValue]];
    _currentPrice.text = [_numberToCurrencyConverter stringFromNumber:currentPriceNumber];
    _volumeField.text = @"";
    _borrowTotal.text = @"0.0";
}

- (void) computeBorrowTotal
{
    _volume = 0.0f;
    _volume = [_volumeField.text floatValue];
    
    float currentPrice = [_stockDetail.current_price floatValue];
    float totalPriceToBorrow = _volume * currentPrice;
    NSNumber *totalPriceToBorrowNumber = [NSNumber numberWithFloat:totalPriceToBorrow];
    NSString *totalPriceToBorrowString = [_numberToCurrencyConverter stringFromNumber:totalPriceToBorrowNumber];
    _borrowTotal.text = totalPriceToBorrowString;
}

#pragma mark - AFNetworking
- (void) connectToAPIPath:(NSString *)pathToAPI toShort:(NSInteger)amountOfShares ofStock:(NSString *)stockSymbol
{
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    [SVProgressHUD showWithStatus:@"Shorting stock..."];
    
    NSString *ios_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"ios_token"];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSNumber *volume = [NSNumber numberWithInt:amountOfShares];
    NSString *stock_id = stockSymbol;
    
    NSString *when = @"At Market";
    NSString *measure = @"Above";
    NSString *price_target = _stockDetail.current_price;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            ios_token, @"ios_token",
                            user_id, @"user_id",
                            volume, @"volume",
                            stock_id, @"stock_id",
                            when, @"when",
                            measure, @"measure",
                            price_target, @"price_target",
                            nil];
    NSString *postPath = pathToAPI;
    MWTAPIClient *client = [MWTAPIClient sharedInstance];
    NSURLRequest *request = [client requestWithMethod:@"POST" path:postPath parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                                             if ([[(NSDictionary *)JSON objectForKey:@"status"] isEqualToString:@"Order placed."])
                                             {
                                                 [SVProgressHUD showSuccessWithStatus:@"Short successful"];
                                                 NSLog(@"%@", JSON);
                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                             }
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                                             [SVProgressHUD showErrorWithStatus:@"Server error"];
                                             NSLog(@"%@", error);
                                         }];
    [operation start];
}

@end
