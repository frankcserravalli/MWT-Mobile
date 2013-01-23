//
//  MWTStock.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/23/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWTPortfolio.h"

@interface MWTStock : NSObject

@property (strong, nonatomic) MWTPortfolio *portfolio;
@property (strong, nonatomic) NSDictionary *stockInformation;

@property (strong, nonatomic) NSString *stockSymbol;
@property (strong, nonatomic) NSString *companyName;

@property (strong, nonatomic) NSNumber *capital_gain;
@property (strong, nonatomic) NSNumber *cost_basis;
@property (strong, nonatomic) NSNumber *current_price;
@property (strong, nonatomic) NSNumber *current_value;
@property (strong, nonatomic) NSNumber *percent_gain;
@property (strong, nonatomic) NSNumber *shares_owned;

- (void) parsePortfolioForStock:(NSString *)stockName;

@end
