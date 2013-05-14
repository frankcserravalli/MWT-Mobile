//
//  MWTDateTimeTransaction.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 5/14/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTDateTimeTransaction.h"

@implementation MWTDateTimeTransaction

- (id) initWith:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self)
    {
        _created_at = [dictionary objectForKey:@"created_at"];
        _execute_at = [dictionary objectForKey:@"execute_at"];
        _transaction_id = [dictionary objectForKey:@"id"];
        _order_type = [dictionary objectForKey:@"order_type"];
        _status = [dictionary objectForKey:@"status"];
        _updated_at = [dictionary objectForKey:@"updated_at"];
        _user_id = [dictionary objectForKey:@"user_id"];
        _user_stock_id = [dictionary objectForKey:@"user_stock_id"];
        _volume = [dictionary objectForKey:@"volume"];
    }
    
    return self;
}

@end
