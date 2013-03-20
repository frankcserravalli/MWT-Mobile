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

@property (nonatomic, strong) NSArray *pending_date_time_transactions;
@property (nonatomic, strong) NSArray *pending_stop_loss_transactions;
@property (nonatomic, strong) NSDictionary *processed_date_time_transactions;
@property (nonatomic, strong) NSDictionary *processed_stop_loss_transactions;

@property (nonatomic, strong) NSDictionary *shorts;
@property (nonatomic, strong) NSDictionary *stocks;
@property (nonatomic, strong) NSArray *stocksArray;
@property (nonatomic, strong) NSArray *stockSymbols;

@property (nonatomic, strong) NSMutableData *responseData;
@property BOOL shouldParsePortfolio;
@property BOOL shouldParsePendingStopLoss;
@property BOOL shouldParsePendingDateTime;

- (void) getPortfolio;
- (void) parsePortfolio:(NSData*)data;
- (void) getPendingDateTimePositions;
- (void) getPendingStopLossPositions;
- (void) parsePendingDateTimePositions:(NSData *)data;
- (void) parsePendingStopLossPositions:(NSData *)data;
- (void) assignValuesFrom:(NSDictionary*)dictionary;
- (void) parseJSON:(NSArray *)array;
- (NSDictionary *)retrieveDictFromJSON:(NSArray *)array At:(NSInteger)index;
- (NSDictionary *)getStockDictionaryFromStock:(NSString *)stockSymbol;
- (void) displayDictionary:(NSDictionary *)dictionary;
- (void) returnTypeOfJSONfrom:(NSData *)data;
- (NSArray *) sortArrayOf:(NSMutableArray *)stocks by:(NSString *)key;
- (void) displayStocksArraySortedBy:(NSString *)key;
- (void) sortStocksBasedOn:(NSString *)key;


@end
