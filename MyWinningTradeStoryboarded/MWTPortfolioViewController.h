//
//  MWTPortfolioViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/17/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWTPortfolio.h"
#import "AFNetworking.h"
#import "MWTAPIClient.h"

@interface MWTPortfolioViewController : UIViewController <UITableViewDelegate ,UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>
{

}
@property (strong, nonatomic) IBOutlet UILabel *portfolioValue;
@property (strong, nonatomic) IBOutlet UILabel *accountValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *cashLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sorterSegmentedControl;

@property (strong, nonatomic) NSArray *interfaceElements;
@property (strong, nonatomic) NSArray *tableHeaders;
@property (strong, nonatomic) NSMutableArray *filteredList;

@property (strong, nonatomic) MWTPortfolio *portfolio;

@property (strong, nonatomic) NSNumberFormatter *numberToCurrencyConverter;

- (IBAction)sort:(id)sender;
- (IBAction)segmentedControlSorter:(id)sender;

@end
