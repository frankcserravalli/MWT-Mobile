//
//  MWTStock.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/23/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTStock.h"

@implementation MWTStock

- (void) parsePortfolioForStock:(NSString *)stockName
{
    _portfolio = [[MWTPortfolio alloc] init];
    _stockInformation = [[_portfolio stocks] objectForKey:stockName];
    
    _stockSymbol = stockName;
    _companyName = [_stockInformation objectForKey:@"name"];
    
    _capital_gain = [_stockInformation objectForKey:@"capital_gain"];
    _cost_basis = [_stockInformation objectForKey:@"cost_basis"];
    _current_price = [_stockInformation objectForKey:@"current_price"];
    _current_value = [_stockInformation objectForKey:@"current_value"];
    _percent_gain = [_stockInformation objectForKey:@"percent_gain"];
    _shares_owned = [_stockInformation objectForKey:@"shares_owned"];
}

@end
