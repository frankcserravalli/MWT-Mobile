//
//  MWTPortfolioViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/17/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWTPortfolioViewController : UIViewController <UITableViewDelegate ,UITableViewDataSource>
{

}
@property (strong, nonatomic) IBOutlet UILabel *portfolioValue;
@property (strong, nonatomic) IBOutlet UILabel *accountValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *cashLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

//@property (strong, nonatomic) NSDictionary *stocks;
//@property (strong, nonatomic) NSArray *stocksArray;
//@property (strong, nonatomic) NSArray *sections;

@property (strong, nonatomic) NSArray *interfaceElements;

- (void) getPortfolio;
- (void) parsePortfolio:(NSData*)data;
- (void) assignValuesFrom:(NSDictionary*)dictionary;

@end
