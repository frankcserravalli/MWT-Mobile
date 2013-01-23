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

@property (strong, nonatomic) NSArray *interfaceElements;

@end
