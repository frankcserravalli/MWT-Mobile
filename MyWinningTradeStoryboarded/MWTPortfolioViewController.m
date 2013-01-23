//
//  MWTPortfolioViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/17/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTPortfolioViewController.h"
#import "MWTPortfolioCell.h"
#import "MWTStockViewController.h"
#import "MWTShortsViewController.h"
#import "SBJson.h"

@interface MWTPortfolioViewController ()

@end

@implementation MWTPortfolioViewController

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
    
    _interfaceElements = @[@"Stocks", @"Shorts", @"Pending Date Time Transactions", @"Pending Stop Loss Transactions", @"Processed Date Time Transactions", @"Processed Stop Loss Transactions"];
    
    NSLog(@"Call portfolio");
    [self getPortfolio];
   
    _portfolioValue.text = _totalValue;
    _accountValueLabel.text = _accountValue;
    _cashLabel.text = _cash;
    
}

- (void) getPortfolio
{
    int user_id = 1;
    NSString *portfolioURLString = [NSString stringWithFormat:@"http://%@/api/v1/users/portfolio?user_id=%i", serverURL, user_id];
    NSURL *portfolioURL = [NSURL URLWithString:portfolioURLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:portfolioURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    [self parsePortfolio:response];
}

- (void) parsePortfolio:(NSData *)data
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *portfolio = [parser objectWithData:data];
    
    [self assignValuesFrom:portfolio];
    
    _sections = [portfolio allKeys];
    
//    for (NSString *key in portfolio)
//    {
//        NSLog(@"KEY: %@", key);
//        NSString *value = [portfolio objectForKey:key];
//        NSLog(@"VALUE: %@", value);
//    }
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


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    //return _sections.count;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _interfaceElements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PortfolioCell";
    MWTPortfolioCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.symbolLabel.text = _interfaceElements[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell %i pressed", indexPath.row);
    if (_interfaceElements[indexPath.row] == @"Stocks")
    {
        [self performSegueWithIdentifier:@"Stocks" sender:self];
    }
    else if (_interfaceElements[indexPath.row] == @"Shorts")
    {
        [self performSegueWithIdentifier:@"Shorts" sender:self];
    }
    else if (_interfaceElements[indexPath.row] == @"Pending Date Time Transactions")
    {
        NSLog(_interfaceElements[indexPath.row]);
    }
    else if (_interfaceElements[indexPath.row] == @"Pending Stop Loss Transactions")
    {
        NSLog(_interfaceElements[indexPath.row]);
    }
    else if (_interfaceElements[indexPath.row] == @"Processed Date Time Transactions")
    {
        NSLog(_interfaceElements[indexPath.row]);
    }
    else if (_interfaceElements[indexPath.row] == @"Processed Stop Loss Transactions")
    {
        NSLog(_interfaceElements[indexPath.row]);
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Stocks"])
    {
        NSLog(@"Segue performed");
        MWTStockViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger row = [indexPath row];
        
        detailViewController.title = _interfaceElements[row];
    }
    else if ([[segue identifier] isEqualToString:@"Shorts"])
    {
        MWTShortsViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger row = [indexPath row];
        
        detailViewController.title = _interfaceElements[row];
    }
    else
    {
        NSLog(@"Undefined segue");
    }
}

@end
