//
//  MWTStockDetail.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 5/8/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

/*
 table =     {
 ask = "458.25";
 "ask_realtime" = "458.25";
 bid = "457.93";
 "bid_realtime" = "457.93";
 "buy_price" = "464.25";
 "current_bid" = "457.93";
 "current_price" = "458.25";
 "currently_trading" = 0;
 "days_range" = "453.70 - 465.75";
 "dividend_yield" = "1.73";
 "earnings_share" = "41.896";
 "eps_estimate_current_year" = "39.76";
 "eps_estimate_next_quarter" = "8.25";
 "eps_estimate_next_year" = "44.09";
 "fifty_day_moving_average" = "431.59";
 "last_trade_date" = "5/7/2013";
 "last_trade_time" = "4:00pm";
 name = "Apple Inc.";
 open = "465.24";
 "pe_ratio" = "11.00";
 "percent_change" = "-0.53";
 "point_change" = "-2.46";
 "previous_close" = "460.71";
 "statements_url" = "http://investing.money.msn.com/investments/sec-filings/?symbol=AAPL";
 "stock_exchange" = NasdaqNM;
 symbol = AAPL;
 "trend_direction" = down;
 "two_hundred_day_moving_average" = "505.657";
 volume = 17276868;
 "year_range" = "385.10 - 705.07";
 };
 
 */


#import <Foundation/Foundation.h>

@interface MWTStockDetail : NSObject

@property (strong, nonatomic) NSString *ask;
@property (strong, nonatomic) NSString *ask_realtime;
@property (strong, nonatomic) NSString *bid;
@property (strong, nonatomic) NSString *bid_realtime;
@property (strong, nonatomic) NSString *buy_price;
@property (strong, nonatomic) NSString *current_bid;
@property (strong, nonatomic) NSString *current_price;
@property (strong, nonatomic) NSNumber *currently_trading;
@property (strong, nonatomic) NSString *days_range;
@property (strong, nonatomic) NSString *dividend_yield;
@property (strong, nonatomic) NSString *earnings_share;
@property (strong, nonatomic) NSString *eps_estimate_current_year;
@property (strong, nonatomic) NSString *eps_estimate_next_quarter;
@property (strong, nonatomic) NSString *eps_estimate_next_year;
@property (strong, nonatomic) NSString *fifty_day_moving_average;
@property (strong, nonatomic) NSString *last_trade_date;
@property (strong, nonatomic) NSString *last_trade_time;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *open;
@property (strong, nonatomic) NSString *pe_ratio;
@property (strong, nonatomic) NSString *percent_change;
@property (strong, nonatomic) NSString *point_change;
@property (strong, nonatomic) NSString *previous_close;
@property (strong, nonatomic) NSString *statements_url;
@property (strong, nonatomic) NSString *stock_exchange;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *trend_direction;
@property (strong, nonatomic) NSString *two_hundred_day_moving_average;
@property (strong, nonatomic) NSNumber *volume;
@property (strong, nonatomic) NSString *year_range;

- (id) initWith:(NSDictionary *)dictionary;

@end
