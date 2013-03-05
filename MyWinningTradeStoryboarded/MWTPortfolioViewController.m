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
#import "MWTPortfolioSingleton.h"
#import "MWTPendingDateTimeTransactionsViewController.h"
#import "MWTPendingStopLossTransactionsViewController.h"
#import "MWTStockDetailViewController.h"

@interface MWTPortfolioViewController ()

@end

@implementation MWTPortfolioViewController

static const int STOCKS = 0;
static const int SHORTS = 1;
static const int DATE_TIME_POSITIONS = 2;
static const int STOP_LOSS_POSITIONS = 3;

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
    
    _interfaceElements = @[@"Stocks", @"Shorts", @"Date Time Positions", @"Stop Loss Positions"];
    _tableHeaders = _interfaceElements;
        
    MWTPortfolioSingleton *portfolioSingleton = [MWTPortfolioSingleton sharedInstance];
    _portfolioValue.text = [[[portfolioSingleton userPortfolio] current_value] stringValue];
    _accountValueLabel.text = [[[portfolioSingleton userPortfolio] account_value] stringValue];
    _cashLabel.text = [[[portfolioSingleton userPortfolio] account_value] stringValue];
    
    _portfolio = [portfolioSingleton userPortfolio];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _tableHeaders.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == STOCKS)
    {
        return [[[_portfolio stocks] allKeys] count];
    }
    else if (section == SHORTS)
    {
        return [[[_portfolio shorts] allKeys] count];
    }
    else if (section == DATE_TIME_POSITIONS)
    {
        return [[_portfolio pending_date_time_transactions] count];
    }
    else if (section == STOP_LOSS_POSITIONS)
    {
        return [[_portfolio pending_stop_loss_transactions] count];
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PortfolioCell";
    MWTPortfolioCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
//    cell.symbolLabel.text = _interfaceElements[indexPath.row];
    if (indexPath.section == STOCKS)
    {
        cell.symbolLabel.text = _portfolio.stockSymbols[indexPath.row];
    }
    else if (indexPath.section == SHORTS)
    {
        cell.symbolLabel.text = @"shorts";
    }
    else if (indexPath.section == DATE_TIME_POSITIONS)
    {
        NSDictionary *date_timeDict = [_portfolio retrieveDictFromJSON:_portfolio.pending_date_time_transactions At:indexPath.row];
        cell.symbolLabel.text = [date_timeDict objectForKey:@"created_at"];
    }
    else if (indexPath.section == STOP_LOSS_POSITIONS)
    {
        NSDictionary *stop_lossDict = [_portfolio retrieveDictFromJSON:_portfolio.pending_stop_loss_transactions At:indexPath.row];
        cell.symbolLabel.text = [stop_lossDict objectForKey:@"created_at"];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _tableHeaders[section];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell %i pressed", indexPath.row);
//    if (_interfaceElements[indexPath.row] == @"Stocks")
//    {
//        [self performSegueWithIdentifier:@"Stocks" sender:self];
//    }
//    else if (_interfaceElements[indexPath.row] == @"Shorts")
//    {
//        [self performSegueWithIdentifier:@"Shorts" sender:self];
//    }
//    else if (_interfaceElements[indexPath.row] == @"Date Time Positions")
//    {
////        NSLog(_interfaceElements[indexPath.row]);
//        [self performSegueWithIdentifier:@"PendingDateTimeTransactions" sender:self];
//    }
//    else if (_interfaceElements[indexPath.row] == @"Stop Loss Positions")
//    {
////        NSLog(_interfaceElements[indexPath.row]);
//        [self performSegueWithIdentifier:@"PendingStopLossTransactions" sender:self];
//    }
    
    if (indexPath.section == STOCKS)
    {
        [self performSegueWithIdentifier:@"StockDetails" sender:self];
    }
    else if (indexPath.section == SHORTS)
    {
        [self performSegueWithIdentifier:@"Shorts" sender:self];
    }
    else if (indexPath.section == DATE_TIME_POSITIONS)
    {
        [self performSegueWithIdentifier:@"PendingDateTimeTransactions" sender:self];
    }
    else if (indexPath.section == STOP_LOSS_POSITIONS)
    {
        [self performSegueWithIdentifier:@"PendingStopLossTransactions" sender:self];
    }
    else
    {
        
    }
}

#pragma mark - Segue

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
    else if ([[segue identifier] isEqualToString:@"PendingDateTimeTransactions"])
    {
        MWTPendingDateTimeTransactionsViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger row = [indexPath row];
        
        detailViewController.title = _interfaceElements[row];
    }
    else if ([[segue identifier] isEqualToString:@"PendingStopLossTransactions"])
    {
        MWTPendingStopLossTransactionsViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger row = [indexPath row];
        
        detailViewController.title = _interfaceElements[row];
    }
    else if ([[segue identifier] isEqualToString:@"StockDetails"])
    {
        MWTStockDetailViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSString *stockSymbol = [[_portfolio stockSymbols] objectAtIndex:indexPath.row];
        detailViewController.title = stockSymbol;
    }
    else
    {
        NSLog(@"Undefined segue");
    }
}

@end
