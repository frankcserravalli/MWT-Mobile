//
//  MWTPortfolio.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/23/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWTPortfolio : NSObject

@property (nonatomic, strong) NSNumber *account_value;
@property (nonatomic, strong) NSNumber *cash;
@property (nonatomic, strong) NSNumber *current_value;
@property (nonatomic, strong) NSNumber *percent_gain;
@property (nonatomic, strong) NSNumber *purchase_value;

@property (nonatomic, strong) NSDictionary *pending_date_time_transactions;
@property (nonatomic, strong) NSDictionary *pending_stop_loss_transactions;
@property (nonatomic, strong) NSDictionary *processed_date_time_transactions;
@property (nonatomic, strong) NSDictionary *processed_stop_loss_transactions;

@property (nonatomic, strong) NSDictionary *shorts;
@property (nonatomic, strong) NSDictionary *stocks;
@property (nonatomic, strong) NSArray *stockSymbols;


- (void) getPortfolio;
- (void) parsePortfolio:(NSData*)data;
- (void) assignValuesFrom:(NSDictionary*)dictionary;
- (NSDictionary *)getStockDictionaryFromStock:(NSString *)stockSymbol;

@end
