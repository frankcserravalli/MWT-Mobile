//
//  MWTStockViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/22/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTStockViewController.h"
#import "MWTStockCell.h"
#import "SBJson.h"

@interface MWTStockViewController ()

@end

@implementation MWTStockViewController

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
    
    NSLog(@"Call portfolio");
    [self getPortfolio];
    
//    for (NSString *key in _stocks)
//    {
//        NSLog(@"KEY: %@", key);
//        NSString *value = [_stocks objectForKey:key];
//        
//        NSLog(@"VALUE: %@", value);
//        
//        NSDictionary *subvalues = [_stocks objectForKey:key];
//        NSLog(@"percent_gained:");
//        NSLog([[subvalues objectForKey:@"percent_gain"] stringValue]);
//    }


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}

- (void) parsePortfolio:(NSData *)data
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *portfolio = [parser objectWithData:data];
    
    [self assignValuesFrom:portfolio];
    
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









#pragma mark - Table view data source

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    //return [_sections objectAtIndex:section];
//    return @"Stocks";
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _stocksArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StockCell";
    MWTStockCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *stock = _stocksArray[indexPath.row];
    NSDictionary *stockInformation = [_stocks objectForKey:stock];
    
    cell.symbolLabel.text = stock;
    cell.percentGainLabel.text = [[stockInformation objectForKey:@"percent_gain"] stringValue];
    cell.sharesLabel.text = [[stockInformation objectForKey:@"shares_owned"] stringValue];
    cell.totalLabel.text = [[stockInformation objectForKey:@"current_value"] stringValue];
    

    
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
}

@end
