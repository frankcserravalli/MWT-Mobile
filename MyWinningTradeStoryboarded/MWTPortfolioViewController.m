//
//  MWTPortfolioViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/17/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTPortfolioViewController.h"

#import "MWTPortfolioStockCell.h"
#import "MWTPortfolioDateTimeCell.h"
#import "MWTPortfolioShortCell.h"
#import "MWTPortfolioStopLossCell.h"

#import "MWTShortsViewController.h"
#import "MWTPendingDateTimeTransactionsViewController.h"
#import "MWTPendingStopLossTransactionsViewController.h"
#import "MWTStockDetailViewController.h"
#import "MWTBuyNewStockViewController.h"

@interface MWTPortfolioViewController ()

@end

@implementation MWTPortfolioViewController

static const int STOCKS = 0;
static const int SHORTS = 1;
static const int DATE_TIME_POSITIONS = 2;
static const int STOP_LOSS_POSITIONS = 3;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    CGFloat red = 55/255.0f;
    CGFloat green = 70/255.0f;
    CGFloat blue = 87/255.0f;
    [[UITableViewHeaderFooterView appearance] setTintColor:[UIColor colorWithRed:red green:green blue:blue alpha:1.0f]];

    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = background;
        
    _sorterSegmentedControl.tintColor = [UIColor colorWithRed:155/255.0 green:160/255.0 blue:133/255.0 alpha:1];
    
    self.navigationItem.backBarButtonItem.title = @"Logout";
    
    _interfaceElements = @[@"Stocks", @"Shorts", @"Date Time Positions", @"Stop Loss Positions"];
    _tableHeaders = _interfaceElements;
        
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
                                             
                                             _portfolioValue.text = [self abbreviate:_portfolio.current_value];
                                             _accountValueLabel.text = [self abbreviate:_portfolio.account_value];
                                             _cashLabel.text = [self abbreviate:_portfolio.cash];
                                             
                                             [_tableView reloadData];
                                             
                                             _filteredList = [[NSMutableArray alloc] initWithCapacity:_portfolio.stocksArray.count];

                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"%@", error);
                                         }];
    
    [operation start];
    
}

- (void)viewWillAppear:(BOOL)animated
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
                                             
                                             _portfolioValue.text = [self abbreviate:_portfolio.current_value];
                                             _accountValueLabel.text = [self abbreviate:_portfolio.account_value];
                                             _cashLabel.text = [self abbreviate:_portfolio.cash];
                                             
                                             [_tableView reloadData];
                                             
                                             _filteredList = [[NSMutableArray alloc] initWithCapacity:_portfolio.stocksArray.count];
                                             
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"%@", error);
                                         }];
    
    [operation start];
}

- (void) viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Text Label methods
- (NSString *) abbreviate:(NSNumber *)value
{
    const int thousand = 1000;
    const int million = 1000000;
    NSString * roundedValueString = @"";
    
    if (value.doubleValue > thousand)
    {
        int roundedValue = value.intValue / thousand;
        roundedValueString  = [NSString stringWithFormat:@"%i k", roundedValue];
    }
    else if (value.doubleValue > million)
    {
        int roundedValue = value.intValue / million;
        roundedValueString = [NSString stringWithFormat:@"%i m", roundedValue];
    }
    else
    {
        roundedValueString = [NSString stringWithFormat:@"%@", value];
    }
    
    return roundedValueString;
}

