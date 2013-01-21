//
//  MWTPortfolioViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/17/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTPortfolioViewController.h"
#import "MWTPortfolioCell.h"
#import "SBJson.h"

@interface MWTPortfolioViewController ()

@end

@implementation MWTPortfolioViewController

/*
 *  TODO
 *  -parent portfolio UI table view
 *  -stock subview
 */


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
    self.tableView.dataSource = self;

    NSLog(@"Call portfolio");
    [self getPortfolio];
   
    _portfolioValue.text = _totalValue;
    _accountValueLabel.text = _accountValue;
    _cashLabel.text = _cash;
    
    for (NSString *key in _stocks)
    {
        NSLog(@"KEY: %@", key);
        NSString *value = [_stocks objectForKey:key];
        
        NSLog(@"VALUE: %@", value);
        
        NSDictionary *subvalues = [_stocks objectForKey:key];
        NSLog(@"percent_gained:");
        NSLog([[subvalues objectForKey:@"percent_gain"] stringValue]);
    }
}

- (void) getPortfolio
{
    int user_id = 1;
    NSString *portfolioURLString = [NSString stringWithFormat:@"http://localhost:3000/api/v1/users/portfolio?user_id=%i", user_id];
    NSURL *portfolioURL = [NSURL URLWithString:portfolioURLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:portfolioURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    [self parsePortfolio:response];
    
//    NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
//    NSLog(responseString);
    
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void) parsePortfolio:(NSData *)data
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *portfolio = [parser objectWithData:data];
    
    [self assignValuesFrom:portfolio];
//    
//    NSString *valueString = [[portfolio objectForKey:@"current_value"] stringValue];
//    NSString *accountValueString = [[portfolio objectForKey:@"account_value"] stringValue];
//    NSString *cashString = [[portfolio objectForKey:@"cash"] stringValue];
//
//    _totalValue = valueString;
//    _accountValue = accountValueString;
//    _cash = cashString;
    
    _sections = [portfolio allKeys];
    
        for (NSString *key in portfolio)
        {
            NSLog(@"KEY: %@", key);
            NSString *value = [portfolio objectForKey:key];
    
            NSLog(@"VALUE: %@", value);
        }
}

- (void) assignValuesFrom:(NSDictionary *)dictionary
{
    NSDecimalNumberHandler *numberBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:4 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *value = [dictionary objectForKey:@"current_value"];

    value = [value decimalNumberByRoundingAccordingToBehavior:numberBehavior];
    NSString *valueString = [value stringValue];
    _totalValue = valueString;

    NSString *accountValueString = [[dictionary objectForKey:@"account_value"] stringValue];
    _accountValue = accountValueString;

    NSString *cashString = [[dictionary objectForKey:@"cash"] stringValue];
    _cash = cashString;
    
    _stocks = [dictionary objectForKey:@"stocks"];
    _stocksArray = [_stocks allKeys];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //return [_sections objectAtIndex:section];
    return @"Stocks";
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    //return _sections.count;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _stocksArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PortfolioCell";
    MWTPortfolioCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *stock = _stocksArray[indexPath.row];
    NSDictionary *stockInformation = [_stocks objectForKey:stock];
    
//    cell.percentGainLabel.text = [[stockInformation objectForKey:@"percent_gained"] stringValue];
//    cell.symbolLabel.text = stock;
//    cell.sharesLabel.text = [[stockInformation objectForKey:@"shares_owned"] stringValue];
//    cell.totalLabel.text = @"0";
    
    cell.symbolLabel.text = stock;
    cell.percentGainLabel.text = [[stockInformation objectForKey:@"percent_gain"] stringValue];
    cell.sharesLabel.text = [[stockInformation objectForKey:@"shares_owned"] stringValue];
    cell.totalLabel.text = [[stockInformation objectForKey:@"current_value"] stringValue];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell pressed");
}


@end
