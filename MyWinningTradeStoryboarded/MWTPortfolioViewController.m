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
    
    CGFloat red = 55/255.0f;
    CGFloat green = 70/255.0f;
    CGFloat blue = 87/255.0f;
    [[UITableViewHeaderFooterView appearance] setTintColor:[UIColor colorWithRed:red green:green blue:blue alpha:1.0f]];
	// Do any additional setup after loading the view.
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = background;
    
    self.tableView.dataSource = self;
    
    _interfaceElements = @[@"Stocks", @"Shorts", @"Date Time Positions", @"Stop Loss Positions"];
    _tableHeaders = _interfaceElements;
        
    MWTPortfolioSingleton *portfolioSingleton = [MWTPortfolioSingleton sharedInstance];
    
    _portfolioValue.text = [[[portfolioSingleton userPortfolio] current_value] stringValue];
    _accountValueLabel.text = [[[portfolioSingleton userPortfolio] account_value] stringValue];
    _cashLabel.text = [[[portfolioSingleton userPortfolio] account_value] stringValue];
    
    _portfolio = [portfolioSingleton userPortfolio];
    _filteredList = [[NSMutableArray alloc] initWithCapacity:_portfolio.stockSymbols.count];
    
    _sorterSegmentedControl.tintColor = [UIColor colorWithRed:155/255.0 green:160/255.0 blue:133/255.0 alpha:1];
    
    self.navigationItem.backBarButtonItem.title = @"Logout";
}

- (void)viewWillAppear:(BOOL)animated
{
    MWTPortfolioSingleton *portfolioSingleton = [MWTPortfolioSingleton sharedInstance];
    _portfolioValue.text = [[[portfolioSingleton userPortfolio] current_value] stringValue];
    _accountValueLabel.text = [[[portfolioSingleton userPortfolio] account_value] stringValue];
    _cashLabel.text = [[[portfolioSingleton userPortfolio] account_value] stringValue];
//
//    _portfolio = [portfolioSingleton userPortfolio];
//    _filteredList = [[NSMutableArray alloc] initWithCapacity:_portfolio.stockSymbols.count];
}

- (void) viewDidAppear:(BOOL)animated
{
//    _tableView.bounds = CGRectMake(0, self.searchDisplayController.searchBar.frame.size.height, 320, self.tableView.frame.size.height);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 1;
    }
    else
    {
        return _tableHeaders.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.filteredList count];
    }
    else
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PortfolioCell";
//    MWTPortfolioCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    MWTPortfolioCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"PortfolioCell"];
    
    // Configure the cell...
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.symbolLabel.text = [_filteredList objectAtIndex:indexPath.row];
        cell.percentGainLabel.hidden = YES;
        cell.sharesLabel.hidden = YES;
        cell.sharesLabelText.hidden = YES;
        cell.priceLabel.hidden = YES;
    }
    else
    {
        if (indexPath.section == STOCKS)
        {
            NSString *currentStockSymbol = _portfolio.stockSymbols[indexPath.row];
            NSDictionary *currentStockDictionary = [_portfolio getStockDictionaryFromStock:currentStockSymbol];
            cell.symbolLabel.text = currentStockSymbol;
            cell.percentGainLabel.text = [[currentStockDictionary objectForKey:@"percent_gain"] stringValue];
            cell.sharesLabel.text = [[currentStockDictionary objectForKey:@"shares_owned"] stringValue];
            cell.priceLabel.text = [[currentStockDictionary objectForKey:@"current_value"] stringValue];

        }
        else if (indexPath.section == SHORTS)
        {
            cell.symbolLabel.text = @"shorts";
        }
        else if (indexPath.section == DATE_TIME_POSITIONS)
        {
            NSDictionary *date_timeDict = [_portfolio retrieveDictFromJSON:_portfolio.pending_date_time_transactions At:indexPath.row];
            cell.symbolLabel.text = [date_timeDict objectForKey:@"created_at"];
            
            cell.percentGainLabel.hidden = YES;
            cell.sharesLabel.hidden = YES;
            cell.priceLabel.hidden = YES;
            cell.sharesLabelText.hidden = YES;
            
        }
        else if (indexPath.section == STOP_LOSS_POSITIONS)
        {
            NSDictionary *stop_lossDict = [_portfolio retrieveDictFromJSON:_portfolio.pending_stop_loss_transactions At:indexPath.row];
            cell.symbolLabel.text = [stop_lossDict objectForKey:@"created_at"];
            
            cell.percentGainLabel.hidden = YES;
            cell.sharesLabel.hidden = YES;
            cell.priceLabel.hidden = YES;
            cell.sharesLabelText.hidden = YES;

        }
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
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        MWTPortfolioCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"StockDetails" sender:cell.symbolLabel.text];
        NSLog(cell.symbolLabel.text);
    }
    else
    {
        if (indexPath.section == STOCKS)
        {
            MWTPortfolioCell *cell = [tableView cellForRowAtIndexPath:indexPath];

            [self performSegueWithIdentifier:@"StockDetails" sender:cell.symbolLabel.text];
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
//            detailViewController.title = stockSymbol;
        detailViewController.title = sender;
    }
    else
    {
        NSLog(@"Undefined segue");
    }
}

- (IBAction)sort:(id)sender
{
//    [_portfolio displayStocksArraySortedBy:@"shares_owned"];
    float yOffset = 100.0f;
//     _tableView.frame.origin.y - yOffset
    _tableView.frame = CGRectMake(_tableView.frame.origin.x, 0, _tableView.frame.size.width, _tableView.frame.size.height);
}

- (IBAction)segmentedControlSorter:(id)sender
{
    switch (self.sorterSegmentedControl.selectedSegmentIndex) {
        case 0:
//            [_portfolio displayStocksArraySortedBy:@"symbol"];
            [_portfolio sortStocksBasedOn:@"symbol"];
            [self.tableView reloadData];
            break;
        case 1:
//            [_portfolio displayStocksArraySortedBy:@"shares_owned"];
            [_portfolio sortStocksBasedOn:@"shares_owned"];
            [self.tableView reloadData];
            break;
        case 2:
//            [_portfolio displayStocksArraySortedBy:@"percent_gain"];
            [_portfolio sortStocksBasedOn:@"percent_gain"];
            [self.tableView reloadData];
            break;
        case 3:
//            [_portfolio displayStocksArraySortedBy:@"current_value"];
            [_portfolio sortStocksBasedOn:@"current_value"];
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}

#pragma mark - Content Filtering
- (void) filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
//    [_filteredList removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchText];
    
    _filteredList = [_portfolio.stockSymbols filteredArrayUsingPredicate:predicate];
}

#pragma mark - UISearchDisplayController Delegate
- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    return YES;
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
//MOVE UI ELEMENTS UP HERE
//    CGRect oldBounds = searchBar.bounds;
    float yOffset = 100.0f;
//    _tableView.frame = CGRectMake(_tableView.frame.origin.x, 0, _tableView.frame.size.width, _tableView.frame.size.height);
}

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
//_tableView.frame = CGRectMake(_tableView.frame.origin.x, 0, _tableView.frame.size.width, _tableView.frame.size.height);
}
@end