#pragma mark - Table View Data Source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 2;
    }
    else
    {
        return _tableHeaders.count;
    }
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        if (section == 0)
        {
            return @"Your stocks";
        }
        else
        {
            return @"Purchase stock";
        }
    }
    else
    {
        return _tableHeaders[section];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        if (section == 0)
        {
            return [self.filteredList count];
        }
        else
        {
            return 1;
        }
    }
    else
    {
        if (section == STOCKS)
        {
            if (_portfolio.stocksArray.count == 0) return 1;
            return _portfolio.stocksArray.count;
        }
        else if (section == SHORTS)
        {
            if (_portfolio.shorts.allKeys.count == 0) return 1;
            return [[[_portfolio shorts] allKeys] count];
        }
        else if (section == DATE_TIME_POSITIONS)
        {
            if (_portfolio.pending_date_time_transactions.count == 0) return 1;
            return _portfolio.pending_date_time_transactions.count;
        }
        else if (section == STOP_LOSS_POSITIONS)
        {
            if (_portfolio.pending_stop_loss_transactions.count == 0) return 1;
            return _portfolio.pending_stop_loss_transactions.count;
        }
        else
        {
            return 1;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"PortfolioStockCell";
//    MWTPortfolioStockCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (tableView == self.searchDisplayController.searchResultsTableView)
//    {
//        if (indexPath.section == 0)
//        {
//            cell.symbolLabel.text = [_filteredList objectAtIndex:indexPath.row];
//            cell.percentGainLabel.hidden = YES;
//            cell.sharesLabel.hidden = YES;
//            cell.sharesLabelText.hidden = YES;
//            cell.priceLabel.hidden = YES;
//        }
//        else
//        {
//            cell.symbolLabel.text = self.searchDisplayController.searchBar.text.uppercaseString;
//            cell.percentGainLabel.hidden = YES;
//            cell.sharesLabel.hidden = YES;
//            cell.sharesLabelText.hidden = YES;
//            cell.priceLabel.hidden = YES;
//        }
//    }
//    else
//    {
//        if (indexPath.section == STOCKS)
//        {            
//            MWTStock *stockAtIndexPath = [_portfolio.stocksArray objectAtIndex:indexPath.row];
//
//            cell.symbolLabel.text = stockAtIndexPath.symbol;
//            cell.percentGainLabel.text = [stockAtIndexPath.percent_gain stringValue];
//            cell.sharesLabel.text = [stockAtIndexPath.shares_owned stringValue];
//            cell.priceLabel.text = [stockAtIndexPath.current_value stringValue];
//
//        }
//        else if (indexPath.section == SHORTS)
//        {
//            cell.symbolLabel.text = @"shorts";
//        }
//        else if (indexPath.section == DATE_TIME_POSITIONS)
//        {
////            NSDictionary *date_timeDict = [_portfolio retrieveDictFromJSON:_portfolio.pending_date_time_transactions At:indexPath.row];
////            cell.symbolLabel.text = [date_timeDict objectForKey:@"created_at"];
//            if (_portfolio.pending_date_time_transactions.count == 0)
//            {
////                cell.symbolLabel.textColor = [UIColor grayColor];
//                cell.symbolLabel.text = @"No pending date time positions";
//            }
//            else
//            {
//                cell.symbolLabel.text =  @"Test";
//            }
//            cell.percentGainLabel.hidden = YES;
//            cell.sharesLabel.hidden = YES;
//            cell.priceLabel.hidden = YES;
//            cell.sharesLabelText.hidden = YES;
//        }
//        else if (indexPath.section == STOP_LOSS_POSITIONS)
//        {
//            NSDictionary *stop_lossDict = [_portfolio retrieveDictFromJSON:_portfolio.pending_stop_loss_transactions At:indexPath.row];
//            cell.symbolLabel.text = [stop_lossDict objectForKey:@"created_at"];
//            
//            cell.percentGainLabel.hidden = YES;
//            cell.sharesLabel.hidden = YES;
//            cell.priceLabel.hidden = YES;
//            cell.sharesLabelText.hidden = YES;
//
//        }
//    }
//    
//    return cell;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        static NSString *CellIdentifier = @"PortfolioStockCell";
        MWTPortfolioStockCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (indexPath.section == 0)
        {
            if (_portfolio.stocksArray.count == 0)
            {
                cell.symbolLabel.text = @"Your portfolio is empty";
            }
            else
            {
                cell.symbolLabel.text = [_filteredList objectAtIndex:indexPath.row];
                cell.sharesAttributeLabel.hidden = YES;
                cell.sharesLabel.hidden = YES;
                cell.priceLabel.hidden = YES;
                cell.sharesLabelText.hidden = YES;
                cell.percentGainLabel.hidden = YES;
            }
        }
        else
        {
            cell.symbolLabel.text = self.searchDisplayController.searchBar.text.uppercaseString;
            cell.sharesAttributeLabel.hidden = YES;
            cell.sharesLabel.hidden = YES;
            cell.priceLabel.hidden = YES;
            cell.sharesLabelText.hidden = YES;
            cell.percentGainLabel.hidden = YES;
        }
            
        return cell;
    }
    else
    {
        if (indexPath.section == STOCKS)
        {
            static NSString *CellIdentifier = @"PortfolioStockCell";
            MWTPortfolioStockCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (_portfolio.stocksArray.count == 0)
            {
                cell.symbolLabel.textColor = [UIColor grayColor];
                cell.symbolLabel.text = @"No stocks in your portfolio";
                
                cell.percentGainLabel.hidden = YES;
                cell.sharesLabel.hidden = YES;
                cell.priceLabel.hidden = YES;
                cell.sharesAttributeLabel.hidden = YES;
                
            }
            else
            {
                MWTStock *stockAtIndexPath = [_portfolio.stocksArray objectAtIndex:indexPath.row];
                
                cell.symbolLabel.text = stockAtIndexPath.symbol;
                cell.percentGainLabel.text = [stockAtIndexPath.percent_gain stringValue];
                cell.sharesLabel.text = [stockAtIndexPath.shares_owned stringValue];
                cell.priceLabel.text = [stockAtIndexPath.current_value stringValue];
                
                cell.symbolLabel.textColor = [UIColor blackColor];
                cell.percentGainLabel.hidden = NO;
                cell.sharesLabel.hidden = NO;
                cell.priceLabel.hidden = NO;
                cell.sharesAttributeLabel.hidden = NO;
                

            }
            
            return cell;
        }
        else if (indexPath.section == SHORTS)
        {
            static NSString *CellIdentifier = @"PortfolioShortCell";
            MWTPortfolioShortCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (_portfolio.shorts.allKeys.count == 0)
            {
                cell.cellTitle.textColor = [UIColor grayColor];
                cell.cellTitle.text = @"No shorts";
            }
            else
            {
                cell.cellTitle.text = @"Short";
            }
            
            return cell;
        }
        else if (indexPath.section == DATE_TIME_POSITIONS)
        {
            static NSString *CellIdentifier = @"PortfolioDateTimeCell";
            MWTPortfolioDateTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (_portfolio.pending_date_time_transactions.count == 0)
            {
                cell.cellTitle.textColor = [UIColor grayColor];
                cell.cellTitle.text = @"No pending date time positions";
            }
            else
            {
                MWTDateTimeTransaction *dateTimeAtIndexPath = [_portfolio.pending_date_time_transactions objectAtIndex:indexPath.row];
                
                cell.cellTitle.textColor = [UIColor blackColor];
                cell.cellTitle.text =  dateTimeAtIndexPath.created_at;
            }

            return cell;
        }
        else if (indexPath.section == STOP_LOSS_POSITIONS)
        {
            static NSString *CellIdentifier = @"PortfolioStopLossCell";
            MWTPortfolioStopLossCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (_portfolio.pending_stop_loss_transactions.count == 0)
            {
                cell.cellTitle.textColor = [UIColor grayColor];
                cell.cellTitle.text = @"No stop loss positions";
            }
            else
            {
                MWTStopLossTransaction *stopLossAtIndexPath = [_portfolio.pending_stop_loss_transactions objectAtIndex:indexPath.row];
                cell.cellTitle.text = stopLossAtIndexPath.created_at;
                cell.cellTitle.textColor = [UIColor blackColor];

            }
            
            return cell;
        }
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        if (indexPath.section == 0)
        {
            MWTPortfolioStockCell *cell = (MWTPortfolioStockCell *)[tableView cellForRowAtIndexPath:indexPath];
            NSString *stockSymbol = cell.symbolLabel.text.uppercaseString;
            MWTStock *stockForSymbol = [_portfolio fetchStockFromSymbol:stockSymbol];
            
            [self performSegueWithIdentifier:@"StockDetails" sender:stockForSymbol];
        }
        else if (indexPath.section == 1)
        {
            MWTPortfolioStockCell *cell = (MWTPortfolioStockCell *)[tableView cellForRowAtIndexPath:indexPath];
            NSString *stockSymbol = cell.symbolLabel.text.uppercaseString;
            [self performSegueWithIdentifier:@"BuyNewStock" sender:stockSymbol];
        }
    }
    else
    {
        if (indexPath.section == STOCKS)
        {
            MWTStock *stockAtIndexPath = nil;
            if (_portfolio.stocksArray.count > 0)
            {
                stockAtIndexPath = [_portfolio.stocksArray objectAtIndex:indexPath.row];
                [self performSegueWithIdentifier:@"StockDetails" sender:stockAtIndexPath];
            }
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
    if ([[segue identifier] isEqualToString:@"Shorts"])
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
                        
        MWTStock *stock = (MWTStock *)sender;
        detailViewController.title = stock.symbol;
        detailViewController.stock = stock;
    }
    else if ([segue.identifier isEqualToString:@"BuyNewStock"])
    {
        MWTBuyNewStockViewController *destinationViewController = segue.destinationViewController;
        NSString *stockSymbol = (NSString *)sender;
        destinationViewController.title = stockSymbol;
        destinationViewController.portfolio = _portfolio;
        
        if (destinationViewController.view)
        {
            destinationViewController.companyName.text = stockSymbol;
            destinationViewController.cash.text = [_portfolio.cash stringValue];
        }
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
