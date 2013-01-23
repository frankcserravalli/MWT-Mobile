//
//  MWTTableViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/17/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTTableViewController.h"
#import "MWTCell.h"
#import "MWTCellDetailViewController.h"
#import "MWTLoginViewController.h"
#import "MWTSignUpViewController.h"
#import "MWTPortfolioViewController.h"
#import "MWTPendingPositionsViewController.h"
#import "MWTProcessedPositionsViewController.h"
#import "MWTUpcomingFuturesViewController.h"
#import "MWTProcessedFuturesViewController.h"
#import "MWTTradeStockViewController.h"
#import "MWTSearchStockViewController.h"
#import "MWTSettingsViewController.h"

@interface MWTTableViewController ()

@end

@implementation MWTTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    _interfaceElements = @[@"Login", @"Sign Up", @"Portfolio", @"Pending Positions", @"Processed Positions", @"Upcoming Future Transcations", @"Processed Future Transactions", @"Trade Stock", @"Search Stock", @"Settings"];
    _interfaceElements = @[@"Login", @"Sign Up", @"Portfolio", @"Settings"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _interfaceElements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"interfaceCell";
    MWTCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSInteger row = indexPath.row;
    
    cell.cellLabel.text = _interfaceElements[row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if (_interfaceElements[indexPath.row] == @"Login")
    {
        [self performSegueWithIdentifier:@"Login" sender:self];
    }
    else if (_interfaceElements[indexPath.row] == @"Sign Up")
    {
        [self performSegueWithIdentifier:@"SignUp" sender:self];

    }
    else if (_interfaceElements[indexPath.row] == @"Portfolio")
    {
        [self performSegueWithIdentifier:@"Portfolio" sender:self];
    }
//    else if (_interfaceElements[indexPath.row] == @"Pending Positions")
//    {
//        [self performSegueWithIdentifier:@"PendingPositions" sender:self];
//    }
//    
//    else if (_interfaceElements[indexPath.row] == @"Processed Positions")
//    {
//        [self performSegueWithIdentifier:@"ProcessedPositions" sender:self];
//    }
//    else if (_interfaceElements[indexPath.row] == @"Upcoming Future Transcations")
//    {
//        [self performSegueWithIdentifier:@"UpcomingFutures" sender:self];
//    }
//    else if (_interfaceElements[indexPath.row] == @"Processed Future Transactions")
//    {
//        [self performSegueWithIdentifier:@"ProcessedFutures" sender:self];
//    }
//    else if (_interfaceElements[indexPath.row] == @"Trade Stock")
//    {
//        [self performSegueWithIdentifier:@"TradeStock" sender:self];
//    }
//    else if (_interfaceElements[indexPath.row] == @"Search Stock")
//    {
//        [self performSegueWithIdentifier:@"SearchStock" sender:self];
//    }
    else if (_interfaceElements[indexPath.row] == @"Settings")
    {
        [self performSegueWithIdentifier:@"Settings" sender:self];
    }
    

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Login"])
    {
        MWTLoginViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger row = [indexPath row];
        
        detailViewController.title = _interfaceElements[row];
    }
    else if ([[segue identifier] isEqualToString:@"SignUp"])
    {
        MWTSignUpViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger row = [indexPath row];
        
        detailViewController.title = _interfaceElements[row];
    }
    else if ([[segue identifier] isEqualToString:@"Portfolio"])
    {
        MWTPortfolioViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger row = [indexPath row];
        
        detailViewController.title = _interfaceElements[row];
    }
    else if ([[segue identifier] isEqualToString:@"PendingPositions"])
    {
        MWTPendingPositionsViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger row = [indexPath row];
        
        detailViewController.title = _interfaceElements[row];
    }
    else if ([[segue identifier] isEqualToString:@"ProcessedPositions"])
    {
        MWTProcessedPositionsViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger row = [indexPath row];
        
        detailViewController.title = _interfaceElements[row];
    }
    else if ([[segue identifier] isEqualToString:@"UpcomingFutures"])
    {
        MWTUpcomingFuturesViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger row = [indexPath row];
        
        detailViewController.title = _interfaceElements[row];
    }
    else if ([[segue identifier] isEqualToString:@"ProcessedFutures"])
    {
        MWTProcessedFuturesViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger row = [indexPath row];
        
        detailViewController.title = _interfaceElements[row];
    }
    else if ([[segue identifier] isEqualToString:@"TradeStock"])
    {
        MWTTradeStockViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger row = [indexPath row];
        
        detailViewController.title = _interfaceElements[row];
    }
    else if ([[segue identifier] isEqualToString:@"SearchStock"])
    {
        MWTSearchStockViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger row = [indexPath row];
        
        detailViewController.title = _interfaceElements[row];
    }
    else if ([[segue identifier] isEqualToString:@"Settings"])
    {
        MWTSettingsViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger row = [indexPath row];
        
        detailViewController.title = _interfaceElements[row];
    }
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    [[self navigationItem] setBackBarButtonItem:backButton];
}



@end
