//
//  MWTStockViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/22/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWTStockViewController : UITableViewController

@property (strong, nonatomic) NSString *totalValue;
@property (strong, nonatomic) NSString *cash;
@property (strong, nonatomic) NSString *accountValue;

@property (strong, nonatomic) NSDictionary *stocks;
@property (strong, nonatomic) NSString *stockSymbol;
@property (strong, nonatomic) NSArray *stocksArray;
@property (strong, nonatomic) NSArray *sections;

- (void) getPortfolio;
- (void) parsePortfolio:(NSData*)data;
- (void) assignValuesFrom:(NSDictionary*)dictionary;


@end
