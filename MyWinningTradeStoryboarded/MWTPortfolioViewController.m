//
//  MWTPortfolioViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/17/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTPortfolioViewController.h"
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

    NSLog(@"Call portfolio");
    [self getPortfolio];
   
    _portfolioValue.text = _totalValue;
    _accountValueLabel.text = _accountValue;
    _cashLabel.text = _cash;
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
    
    NSString *valueString = [[portfolio objectForKey:@"current_value"] stringValue];
    NSString *accountValueString = [[portfolio objectForKey:@"account_value"] stringValue];
    NSString *cashString = [[portfolio objectForKey:@"cash"] stringValue];

    _totalValue = valueString;
    _accountValue = accountValueString;
    _cash = cashString;
    
    _sections = [portfolio allKeys];
    
        for (NSString *key in portfolio)
        {
            NSLog(@"KEY: %@", key);
            NSString *value = [portfolio objectForKey:key];
    
            NSLog(@"VALUE: %@", value);
        }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_sections objectAtIndex:section];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PortfolioCell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = @"Test";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell pressed");
}


@end
