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
#import "MWTPortfolio.h"
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
        
    MWTPortfolio *portfolio = [[MWTPortfolio alloc] init];
   
    _portfolioValue.text = [[portfolio current_value] stringValue];
    
    _accountValueLabel.text = [[portfolio account_value] stringValue];

    _cashLabel.text = [[portfolio cash] stringValue];
    
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
