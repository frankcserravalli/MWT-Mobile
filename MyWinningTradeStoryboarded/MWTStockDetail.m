//
//  MWTStockDetail.m
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



#import "MWTStockDetail.h"

@implementation MWTStockDetail

- (id) initWith:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self)
    {
        _ask = [dictionary objectForKey:@"ask"];
        _ask_realtime = [dictionary objectForKey:@"ask_realtime"];
        _bid = [dictionary objectForKey:@"bid"];
        _bid_realtime = [dictionary objectForKey:@"bid_realtime"];
        _buy_price = [dictionary objectForKey:@"buy_price"];
        _current_bid = [dictionary objectForKey:@"current_bid"];
        _current_price = [dictionary objectForKey:@"current_price"];
        _currently_trading = [dictionary objectForKey:@"currently_trading"];
        _days_range = [dictionary objectForKey:@"days_range"];
        _dividend_yield = [dictionary objectForKey:@"dividend_yield"];
        _earnings_share = [dictionary objectForKey:@"earnings_share"];
        _eps_estimate_current_year = [dictionary objectForKey:@"eps_estimate_current_year"];
        _eps_estimate_next_quarter = [dictionary objectForKey:@"eps_estimate_next_quarter"];
        _eps_estimate_next_year = [dictionary objectForKey:@"eps_estimate_next_year"];
        _fifty_day_moving_average = [dictionary objectForKey:@"fifty_day_moving_average"];
        _last_trade_date = [dictionary objectForKey:@"last_trade_date"];
        _last_trade_time = [dictionary objectForKey:@"last_trade_time"];
        _name = [dictionary objectForKey:@"name"];
        _open = [dictionary objectForKey:@"open"];
        _pe_ratio = [dictionary objectForKey:@"pe_ratio"];
        _percent_change = [dictionary objectForKey:@"percent_change"];
        _point_change = [dictionary objectForKey:@"point_change"];
        _previous_close = [dictionary objectForKey:@"previous_close"];
        _statements_url = [dictionary objectForKey:@"statements_url"];
        _stock_exchange = [dictionary objectForKey:@"stock_exchange"];
        _symbol = [dictionary objectForKey:@"symbol"];
        _trend_direction = [dictionary objectForKey:@"trend_direction"];
        _two_hundred_day_moving_average = [dictionary objectForKey:@"two_hundred_day_moving_average"];
        _volume = [dictionary objectForKey:@"volume"];
        _year_range = [dictionary objectForKey:@"year_range"];
    }
    
    return self;
}

@end
