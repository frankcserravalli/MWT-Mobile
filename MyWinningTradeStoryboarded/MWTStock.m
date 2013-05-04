//
//  MWTStock.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/23/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTStock.h"

@implementation MWTStock


- (void) getStockDetailsForStock:(NSString *)symbol
{    
    NSString *stockDetailURLString = [NSString stringWithFormat:@"http://%@/api/v1/stocks/details?symbol=%@", serverURL, symbol];
    NSURL *stockDetailURL = [NSURL URLWithString:stockDetailURLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:stockDetailURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    [self parseStock:response];
}

- (void) parseStock:(NSData *)data
{
    NSError *error;
    NSDictionary *stockJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSDictionary *stockDetails = [stockJSON objectForKey:@"table"];
    _stockDetails = stockDetails;
}


@end
