//
//  MWTStock.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/23/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTStock.h"

@implementation MWTStock


//- (void) getStockDetailsForStock:(NSString *)symbol
//{    
//    NSString *stockDetailURLString = [NSString stringWithFormat:@"http://%@/api/v1/stocks/details?symbol=%@", serverURL, symbol];
//    NSURL *stockDetailURL = [NSURL URLWithString:stockDetailURLString];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:stockDetailURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//    [request setHTTPMethod:@"GET"];
//    NSError *requestError;
//    NSURLResponse *urlResponse = nil;
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
//    
//    [self parseStock:response];
//}
//
//- (void) parseStock:(NSData *)data
//{
//    NSError *error;
//    NSDictionary *stockJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//    NSDictionary *stockDetails = [stockJSON objectForKey:@"table"];
//    _stockDetails = stockDetails;
//}

- (id) initWith:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self)
    {
        _name = (NSString *)[dictionary objectForKey:@"name"];
        _current_price = (NSNumber *)[dictionary objectForKey:@"current_price"];
        _shares_owned = (NSNumber *)[dictionary objectForKey:@"shares_owned"];
        _current_value = (NSNumber *)[dictionary objectForKey:@"current_value"];
        _cost_basis = (NSNumber *)[dictionary objectForKey:@"cost_basis"];
        _capital_gain = (NSNumber *)[dictionary objectForKey:@"capital_gain"];
        _percent_gain = (NSNumber *)[dictionary objectForKey:@"percent_gain"];
    }
    
    return self;
}


@end
