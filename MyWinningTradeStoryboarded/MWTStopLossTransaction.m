//
//  MWTDateTimeTransaction.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 5/14/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTStopLossTransaction.h"

@implementation MWTStopLossTransaction


- (id) initWith:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self)
    {
        _created_at = [dictionary objectForKey:@"created_at"];
        _executed_at = [dictionary objectForKey:@"executed_at"];
        _transaction_id = [dictionary objectForKey:@"id"];
        _measure = [dictionary objectForKey:@"measure"];
        _order_type = [dictionary objectForKey:@"order_type"];
        _price_target = [dictionary objectForKey:@"price_target"];
        _status = [dictionary objectForKey:@"status"];
        _updated_at = [dictionary objectForKey:@"updated_at"];
        _user_id = [dictionary objectForKey:@"user_id"];
        _user_stock_id = [dictionary objectForKey:@"user_stock_id"];
        _volume = [dictionary objectForKey:@"volume"];
    }
    
    return self;
}


@end
